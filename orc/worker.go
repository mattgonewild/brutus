package main

import (
	"context"
	"net/netip"
	"sync"
	"time"

	transport "github.com/go-openapi/runtime/client"

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

type Worker struct {
	uuid   string
	class  ServiceType
	addr   netip.AddrPort
	client func(conn *grpc.ClientConn) interface{}
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

func (w *Worker) Init(ctx context.Context, machineCPU string, machineRAM int64, appName string, image string, serviceType ServiceType) error {
	flyClient := fly.New(transport.New("api.machines.dev", "/v1", []string{"https"}), nil)
	machineConf := models.APIMachineConfig{
		Checks:   map[string]models.APIMachineCheck{"headers": {Headers: []*models.APIMachineHTTPHeader{{Name: "Authorization", Values: []string{""}}}}},
		Services: []*models.APIMachineService{{Autostart: false}},
		Image:    image,
		Guest: &models.APIMachineGuest{
			CPUKind:  machineCPU,
			MemoryMb: machineRAM,
		},
	}

	// create
	resp, err := flyClient.Machines.MachinesCreate(&machines.MachinesCreateParams{AppName: appName, Request: &models.CreateMachineRequest{
		Config: struct{ models.APIMachineConfig }{
			APIMachineConfig: machineConf,
		},
	}})

	if err != nil {
		logger.Error("error creating worker", zap.Error(err), zap.String("type", string(serviceType)))
		return err
	}

	w.uuid = resp.Payload.ID
	w.class = serviceType

	switch serviceType {
	case Combination:
		w.client = func(conn *grpc.ClientConn) interface{} { return comb.NewCombClient(conn) }
	case Permutation:
		w.client = func(conn *grpc.ClientConn) interface{} { return perm.NewPermClient(conn) }
	case Decryption:
		w.client = func(conn *grpc.ClientConn) interface{} { return decrypt.NewDecryptClient(conn) }
	}

	return err
}

func (w *Worker) Start(ctx context.Context, in chan []byte, out chan []byte) error {
	// TODO: start and mod w.addr
	conn, err := grpc.DialContext(ctx, w.addr.String(), grpc.WithInsecure())
	if err != nil {
		logger.Error("error dialing service", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
		return err
	}
	defer conn.Close()

	client := w.client(conn)

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
		logger.Error("error connecting to service", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
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
						logger.Error("failed to unmarshal request", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
						continue
					}
					if err := t.Send(req); err != nil {
						logger.Error("failed to send request", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
						return
					}
				case PermStream:
					req := new(perm.Combination)
					err := proto.Unmarshal(bytes, req)
					if err != nil {
						logger.Error("failed to unmarshal request", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
						continue
					}
					if err := t.Send(req); err != nil {
						logger.Error("failed to send request", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
						return
					}
				case DecryptStream:
					req := new(decrypt.Permutation)
					err := proto.Unmarshal(bytes, req)
					if err != nil {
						logger.Error("failed to unmarshal request", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
						continue
					}
					if err := t.Send(req); err != nil {
						logger.Error("failed to send request", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
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
				logger.Error("failed to receive response", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
				return
			}

			bytes, err := proto.Marshal(resp)
			if err != nil {
				logger.Error("failed to marshal response", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
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
		logger.Error("error closing stream", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
		return err
	}

	return nil
}

func (w *Worker) Stop() error {
	conn, err := grpc.DialContext(context.TODO(), w.addr.String(), grpc.WithInsecure())
	if err != nil {
		logger.Error("error dialing service", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
		return err
	}
	defer conn.Close()

	client := w.client(conn).(interface {
		Shutdown(context.Context, *emptypb.Empty) (*emptypb.Empty, error)
	})

	_, err = client.Shutdown(context.TODO(), &emptypb.Empty{})
	if err != nil {
		logger.Error("error shutting down worker gracefully", zap.Error(err), zap.String("type", string(w.class)), zap.String("ip", w.addr.String()))
	} else {
		time.Sleep(2 * time.Second)
	}

	flyClient := fly.New(transport.New("api.machines.dev", "/v1", []string{"https"}), nil)
	_, err = flyClient.Machines.MachinesStop(&machines.MachinesStopParams{MachineID: w.uuid})
	return err
}

func (w *Worker) Destroy() error {
	flyClient := fly.New(transport.New("api.machines.dev", "/v1", []string{"https"}), nil)
	_, err := flyClient.Machines.MachinesDelete(&machines.MachinesDeleteParams{MachineID: w.uuid})
	return err
}
