package main

import (
	"context"
	"io"
	"net"
	"runtime"
	"sync"
	"syscall"
	"time"

	"github.com/ProtonMail/gopenpgp/v2/crypto"

	"github.com/mattgonewild/brutus/decrypt/proto"
	brutus "github.com/mattgonewild/brutus/proto/go"

	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"

	lane "github.com/oleiade/lane/v2"
)

type DecryptServer struct {
	proto.UnimplementedDecryptServer
	opsCh        chan<- bool
	mu           sync.RWMutex
	target       *crypto.PGPMessage
	Permutations *lane.Queue[*brutus.Permutation]
}

func NewDecryptServer(opsCh chan bool) *DecryptServer {
	return &DecryptServer{
		opsCh:        opsCh,
		Permutations: lane.NewQueue[*brutus.Permutation](),
	}
}

func ListenAndServeAPI(shutdownCtx context.Context, config *Config, api *DecryptServer) {
	// initialize grpc server
	grpcServer := grpc.NewServer()

	// register services
	proto.RegisterDecryptServer(grpcServer, api)

	// start grpc server
	go func() {
		lis, err := net.Listen("tcp", config.ListenAndServeAPIAddr)
		if err != nil {
			logger.Fatal("failed to listen", zap.Error(err))
		}
		if err := grpcServer.Serve(lis); err != nil {
			logger.Fatal("failed to serve", zap.Error(err))
		}
	}()

	<-shutdownCtx.Done()

	// attempt to gracefully shutdown the server
	ctx, cancel := context.WithTimeout(context.Background(), config.ListenAndServeAPIMaxShutdownTime)
	defer cancel()

	done := make(chan bool)

	go func() {
		grpcServer.GracefulStop()
		close(done)
	}()

	select {
	case <-ctx.Done():
		logger.Warn("exceeded ListenAndServeAPIMaxShutdownTime: graceful shutdown failed")
		grpcServer.Stop()
	case <-done:
		return
	}
}

func (s *DecryptServer) QueueWorker(ctx context.Context, wg *sync.WaitGroup, out chan *brutus.Result) {
	defer wg.Done()
	for {
		select {
		case <-ctx.Done():
			return
		default:
			if s.target == nil {
				time.Sleep(1 * time.Second)
				continue
			}
			perm, ok := s.Permutations.Dequeue()
			if !ok {
				continue
			}
			s.mu.RLock()
			_, err := crypto.DecryptMessageWithPassword(s.target, perm.Value)
			s.mu.RUnlock()
			if err != nil {
				out <- &brutus.Result{Success: false, Value: perm.Value}
				continue
			}
			out <- &brutus.Result{Success: true, Value: perm.Value}
		}
	}
}

// proto.DecryptServer interface

func (s *DecryptServer) Connect(stream proto.Decrypt_ConnectServer) error {
	var (
		wg       sync.WaitGroup
		resultCh = make(chan *brutus.Result, 256)
	)

	for i := 0; i < runtime.NumCPU(); i++ {
		wg.Add(1)
		go s.QueueWorker(stream.Context(), &wg, resultCh)
	}

	// receive
	wg.Add(1)
	go func() {
		defer wg.Done()
		for {
			in, err := stream.Recv()
			if err == io.EOF {
				logger.Info("client closed stream")
				return
			}
			if err != nil {
				logger.Error("error receiving message", zap.Error(err))
				return
			}
			s.Permutations.Enqueue(in)
		}
	}()

	// send
	wg.Add(1)
	go func() {
		defer wg.Done()
		for result := range resultCh {
			if err := stream.Send(result); err != nil {
				logger.Error("error sending message", zap.Error(err))
				return
			}
			s.opsCh <- true
		}
	}()

	wg.Wait()
	return nil
}

func (s *DecryptServer) Set(ctx context.Context, req *brutus.Target) (*emptypb.Empty, error) {
	s.mu.Lock()
	defer s.mu.Unlock()
	target, err := crypto.NewPGPMessageFromArmored(string(req.Value))
	if err != nil {
		logger.Error("error parsing armored message", zap.Error(err))
		return new(emptypb.Empty), err
	}
	s.target = target
	return new(emptypb.Empty), nil
}

func (s *DecryptServer) Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error) {
	logger.Info("api shutdown request, shutting down...")
	syscall.Kill(syscall.Getegid(), syscall.SIGTERM)
	return new(emptypb.Empty), nil
}
