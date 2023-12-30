package main

import (
	"context"
	"time"

	"go.uber.org/zap"
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

func (s *Service) ManageWorkers(ctx context.Context, config *Config) {
	ticker := time.NewTicker(config.ServiceCheckInterval)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			return
		case <-ticker.C:
			s.WorkerManager.Mutex.Lock()
			load := float64(len(s.WorkerManager.Workers)) // TODO: query metric service for load
			s.WorkerManager.Mutex.Unlock()

			s.BudgetManager.Deduct(int64(len(s.WorkerManager.Workers)) * s.Cost)

			if !s.BudgetManager.CanAfford(s.Cost) {
				s.WorkerManager.Mutex.Lock()
				for _, worker := range s.WorkerManager.Workers {
					err := worker.Stop()
					if err != nil {
						logger.Error("failed to stop worker", zap.Error(err),
							zap.String("uuid", worker.UUID()), zap.String("ip", worker.IP().String()), zap.String("type", string(s.Type)))
						continue
					}
					delete(s.WorkerManager.Workers, worker.UUID())
				}
				s.WorkerManager.Mutex.Unlock()
				return
			}

			if load > config.LoadThreshold && s.BudgetManager.CanAfford(s.Cost) {
				err := s.WorkerManager.AddWorker(s.Type, s.InChan, s.OutChan)
				if err != nil {
					logger.Warn("failed to add worker", zap.Error(err), zap.String("type", string(s.Type)))
					break
				}
				s.BudgetManager.Deduct(s.Cost)
			} else if load < config.LoadThreshold && len(s.WorkerManager.Workers) > 1 {
				err := s.WorkerManager.RemoveWorker()
				if err != nil {
					logger.Warn("failed to remove worker", zap.Error(err), zap.String("type", string(s.Type)))
					break
				}
			}
		}
	}
}
