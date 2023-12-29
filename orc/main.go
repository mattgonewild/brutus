package main

import (
	"context"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	// initialize budget
	budgetManager := &BudgetManager{Balance: 300}

	// initialize worker factory
	workerFactory := &WorkerFactory{}

	// initialize channels
	combOut := make(chan string)
	permOut := make(chan string)
	sigCh := make(chan os.Signal, 1)
	exit := make(chan bool)

	// initialize services
	services := []*Service{
		{Type: Combination, Cost: 1.0, WorkerManager: &WorkerManager{Factory: workerFactory}, BudgetManager: budgetManager, OutChan: combOut},
		{Type: Permutation, Cost: 1.0, WorkerManager: &WorkerManager{Factory: workerFactory}, BudgetManager: budgetManager, InChan: combOut, OutChan: permOut},
		{Type: Decryption, Cost: 1.0, WorkerManager: &WorkerManager{Factory: workerFactory}, BudgetManager: budgetManager, InChan: permOut},
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
		go service.ManageWorkers(ctx)
	}

	// start serving API
	go ListenAndServeAPI(":8080", ctx)

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
