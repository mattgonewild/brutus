package main

import (
	"context"
	"io"
	"net"
	"slices"
	"strings"
	"sync"
	"syscall"

	"github.com/mattgonewild/brutus/comb/proto"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"
)

type CombServer struct {
	proto.UnimplementedCombServer
	mu       sync.RWMutex
	Elements map[string]*proto.Element
	SentComb map[string]bool
}

func NewCombServer(ctx context.Context) *CombServer {
	return &CombServer{
		Elements: make(map[string]*proto.Element),
		SentComb: make(map[string]bool),
	}
}

func ListenAndServeAPI(shutdownCtx context.Context, config *Config, api *CombServer) {
	// initialize grpc server
	grpcServer := grpc.NewServer()

	// register services
	proto.RegisterCombServer(grpcServer, api)

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

func (s *CombServer) AddElement(e *proto.Element) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.Elements[e.Id] = e
}

func (s *CombServer) RemoveElement(e *proto.Element) {
	s.mu.Lock()
	defer s.mu.Unlock()
	delete(s.Elements, e.Id)
}

func (s *CombServer) GenerateCombinations(ctx context.Context, combCh chan<- []*proto.Element) {
	s.mu.RLock()
	elements := make([]*proto.Element, 0, len(s.Elements))
	for _, e := range s.Elements {
		elements = append(elements, e)
	}
	s.mu.RUnlock()

	combinator := NewElementCombinator(elements)

	for combinator.Next() {
		select {
		case <-ctx.Done():
			return
		case combCh <- combinator.Comb:
		}
	}
}

// proto.CombServer interface

func (s *CombServer) Connect(stream proto.Comb_ConnectServer) error {
	var (
		wg     sync.WaitGroup
		cancel context.CancelFunc = func() {}
		combCh                    = make(chan []*proto.Element)
	)

	wg.Add(2)

	// receive
	go func() {
		defer wg.Done()
		for {
			in, err := stream.Recv()
			if err == io.EOF {
				logger.Info("client closed stream")
				close(combCh)
				return
			}
			if err != nil {
				logger.Error("error receiving message", zap.Error(err))
				close(combCh)
				return
			}
			if in.Add {
				s.AddElement(in.Element)
			} else {
				s.RemoveElement(in.Element)
			}

			// cancel the previous GenerateCombinations call
			cancel()

			var ctx context.Context
			ctx, cancel = context.WithCancel(stream.Context())

			go s.GenerateCombinations(ctx, combCh)
		}
	}()

	// send
	go func() {
		defer wg.Done()
		for comb := range combCh {
			s.mu.Lock()
			flattenedComb := FlattenCombination(comb)
			if s.SentComb[flattenedComb] {
				s.mu.Unlock()
				continue
			}
			if err := stream.Send(&proto.Combination{Elements: comb}); err != nil {
				s.mu.Unlock()
				logger.Error("error sending message", zap.Error(err))
				return
			}
			s.SentComb[flattenedComb] = true
			s.mu.Unlock()
		}
	}()

	wg.Wait()
	return nil
}

func FlattenCombination(comb []*proto.Element) string {
	elements := make([]string, 0, len(comb))
	for _, e := range comb {
		elements = append(elements, e.Value)
	}
	slices.Sort(elements)

	var builder strings.Builder
	for _, element := range elements {
		builder.WriteString(element)
	}
	return builder.String()
}

func (s *CombServer) Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error) {
	logger.Info("api shutdown request, shutting down...")
	syscall.Kill(syscall.Getegid(), syscall.SIGTERM)
	return new(emptypb.Empty), nil
}
