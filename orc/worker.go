package main

import (
	"context"
	"errors"
	"net/netip"
	"sync"

	fly "github.com/mattgonewild/fly/client"
	"github.com/mattgonewild/fly/client/machines"
	"github.com/mattgonewild/fly/models"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/proto"

	comb "github.com/mattgonewild/brutus/comb/proto"
	decrypt "github.com/mattgonewild/brutus/decrypt/proto"
	perm "github.com/mattgonewild/brutus/perm/proto"
)

type Worker interface {
	Start(ctx context.Context, in chan []byte, out chan []byte) error
	Stop() error
	UUID() string
	IP() netip.Addr
}

type BaseWorker struct {
	id string
	ip netip.Addr
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

func (w *BaseWorker) Start(ctx context.Context, in chan []byte, out chan []byte, appName string, image string, clientFunc func(conn *grpc.ClientConn) interface{}, serviceType ServiceType) error {
	flyClient := fly.New(nil, nil)

	resp, err := flyClient.Machines.MachinesCreate(&machines.MachinesCreateParams{AppName: appName, Request: &models.CreateMachineRequest{
		Config: struct{ models.APIMachineConfig }{
			APIMachineConfig: models.APIMachineConfig{
				AutoDestroy: true,
				Image:       image,
				Env:         make(map[string]string),
			},
		},
	}})
	if err != nil {
		return err
	}

	w.id = resp.Payload.ID

	w.ip, err = netip.ParseAddr(resp.Payload.PrivateIP)
	if err != nil {
		return err
	}

	// this should block for at most 60 seconds
	_, err = flyClient.Machines.MachinesWait(&machines.MachinesWaitParams{MachineID: w.id})
	if err != nil {
		logger.Error("error waiting for machine", zap.Error(err), zap.String("type", string(serviceType)), zap.String("ip", w.ip.String()))
		return err
	}

	if ctx.Err() != nil {
		return ctx.Err()
	}

	// TODO: https://grpc.io/docs/guides/health-checking/
	conn, err := grpc.DialContext(ctx, w.ip.String(), grpc.WithInsecure())
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

func (w *CombinationWorker) Start(ctx context.Context, in chan []byte, out chan []byte) error {
	return w.BaseWorker.Start(ctx, in, out, "combination-service", "mattgonewild/combination-service", func(conn *grpc.ClientConn) interface{} { return comb.NewCombClient(conn) }, Combination)
}

func (w *CombinationWorker) Stop() error {
	flyClient := fly.New(nil, nil)
	_, err := flyClient.Machines.MachinesDelete(&machines.MachinesDeleteParams{MachineID: w.id}) // TODO: stop, not delete
	return err
}

func (w *CombinationWorker) UUID() string   { return w.id }
func (w *CombinationWorker) IP() netip.Addr { return w.ip }

func (w *PermutationWorker) Start(ctx context.Context, in chan []byte, out chan []byte) error {
	return w.BaseWorker.Start(ctx, in, out, "permutation-service", "mattgonewild/permutation-service", func(conn *grpc.ClientConn) interface{} { return perm.NewPermClient(conn) }, Permutation)
}

func (w *PermutationWorker) Stop() error {
	flyClient := fly.New(nil, nil)
	_, err := flyClient.Machines.MachinesDelete(&machines.MachinesDeleteParams{MachineID: w.id}) // TODO: stop, not delete
	return err
}

func (w *PermutationWorker) UUID() string   { return w.id }
func (w *PermutationWorker) IP() netip.Addr { return w.ip }

func (w *DecryptionWorker) Start(ctx context.Context, in chan []byte, out chan []byte) error {
	return w.BaseWorker.Start(ctx, in, out, "decryption-service", "mattgonewild/decryption-service", func(conn *grpc.ClientConn) interface{} { return decrypt.NewDecryptClient(conn) }, Decryption)
}

func (w *DecryptionWorker) Stop() error {
	flyClient := fly.New(nil, nil)
	_, err := flyClient.Machines.MachinesDelete(&machines.MachinesDeleteParams{MachineID: w.id}) // TODO: stop, not delete
	return err
}

func (w *DecryptionWorker) UUID() string   { return w.id }
func (w *DecryptionWorker) IP() netip.Addr { return w.ip }

type WorkerFactory struct {
	ctx context.Context
}

func (f *WorkerFactory) NewWorker(t ServiceType, in chan []byte, out chan []byte) (Worker, error) {
	var worker Worker
	switch t {
	case Combination:
		worker = new(CombinationWorker)
	case Permutation:
		worker = new(PermutationWorker)
	case Decryption:
		worker = new(DecryptionWorker)
	default:
		return nil, errors.New("invalid service type")
	}
	err := worker.Start(f.ctx, in, out)
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
