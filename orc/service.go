package main

import (
	"context"
	"net/netip"
	"time"

	"go.uber.org/zap"
	"google.golang.org/grpc"

	met "github.com/mattgonewild/brutus/met/proto"
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
	InChan        chan []byte
	OutChan       chan []byte
	MetricsClient met.MetClient
	Conn          *grpc.ClientConn
}

func NewService(serviceType ServiceType, cost int64, workerManager *WorkerManager, budgetManager *BudgetManager, inChan chan []byte, outChan chan []byte, metAddr netip.AddrPort) *Service {
	conn, _ := grpc.Dial(metAddr.String(), grpc.WithInsecure()) // TODO: ...
	return &Service{
		Type:          serviceType,
		Cost:          cost,
		WorkerManager: workerManager,
		BudgetManager: budgetManager,
		InChan:        inChan,
		OutChan:       outChan,
		MetricsClient: met.NewMetClient(conn),
		Conn:          conn,
	}
}

func (s *Service) ManageWorkers(ctx context.Context, config *Config) {
	ticker, load := time.NewTicker(config.ServiceCheckInterval), 0.0
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			s.Shutdown()
			return
		case <-ticker.C:
			resp, err := s.MetricsClient.GetPoolLoad(ctx, &met.PoolLoadRequest{Type: string(s.Type)})
			if err != nil {
				logger.Warn("failed to get pool load", zap.Error(err), zap.String("type", string(s.Type)))
			} else {
				load = resp.Load
			}

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

func (s *Service) Shutdown() {
	s.WorkerManager.StopAllWorkers()
	s.Conn.Close()
}
