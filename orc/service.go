package main

import (
	"context"
	"net/netip"
	"time"

	"go.uber.org/zap"
	"google.golang.org/grpc"

	met "github.com/mattgonewild/brutus/met/proto"
	brutus "github.com/mattgonewild/brutus/proto/go"
)

type ServiceType string

const (
	Combination ServiceType = "combination"
	Permutation ServiceType = "permutation"
	Decryption  ServiceType = "decryption"
)

type Service struct {
	Type          ServiceType
	Cost          float64
	WorkerManager *WorkerManager
	BudgetManager *BudgetManager
	InChan        chan []byte
	OutChan       chan []byte
	MetricsClient met.MetClient
	Conn          *grpc.ClientConn
}

func NewService(serviceType ServiceType, cost float64, workerManager *WorkerManager, budgetManager *BudgetManager, inChan chan []byte, outChan chan []byte, metAddr netip.AddrPort) *Service {
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
			resp, err := s.MetricsClient.GetPoolLoad(ctx, &brutus.PoolLoadRequest{Type: string(s.Type)})
			if err != nil {
				logger.Warn("failed to get pool load", zap.Error(err), zap.String("type", string(s.Type)))
				continue // something's not right, try again
			} else {
				load = resp.Load
			}

			s.BudgetManager.Deduct(float64(len(s.WorkerManager.ActiveWorkers)) * s.Cost)

			// we're broke
			if !s.BudgetManager.CanAfford(s.Cost) {
				s.WorkerManager.StopAllWorkers()
			}

			// load is too high and we have cash to spare
			if load > config.LoadThreshold && s.BudgetManager.CanAfford(s.Cost) {
				err := s.WorkerManager.AddWorker(s.Type, s.InChan, s.OutChan)
				if err != nil {
					logger.Warn("failed to add worker", zap.Error(err), zap.String("type", string(s.Type)))
				}
				s.BudgetManager.Deduct(s.Cost)
			} else if load < config.LoadThreshold && len(s.WorkerManager.ActiveWorkers) > 1 { // we're doing alright
				s.WorkerManager.StopAnyWorker()
			}
		}
	}
}

func (s *Service) Shutdown() {
	s.WorkerManager.DestroyAllWorkers()
	s.Conn.Close()
}
