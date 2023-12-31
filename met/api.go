package main

import (
	"container/ring"
	"context"
	"fmt"
	"io"
	"sync"
	"time"

	"github.com/mattgonewild/brutus/met/proto"
	"go.uber.org/zap"
	"google.golang.org/protobuf/types/known/emptypb"
)

type ReportsDB struct {
	mu          sync.RWMutex
	latest      *proto.Worker
	lastUpdated time.Time
	history     *ring.Ring
}

func NewReportsDB() *ReportsDB {
	return &ReportsDB{
		history: ring.New(4 * 60 * 60), // 4 hours of reports at one report per second
	}
}

func (db *ReportsDB) Add(report *proto.Worker) {
	db.mu.Lock()
	defer db.mu.Unlock()

	db.latest = report
	db.lastUpdated = time.Now()
	db.history.Value = report
	db.history = db.history.Next()
}

type MetServer struct {
	proto.UnimplementedMetServer
	mu       sync.RWMutex
	Pools    map[string]map[string]*ReportsDB
	IDToPool map[string]string
	stopCh   chan bool
}

func NewMetServer() *MetServer {
	s := &MetServer{
		Pools:    make(map[string]map[string]*ReportsDB),
		IDToPool: make(map[string]string),
		stopCh:   make(chan bool),
	}

	// monitor
	go func(stopCh chan bool) {
		for {
			select {
			case <-stopCh:
				return
			case <-time.After(3 * time.Second):
				s.mu.Lock()
				for t, pool := range s.Pools {
					for id, reportDB := range pool {
						if reportDB.latest == nil {
							continue
						}
						reportDB.mu.Lock()
						if d := time.Since(reportDB.lastUpdated); d > 3*time.Second {
							logger.Info("removing worker from reportDB", zap.String("id", id), zap.Duration("mia", d))
							delete(pool, id)
							delete(s.IDToPool, id)
						}
						reportDB.mu.Unlock()
					}
					if len(pool) == 0 {
						logger.Info("removing pool", zap.String("type", t))
						delete(s.Pools, t)
					}
				}
				s.mu.Unlock()
			}
		}
	}(s.stopCh)

	return s
}

func (s *MetServer) GetWorkerLastReport(id string) (*proto.Worker, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	t, ok := s.IDToPool[id]
	if !ok {
		return nil, fmt.Errorf("unknown worker: %s", id)
	}

	pool, ok := s.Pools[t]
	if !ok {
		return nil, fmt.Errorf("unknown pool: %s", t)
	}

	reports, ok := pool[id]
	if !ok {
		return nil, fmt.Errorf("no reports for worker: %s", id)
	}

	reports.mu.RLock()
	defer reports.mu.RUnlock()

	return reports.latest, nil
}

// met.MetServer interface

func (s *MetServer) GetPoolLoad(ctx context.Context, req *proto.PoolLoadRequest) (*proto.PoolLoadResponse, error) {
	return nil, nil
}

func (s *MetServer) GetWorker(ctx context.Context, req *proto.WorkerRequest) (*proto.WorkerResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &proto.WorkerResponse{Worker: reports}, nil
}

func (s *MetServer) GetWorkerCpu(ctx context.Context, req *proto.WorkerRequest) (*proto.CpuResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &proto.CpuResponse{Cpu: reports.Proc.Cpu}, nil
}

func (s *MetServer) GetWorkerLoadavg(ctx context.Context, req *proto.WorkerRequest) (*proto.LoadavgResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &proto.LoadavgResponse{LoadAvg: reports.Proc.LoadAvg}, nil
}

func (s *MetServer) GetWorkerMem(ctx context.Context, req *proto.WorkerRequest) (*proto.MemResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &proto.MemResponse{Mem: reports.Proc.Mem}, nil
}

func (s *MetServer) GetWorkerNet(ctx context.Context, req *proto.WorkerRequest) (*proto.NetResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &proto.NetResponse{Net: reports.Proc.Net}, nil
}

func (s *MetServer) GetWorkerProc(ctx context.Context, req *proto.WorkerRequest) (*proto.ProcResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &proto.ProcResponse{Proc: reports.Proc}, nil
}

func (s *MetServer) GetWorkerUptime(ctx context.Context, req *proto.WorkerRequest) (*proto.UptimeResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &proto.UptimeResponse{Uptime: reports.Proc.Uptime}, nil
}

func (s *MetServer) GetWorkers(ctx context.Context, req *emptypb.Empty) (*proto.WorkersResponse, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	workers := make([]*proto.Worker, 0, 12)
	for _, pool := range s.Pools {
		for _, reportDB := range pool {
			reportDB.mu.RLock()
			if reportDB.latest != nil {
				workers = append(workers, reportDB.latest)
			}
			reportDB.mu.RUnlock()
		}
	}

	return &proto.WorkersResponse{Workers: workers}, nil
}

func (s *MetServer) Report(stream proto.Met_ReportServer) error {
	for {
		in, err := stream.Recv()
		if err == io.EOF {
			logger.Info("client closed stream", zap.String("uuid", in.Id), zap.String("ip", in.Ip))
			return nil
		}
		if err != nil {
			logger.Error("error receiving message", zap.Error(err), zap.String("uuid", in.Id), zap.String("ip", in.Ip))
			return err
		}

		s.mu.Lock()
		if _, ok := s.Pools[in.Type]; !ok {
			s.Pools[in.Type] = make(map[string]*ReportsDB)
		}
		reportDB, ok := s.Pools[in.Type][in.Id]
		if !ok {
			reportDB = NewReportsDB()
			s.Pools[in.Type][in.Id] = reportDB
			s.IDToPool[in.Id] = in.Type
		}
		s.mu.Unlock()
		reportDB.Add(in)
	}
}
