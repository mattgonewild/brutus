package main

import (
	"context"
	"net"
	"os"
	"os/signal"
	"syscall"

	"go.uber.org/zap"
	"google.golang.org/grpc"

	"github.com/mattgonewild/brutus/met/proto"
)

var logger *zap.Logger

func main() {
	// initialize logger
	logger, err := zap.NewProduction()
	if err != nil {
		panic(err)
	}

	defer logger.Sync()
	zap.RedirectStdLog(logger)

	// initialize channels
	sigCh := make(chan os.Signal, 1)
	exit := make(chan bool)

	ctx, cancel := context.WithCancel(context.Background())
	context.AfterFunc(ctx, func() {
		close(sigCh)
		close(exit)
	})

	// initialize grpc server
	grpcServer := grpc.NewServer()

	// register services
	proto.RegisterMetServer(grpcServer, NewMetServer())

	// start grpc server
	go func() {
		lis, err := net.Listen("tcp", ":8080")
		if err != nil {
			logger.Fatal("failed to listen", zap.Error(err))
		}
		if err := grpcServer.Serve(lis); err != nil {
			logger.Fatal("failed to serve", zap.Error(err))
		}
	}()

	signal.Notify(
		sigCh, os.Interrupt, syscall.SIGHUP, syscall.SIGINT, syscall.SIGQUIT, syscall.SIGTERM,
	)

	select {
	case <-sigCh:
		cancel()
	case <-ctx.Done():
		break
	}

	<-exit
}
