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

	// initialize budget
	budgetManager := &BudgetManager{Balance: config.Budget}

	// initialize worker factory
	workerFactory := &WorkerFactory{}

	// initialize channels
	combOut := make(chan string)
	permOut := make(chan string)
	sigCh := make(chan os.Signal, 1)

	// initialize services
	services := map[ServiceType]*Service{
		Combination: {
			Type:          Combination,
			Cost:          config.MachineCost,
			WorkerManager: &WorkerManager{Factory: workerFactory},
			BudgetManager: budgetManager,
			OutChan:       combOut,
		},
		Permutation: {
			Type:          Permutation,
			Cost:          config.MachineCost,
			WorkerManager: &WorkerManager{Factory: workerFactory},
			BudgetManager: budgetManager,
			InChan:        combOut,
			OutChan:       permOut,
		},
		Decryption: {
			Type:          Decryption,
			Cost:          config.MachineCost,
			WorkerManager: &WorkerManager{Factory: workerFactory},
			BudgetManager: budgetManager,
			InChan:        permOut,
		},
	}

	ctx, cancel := context.WithCancel(context.Background())
	context.AfterFunc(ctx, func() {
		close(combOut)
		close(permOut)
		close(sigCh)
	})

	var wg sync.WaitGroup

	// start monitoring budget and load for each service
	for _, service := range services {
		service.WorkerManager.AddWorker(service.Type, service.InChan, service.OutChan) // start one worker immediately
		wg.Add(1)
		go func(service *Service) {
			defer wg.Done()
			service.ManageWorkers(ctx, config)
		}(service)
	}

	// start serving API
	wg.Add(1)
	go func() {
		defer wg.Done()
		ListenAndServeAPI(ctx, config,
			&APIServer{BudgetManager: budgetManager, Services: services},
		)
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
