// TODO: network IO
package reporter

import (
	"context"
	"io"
	"net/netip"
	"os"
	"sync"
	"sync/atomic"
	"time"

	"github.com/mattgonewild/brutus/met/proto"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/timestamppb"

	"github.com/mackerelio/go-osstat/cpu"
	"github.com/mackerelio/go-osstat/loadavg"
	"github.com/mackerelio/go-osstat/memory"
	"github.com/mackerelio/go-osstat/uptime"
)

type Reporter struct {
	proto.MetClient
	ctx    context.Context
	cancel context.CancelFunc
	logger *zap.Logger
	inter  time.Duration
	conn   *grpc.ClientConn
	report *proto.Worker
	netIf  string
}

func NewReporter(ctx context.Context, logger *zap.Logger, inter time.Duration, metAddr netip.AddrPort, netIf string) (*Reporter, error) {
	conn, err := grpc.Dial(metAddr.String(), grpc.WithInsecure()) // TODO: ...
	if err != nil {
		return nil, err
	}

	ctx, cancel := context.WithCancel(ctx)

	id, ok := os.LookupEnv("WORKER_UUID")
	if !ok {
		logger.Error("error getting worker uuid")
	}

	t, ok := os.LookupEnv("WORKER_TYPE")
	if !ok {
		logger.Error("error getting worker type")
	}

	return &Reporter{
		MetClient: proto.NewMetClient(conn),
		ctx:       ctx,
		cancel:    cancel,
		logger:    logger,
		inter:     inter,
		conn:      conn,
		report: &proto.Worker{
			Id:   id,
			Type: t,
		},
		netIf: netIf,
	}, nil
}

func (r *Reporter) Start(opsCh chan bool) error {
	defer r.Stop()

	var wg sync.WaitGroup
	var stream proto.Met_ReportClient
	var err error

	for i := 0; i < 10; i++ {
		stream, err = r.Report(r.ctx)
		if err == nil {
			break
		}
		r.logger.Error("error creating stream", zap.Error(err))
		time.Sleep(3 * time.Second)
	}

	if err != nil {
		return err
	}

	wg.Add(1)
	go func() {
		defer wg.Done()
		for {
			select {
			case <-r.ctx.Done():
				return
			case <-opsCh:
				atomic.AddInt64(&r.report.Ops, 1)
			}
		}
	}()

	wg.Add(1)
	go func() {
		defer wg.Done()
		for {
			select {
			case <-r.ctx.Done():
				return
			default:
				_, err := stream.Recv()
				if err == io.EOF {
					r.logger.Info("met stream EOF")
					return
				}
				if err != nil {
					r.logger.Error("error receiving message", zap.Error(err))
					return
				}
			}
		}
	}()

	wg.Add(1)
	go func() {
		defer wg.Done()
		for {
			select {
			case <-r.ctx.Done():
				return
			case <-time.After(r.inter):
				stream.Send(r.BuildReport())
			}
		}
	}()

	wg.Wait()
	err = stream.CloseSend()
	if err != nil {
		r.logger.Error("error closing stream", zap.Error(err))
	}

	return err
}

func (r *Reporter) Stop() {
	r.cancel()
	r.conn.Close()
}

func (r *Reporter) BuildReport() *proto.Worker {
	cpuStats, err := cpu.Get()
	if err != nil {
		r.logger.Error("error getting cpu stats", zap.Error(err))
		cpuStats = &cpu.Stats{Idle: 0, Total: 0}
	}

	memStats, err := memory.Get()
	if err != nil {
		r.logger.Error("error getting memory stats", zap.Error(err))
		memStats = &memory.Stats{Used: 0, Total: 0, SwapUsed: 0, SwapTotal: 0}
	}

	uptime, err := uptime.Get()
	if err != nil {
		r.logger.Error("error getting uptime stats", zap.Error(err))
	}

	loadStats, err := loadavg.Get()
	if err != nil {
		r.logger.Error("error getting load stats", zap.Error(err))
		loadStats = &loadavg.Stats{Loadavg1: 0, Loadavg5: 0, Loadavg15: 0}
	}

	return &proto.Worker{
		Id:   r.report.Id,
		Time: timestamppb.Now(),
		Ip:   r.report.Ip,
		Type: r.report.Type,
		Proc: &proto.Proc{
			Cpu: &proto.Cpu{
				Idle:  cpuStats.Idle,
				Total: cpuStats.Total,
			},
			Mem: &proto.Mem{
				Used:      memStats.Used,
				Total:     memStats.Total,
				SwapUsed:  memStats.SwapUsed,
				SwapTotal: memStats.SwapTotal,
			},
			Uptime: &proto.Uptime{
				Duration: int64(uptime),
			},
			LoadAvg: &proto.LoadAvg{
				OneMinute:      loadStats.Loadavg1,
				FiveMinutes:    loadStats.Loadavg5,
				FifteenMinutes: loadStats.Loadavg15,
			},
		},
		Ops: atomic.LoadInt64(&r.report.Ops),
	}
}
