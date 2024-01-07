package main

import (
	"context"
	"io"
	"net"
	"runtime"
	"sync"
	"syscall"

	"github.com/mattgonewild/brutus/perm/proto"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"

	lane "github.com/oleiade/lane/v2"
)

type PermServer struct {
	proto.UnimplementedPermServer
	Combinations *lane.Queue[*proto.Combination]
}

func NewPermServer(ctx context.Context) *PermServer {
	return &PermServer{
		Combinations: lane.NewQueue[*proto.Combination](),
	}
}

func ListenAndServeAPI(shutdownCtx context.Context, config *Config, api *PermServer) {
	// initialize grpc server
	grpcServer := grpc.NewServer()

	// register services
	proto.RegisterPermServer(grpcServer, api)

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

func (s *PermServer) QueueWorker(ctx context.Context, wg *sync.WaitGroup, out chan string) {
	defer wg.Done()
	for {
		select {
		case <-ctx.Done():
			return
		default:
			comb, ok := s.Combinations.Dequeue()
			if !ok {
				continue
			}
			GeneratePermutations(ctx, len(comb.Elements), Decode(comb), out)
		}
	}
}

func Decode(comb *proto.Combination) []string {
	elements := make([]string, 0, len(comb.Elements))
	for _, element := range comb.Elements {
		elements = append(elements, string(element.Value))
	}
	return elements
}

// proto.PermServer interface

func (s *PermServer) Connect(stream proto.Perm_ConnectServer) error {
	var (
		wg     sync.WaitGroup
		permCh = make(chan string, 128)
	)

	for i := 0; i < runtime.NumCPU(); i++ {
		wg.Add(1)
		go s.QueueWorker(stream.Context(), &wg, permCh)
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
			s.Combinations.Enqueue(in)
		}
	}()

	// send
	wg.Add(1)
	go func() {
		defer wg.Done()
		for perm := range permCh {
			if err := stream.Send(&proto.Permutation{Value: []byte(perm)}); err != nil {
				logger.Error("error sending message", zap.Error(err))
				return
			}
		}
	}()

	wg.Wait()
	return nil
}

func (s *PermServer) Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error) {
	logger.Info("api shutdown request, shutting down...")
	syscall.Kill(syscall.Getegid(), syscall.SIGTERM)
	return new(emptypb.Empty), nil
}
