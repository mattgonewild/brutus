package main

import (
	"container/ring"
	"context"
	"fmt"
	"io"
	"net"
	"sync"
	"syscall"
	"time"

	"github.com/mattgonewild/brutus/met/proto"
	brutus "github.com/mattgonewild/brutus/proto/go"

	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"
)

type ReportsDB struct {
	mu          sync.RWMutex
	latest      *brutus.Worker
	lastUpdated time.Time
	history     *ring.Ring
}

func NewReportsDB() *ReportsDB {
	return &ReportsDB{
		history: ring.New(4 * 60 * 60), // 4 hours of reports at one report per second
	}
}

func (db *ReportsDB) Add(report *brutus.Worker) {
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
}

func NewMetServer(ctx context.Context) *MetServer {
	s := &MetServer{
		Pools:    make(map[string]map[string]*ReportsDB),
		IDToPool: make(map[string]string),
	}

	// monitor
	go func(ctx context.Context) {
		for {
			select {
			case <-ctx.Done():
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
	}(ctx)

	return s
}

func ListenAndServeAPI(shutdownCtx context.Context, config *Config, api *MetServer) {
	// initialize grpc server
	grpcServer := grpc.NewServer()

	// register services
	proto.RegisterMetServer(grpcServer, api)

	// start grpc server
	go func() {
		lis, err := net.Listen("tcp", config.ListenAndServeAPIAddr)
		if err != nil {
			logger.Fatal("failed to listen", zap.Error(err))
		}
		if err := grpcServer.Serve(lis); err != nil {
			logger.Fatal("failed to serve", zap.Error(err))
		}
	}()

	<-shutdownCtx.Done()

	// attempt to gracefully shutdown the server
	ctx, cancel := context.WithTimeout(context.Background(), config.ListenAndServeAPIMaxShutdownTime)
	defer cancel()

	done := make(chan bool)

	go func() {
		grpcServer.GracefulStop()
		close(done)
	}()

	select {
	case <-ctx.Done():
		logger.Warn("exceeded ListenAndServeAPIMaxShutdownTime: graceful shutdown failed")
		grpcServer.Stop()
	case <-done:
		return
	}
}

func (s *MetServer) GetWorkerLastReport(id string) (*brutus.Worker, error) {
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

func (s *MetServer) GetPoolLoad(ctx context.Context, req *brutus.PoolLoadRequest) (*brutus.PoolLoadResponse, error) {
	return &brutus.PoolLoadResponse{Load: 1.0}, nil // TODO: load calculation
}

func (s *MetServer) GetWorker(ctx context.Context, req *brutus.WorkerRequest) (*brutus.WorkerResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &brutus.WorkerResponse{Worker: reports}, nil
}

func (s *MetServer) GetWorkerCpu(ctx context.Context, req *brutus.WorkerRequest) (*brutus.CpuResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &brutus.CpuResponse{Cpu: reports.Proc.Cpu}, nil
}

func (s *MetServer) GetWorkerLoadavg(ctx context.Context, req *brutus.WorkerRequest) (*brutus.LoadAvgResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &brutus.LoadAvgResponse{LoadAvg: reports.Proc.LoadAvg}, nil
}

func (s *MetServer) GetWorkerMem(ctx context.Context, req *brutus.WorkerRequest) (*brutus.MemResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &brutus.MemResponse{Mem: reports.Proc.Mem}, nil
}

func (s *MetServer) GetWorkerNet(ctx context.Context, req *brutus.WorkerRequest) (*brutus.NetResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &brutus.NetResponse{Net: reports.Proc.Net}, nil
}

func (s *MetServer) GetWorkerProc(ctx context.Context, req *brutus.WorkerRequest) (*brutus.ProcResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &brutus.ProcResponse{Proc: reports.Proc}, nil
}

func (s *MetServer) GetWorkerUptime(ctx context.Context, req *brutus.WorkerRequest) (*brutus.UptimeResponse, error) {
	reports, err := s.GetWorkerLastReport(req.Id)
	if err != nil {
		logger.Error("error getting worker", zap.Error(err))
		return nil, err
	}

	return &brutus.UptimeResponse{Uptime: reports.Proc.Uptime}, nil
}

func (s *MetServer) GetWorkers(ctx context.Context, req *emptypb.Empty) (*brutus.WorkersResponse, error) {
	s.mu.RLock()
	defer s.mu.RUnlock()

	workers := make([]*brutus.Worker, 0, 12)
	for _, pool := range s.Pools {
		for _, reportDB := range pool {
			reportDB.mu.RLock()
			if reportDB.latest != nil {
				workers = append(workers, reportDB.latest)
			}
			reportDB.mu.RUnlock()
		}
	}

	return &brutus.WorkersResponse{Workers: workers}, nil
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

func (s *MetServer) Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error) {
	logger.Info("api shutdown request, shutting down...")
	syscall.Kill(syscall.Getegid(), syscall.SIGTERM)
	return new(emptypb.Empty), nil
}
