package main

import (
	"errors"
	"net/netip"
	"sync"

	fly "github.com/mattgonewild/fly/client"
	"github.com/mattgonewild/fly/client/machines"
	"github.com/mattgonewild/fly/models"
	"go.uber.org/zap"
)

type Worker interface {
	Start(in chan string, out chan string) error
	Stop() error
	UUID() string
	IP() netip.Addr
}

type CombinationWorker struct {
	id string
	ip netip.Addr
}

type PermutationWorker struct {
	id string
	ip netip.Addr
}

type DecryptionWorker struct {
	id string
	ip netip.Addr
}

func (w *CombinationWorker) Start(in chan string, out chan string) error {
	flyClient := fly.New(nil, nil)

	resp, err := flyClient.Machines.MachinesCreate(&machines.MachinesCreateParams{AppName: "combination-service", Request: &models.CreateMachineRequest{
		Config: struct{ models.APIMachineConfig }{
			APIMachineConfig: models.APIMachineConfig{
				AutoDestroy: true,
				Image:       "mattgonewild/combination-service",
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

	go func() {
		// TODO: connect to combination service at w.ip
	}()

	return err
}

func (w *CombinationWorker) Stop() error    { return nil }
func (w *CombinationWorker) UUID() string   { return w.id }
func (w *CombinationWorker) IP() netip.Addr { return w.ip }

func (w *PermutationWorker) Start(in chan string, out chan string) error { return nil }
func (w *PermutationWorker) Stop() error                                 { return nil }
func (w *PermutationWorker) UUID() string                                { return w.id }
func (w *PermutationWorker) IP() netip.Addr                              { return w.ip }

func (w *DecryptionWorker) Start(in chan string, out chan string) error { return nil }
func (w *DecryptionWorker) Stop() error                                 { return nil }
func (w *DecryptionWorker) UUID() string                                { return w.id }
func (w *DecryptionWorker) IP() netip.Addr                              { return w.ip }

type WorkerFactory struct{}

func (f *WorkerFactory) NewWorker(t ServiceType, in chan string, out chan string) (Worker, error) {
	var worker Worker
	switch t {
	case Combination:
		worker = new(CombinationWorker)
	case Permutation:
		worker = new(PermutationWorker)
	case Decryption:
		worker = new(DecryptionWorker)
	}
	err := worker.Start(in, out)
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

func (m *WorkerManager) AddWorker(t ServiceType, in chan string, out chan string) error {
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
