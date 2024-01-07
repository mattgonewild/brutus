package main

import (
	"context"
	"os"
	"os/signal"
	"sync"
	"syscall"

	"go.uber.org/zap"
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

	// parse cmd line args
	config, err := LoadConfig()
	if err != nil {
		logger.Fatal("failed to load config", zap.Error(err))
	}

	// initialize channels
	sigCh := make(chan os.Signal, 1)

	ctx, cancel := context.WithCancel(context.Background())
	context.AfterFunc(ctx, func() {
		close(sigCh)
	})

	var wg sync.WaitGroup

	// start serving API
	wg.Add(1)
	go func() {
		defer wg.Done()
		ListenAndServeAPI(ctx, config, NewDecryptServer(ctx))
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

	wg.Wait()
}
