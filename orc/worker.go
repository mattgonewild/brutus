package main

import (
	"context"
	"errors"
	"net/netip"
	"sync"
	"time"

	transport "github.com/go-openapi/runtime/client"
	"github.com/google/uuid"

	fly "github.com/mattgonewild/fly/client"
	"github.com/mattgonewild/fly/client/machines"
	"github.com/mattgonewild/fly/models"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/types/known/emptypb"

	comb "github.com/mattgonewild/brutus/comb/proto"
	decrypt "github.com/mattgonewild/brutus/decrypt/proto"
	perm "github.com/mattgonewild/brutus/perm/proto"
)

type Worker interface {
	Start(ctx context.Context, in chan []byte, out chan []byte, port string) error
	Stop() error
	UUID() string
	IP() netip.Addr
}

type BaseWorker struct {
	machineID string
	uuid      string
	ip        netip.Addr
	port      string
}

type CombClient interface {
	Connect(ctx context.Context, opts ...grpc.CallOption) (CombStream, error)
}

type CombStream interface {
	grpc.ClientStream
	Send(*comb.Request) error
	Recv() (*comb.Combination, error)
}

type PermClient interface {
	Connect(ctx context.Context, opts ...grpc.CallOption) (PermStream, error)
}

type PermStream interface {
	grpc.ClientStream
	Send(*perm.Combination) error
	Recv() (*perm.Permutation, error)
}

type DecryptClient interface {
	Connect(ctx context.Context, opts ...grpc.CallOption) (DecryptStream, error)
}

type DecryptStream interface {
	grpc.ClientStream
	Send(*decrypt.Permutation) error
	Recv() (*decrypt.Result, error)
}

func (w *BaseWorker) Stop(workerType ServiceType, clientFunc func(conn *grpc.ClientConn) interface{}) error {
	conn, err := grpc.DialContext(context.TODO(), w.ip.String()+":"+w.port, grpc.WithInsecure())
	if err != nil {
		logger.Error("error dialing service", zap.Error(err), zap.String("type", string(workerType)), zap.String("ip", w.ip.String()))
		return err
	}
	defer conn.Close()

	client := clientFunc(conn).(interface {
		Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error)
	})

	_, err = client.Shutdown(context.TODO(), &emptypb.Empty{})
	if err != nil {
		logger.Error("error shutting down worker gracefully", zap.Error(err), zap.String("type", string(workerType)), zap.String("ip", w.ip.String()))
	} else {
		time.Sleep(2 * time.Second) // TODO: ...
	}

	flyClient := fly.New(transport.New("api.machines.dev", "/v1", []string{"https"}), nil)
	_, err = flyClient.Machines.MachinesDelete(&machines.MachinesDeleteParams{MachineID: w.machineID}) // TODO: stop, not delete
	return err
}

func (w *BaseWorker) Start(ctx context.Context, in chan []byte, out chan []byte, appName string, image string, clientFunc func(conn *grpc.ClientConn) interface{}, serviceType ServiceType, port string) error {
	uuid := uuid.New().String()
	if uuid == "" {
		return errors.New("failed to generate uuid")
	}

	w.uuid = uuid

	flyClient := fly.New(transport.New("api.machines.dev", "/v1", []string{"https"}), nil)
	resp, err := flyClient.Machines.MachinesCreate(&machines.MachinesCreateParams{AppName: appName, Request: &models.CreateMachineRequest{
		Config: struct{ models.APIMachineConfig }{
			APIMachineConfig: models.APIMachineConfig{
				Checks:      map[string]models.APIMachineCheck{"headers": {Headers: []*models.APIMachineHTTPHeader{{Name: "Authorization", Values: []string{""}}}}},
				AutoDestroy: true,
				Image:       image,
				Env:         map[string]string{"WORKER_UUID": w.uuid, "WORKER_TYPE": string(serviceType)},
			},
		},
	}})
	if err != nil {
		return err
	}

	w.machineID = resp.Payload.ID

	w.ip, err = netip.ParseAddr(resp.Payload.PrivateIP)
	if err != nil {
		return err
	}

	w.port = port

	// this should block for at most 60 seconds
	_, err = flyClient.Machines.MachinesWait(&machines.MachinesWaitParams{MachineID: w.machineID})
	if err != nil {
		logger.Error("error waiting for machine", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
		return err
	}

	if ctx.Err() != nil {
		return ctx.Err()
	}

	// TODO: https://grpc.io/docs/guides/health-checking/
	conn, err := grpc.DialContext(ctx, w.ip.String()+":"+w.port, grpc.WithInsecure())
	if err != nil {
		logger.Error("error dialing service", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
		return err
	}
	defer conn.Close()

	client := clientFunc(conn)

	var stream grpc.ClientStream
	switch t := client.(type) {
	case CombClient:
		stream, err = t.Connect(ctx)
	case PermClient:
		stream, err = t.Connect(ctx)
	case DecryptClient:
		stream, err = t.Connect(ctx)
	}
	if err != nil {
		logger.Error("error connecting to service", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
		return err
	}

	var wg sync.WaitGroup

	// in
	wg.Add(1)
	go func() {
		defer wg.Done()
		for {
			select {
			case bytes, ok := <-in:
				if !ok {
					return
				}
				// process bytes
				switch t := stream.(type) {
				case CombStream:
					req := new(comb.Request)
					err := proto.Unmarshal(bytes, req)
					if err != nil {
						logger.Error("failed to unmarshal request", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
						continue
					}
					if err := t.Send(req); err != nil {
						logger.Error("failed to send request", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
						return
					}
				case PermStream:
					req := new(perm.Combination)
					err := proto.Unmarshal(bytes, req)
					if err != nil {
						logger.Error("failed to unmarshal request", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
						continue
					}
					if err := t.Send(req); err != nil {
						logger.Error("failed to send request", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
						return
					}
				case DecryptStream:
					req := new(decrypt.Permutation)
					err := proto.Unmarshal(bytes, req)
					if err != nil {
						logger.Error("failed to unmarshal request", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
						continue
					}
					if err := t.Send(req); err != nil {
						logger.Error("failed to send request", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
						return
					}
				}
			case <-ctx.Done():
				return
			}
		}
	}()

	// out
	wg.Add(1)
	go func() {
		defer wg.Done()
		for {
			if ctx.Err() != nil {
				return
			}

			var resp proto.Message
			switch t := stream.(type) {
			case CombStream:
				resp, err = t.Recv()
			case PermStream:
				resp, err = t.Recv()
			case DecryptStream:
				resp, err = t.Recv()
			}
			if err != nil {
				logger.Error("failed to receive response", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
				return
			}

			bytes, err := proto.Marshal(resp)
			if err != nil {
				logger.Error("failed to marshal response", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
				return
			}

			select {
			case out <- bytes:
			case <-ctx.Done():
				return
			}
		}
	}()

	wg.Wait()
	err = stream.CloseSend()
	if err != nil {
		logger.Error("error closing stream", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
		return err
	}

	return nil
}

type CombinationWorker struct {
	BaseWorker
}

type PermutationWorker struct {
	BaseWorker
}

type DecryptionWorker struct {
	BaseWorker
}

func (w *CombinationWorker) Start(ctx context.Context, in chan []byte, out chan []byte, port string) error {
	return w.BaseWorker.Start(ctx, in, out, "combination-service", "mattgonewild/combination-service", func(conn *grpc.ClientConn) interface{} { return comb.NewCombClient(conn) }, Combination, port)
}

func (w *CombinationWorker) Stop() error {
	return w.BaseWorker.Stop(Combination, func(conn *grpc.ClientConn) interface{} { return comb.NewCombClient(conn) })
}

func (w *CombinationWorker) UUID() string   { return w.uuid }
func (w *CombinationWorker) IP() netip.Addr { return w.ip }

func (w *PermutationWorker) Start(ctx context.Context, in chan []byte, out chan []byte, port string) error {
	return w.BaseWorker.Start(ctx, in, out, "permutation-service", "mattgonewild/permutation-service", func(conn *grpc.ClientConn) interface{} { return perm.NewPermClient(conn) }, Permutation, port)
}

func (w *PermutationWorker) Stop() error {
	return w.BaseWorker.Stop(Permutation, func(conn *grpc.ClientConn) interface{} { return perm.NewPermClient(conn) })
}

func (w *PermutationWorker) UUID() string   { return w.uuid }
func (w *PermutationWorker) IP() netip.Addr { return w.ip }

func (w *DecryptionWorker) Start(ctx context.Context, in chan []byte, out chan []byte, port string) error {
	return w.BaseWorker.Start(ctx, in, out, "decryption-service", "mattgonewild/decryption-service", func(conn *grpc.ClientConn) interface{} { return decrypt.NewDecryptClient(conn) }, Decryption, port)
}

func (w *DecryptionWorker) Stop() error {
	return w.BaseWorker.Stop(Decryption, func(conn *grpc.ClientConn) interface{} { return decrypt.NewDecryptClient(conn) })
}

func (w *DecryptionWorker) UUID() string   { return w.uuid }
func (w *DecryptionWorker) IP() netip.Addr { return w.ip }

type WorkerFactory struct {
	ctx  context.Context
	conf *Config
}

func (f *WorkerFactory) NewWorker(t ServiceType, in chan []byte, out chan []byte) (Worker, error) {
	var (
		worker Worker
		port   string
	)
	switch t {
	case Combination:
		worker = new(CombinationWorker)
		port = f.conf.CombPort
	case Permutation:
		worker = new(PermutationWorker)
		port = f.conf.PermPort
	case Decryption:
		worker = new(DecryptionWorker)
		port = f.conf.DecryptPort
	default:
		return nil, errors.New("invalid service type")
	}
	err := worker.Start(f.ctx, in, out, port)
	if err != nil {
		return nil, err
	}
	return worker, nil
}

type WorkerManager struct {
	Workers map[string]Worker
	Factory *WorkerFactory
	Mutex   sync.Mutex
}

func (m *WorkerManager) AddWorker(t ServiceType, in chan []byte, out chan []byte) error {
	worker, err := m.Factory.NewWorker(t, in, out)
	if err != nil {
		return err
	}
	m.Mutex.Lock()
	m.Workers[worker.UUID()] = worker
	m.Mutex.Unlock()
	return nil
}

func (m *WorkerManager) RemoveWorker() error {
	m.Mutex.Lock()
	defer m.Mutex.Unlock()
	for id, worker := range m.Workers {
		err := worker.Stop()
		if err == nil {
			delete(m.Workers, id)
			return nil
		}
	}
	return errors.New("could not remove worker")
}

func (m *WorkerManager) StopAllWorkers() {
	m.Mutex.Lock()
	defer m.Mutex.Unlock()
	for _, worker := range m.Workers {
		err := worker.Stop()
		if err != nil {
			logger.Error("failed to stop worker", zap.Error(err),
				zap.String("uuid", worker.UUID()), zap.String("ip", worker.IP().String()))
			continue
		}
		delete(m.Workers, worker.UUID())
	}
}
