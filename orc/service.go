package main

import (
	"context"
	"time"
)

type ServiceType string

const (
	Combination ServiceType = "combination"
	Permutation ServiceType = "permutation"
	Decryption  ServiceType = "decryption"
)

type Service struct {
	Type          ServiceType
	Cost          int64
	WorkerManager *WorkerManager
	BudgetManager *BudgetManager
	InChan        chan string
	OutChan       chan string
}

func (s *Service) ManageWorkers(ctx context.Context) {
	ticker := time.NewTicker(time.Second)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			return
		case <-ticker.C:
			s.WorkerManager.Mutex.Lock()
			load := float64(len(s.WorkerManager.Workers)) // TODO: replace with actual load calculation
			s.WorkerManager.Mutex.Unlock()

			s.BudgetManager.Deduct(int64(len(s.WorkerManager.Workers)) * s.Cost)

			if !s.BudgetManager.CanAfford(s.Cost) {
				s.WorkerManager.Mutex.Lock()
				for _, worker := range s.WorkerManager.Workers {
					worker.Stop()
				}
				s.WorkerManager.Workers = nil
				s.WorkerManager.Mutex.Unlock()
				return
			}

			if load > 1.0 && s.BudgetManager.CanAfford(s.Cost) {
				s.WorkerManager.AddWorker(s.Type, s.InChan, s.OutChan)
				s.BudgetManager.Deduct(s.Cost)
			} else if load < 1.0 {
				s.WorkerManager.RemoveWorker()
			}
		}
	}
}
