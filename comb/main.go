package main

import (
	"context"
	"os"
	"os/signal"
	"sync"
	"syscall"
	"time"

	"go.uber.org/zap"

	met "github.com/mattgonewild/brutus/met/reporter"
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
	opsCh := make(chan bool, 2048)
	sigCh := make(chan os.Signal, 1)

	ctx, cancel := context.WithCancel(context.Background())
	context.AfterFunc(ctx, func() {
		close(opsCh)
		close(sigCh)
	})

	var wg sync.WaitGroup

	reporter, err := met.NewReporter(ctx, logger, 1*time.Second, config.MetAddr, "eth0")
	if err != nil {
		logger.Fatal("failed to create reporter", zap.Error(err))
	}

	// start reporting
	wg.Add(1)
	go func() {
		defer wg.Done()
		reporter.Start(opsCh)
	}()

	// start serving API
	wg.Add(1)
	go func() {
		defer wg.Done()
		ListenAndServeAPI(ctx, config, NewCombServer(opsCh))
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
