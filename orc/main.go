package main

import (
	"context"
	"os"
	"os/signal"
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
	exit := make(chan bool)

	// initialize services
	services := []*Service{
		{Type: Combination, Cost: config.MachineCost, WorkerManager: &WorkerManager{Factory: workerFactory}, BudgetManager: budgetManager,
			OutChan: combOut},
		{Type: Permutation, Cost: config.MachineCost, WorkerManager: &WorkerManager{Factory: workerFactory}, BudgetManager: budgetManager,
			InChan: combOut, OutChan: permOut},
		{Type: Decryption, Cost: config.MachineCost, WorkerManager: &WorkerManager{Factory: workerFactory}, BudgetManager: budgetManager,
			InChan: permOut},
	}

	ctx, cancel := context.WithCancel(context.Background())
	context.AfterFunc(ctx, func() {
		close(combOut)
		close(permOut)
		close(sigCh)
		close(exit)
	})

	// start monitoring budget and load for each service
	for _, service := range services {
		service.WorkerManager.AddWorker(service.Type, service.InChan, service.OutChan) // start one worker immediately
		go service.ManageWorkers(ctx, config)
	}

	// start serving API
	go ListenAndServeAPI(ctx, config,
		&APIServer{BudgetManager: budgetManager,
			CombinationWorkerManager: services[0].WorkerManager,
			PermutationWorkerManager: services[1].WorkerManager,
			DecryptionWorkerManager:  services[2].WorkerManager,
		},
	)

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
