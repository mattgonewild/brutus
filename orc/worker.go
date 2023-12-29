package main

import (
	"crypto/tls"
	"net/netip"
	"sync"

	"github.com/google/uuid"
)

type Worker interface {
	Start(in chan string, out chan string) error
	Stop()
	UUID() uuid.UUID
	IP() netip.Addr
	TlsConfig() *tls.Config
	Proc() Proc
}

type CombinationWorker struct {
	id        uuid.UUID
	ip        netip.Addr
	tlsConfig *tls.Config
	proc      Proc
}

type PermutationWorker struct {
	id        uuid.UUID
	ip        netip.Addr
	tlsConfig *tls.Config
	proc      Proc
}

type DecryptionWorker struct {
	id        uuid.UUID
	ip        netip.Addr
	tlsConfig *tls.Config
	proc      Proc
}

func (w *CombinationWorker) Start(in chan string, out chan string) error { return nil }
func (w *CombinationWorker) Stop()                                       {}
func (w *CombinationWorker) UUID() uuid.UUID                             { return w.id }
func (w *CombinationWorker) IP() netip.Addr                              { return w.ip }
func (w *CombinationWorker) TlsConfig() *tls.Config                      { return w.tlsConfig }
func (w *CombinationWorker) Proc() Proc                                  { return w.proc }

func (w *PermutationWorker) Start(in chan string, out chan string) error { return nil }
func (w *PermutationWorker) Stop()                                       {}
func (w *PermutationWorker) UUID() uuid.UUID                             { return w.id }
func (w *PermutationWorker) IP() netip.Addr                              { return w.ip }
func (w *PermutationWorker) TlsConfig() *tls.Config                      { return w.tlsConfig }
func (w *PermutationWorker) Proc() Proc                                  { return w.proc }

func (w *DecryptionWorker) Start(in chan string, out chan string) error { return nil }
func (w *DecryptionWorker) Stop()                                       {}
func (w *DecryptionWorker) UUID() uuid.UUID                             { return w.id }
func (w *DecryptionWorker) IP() netip.Addr                              { return w.ip }
func (w *DecryptionWorker) TlsConfig() *tls.Config                      { return w.tlsConfig }
func (w *DecryptionWorker) Proc() Proc                                  { return w.proc }

type WorkerFactory struct{}

func (f *WorkerFactory) NewWorker(t ServiceType, in chan string, out chan string) (Worker, error) {
	var worker Worker
	id := uuid.New()
	switch t {
	case Combination:
		worker = &CombinationWorker{id: id}
	case Permutation:
		worker = &PermutationWorker{id: id}
	case Decryption:
		worker = &DecryptionWorker{id: id}
	}
	err := worker.Start(in, out)
	if err != nil {
		return nil, err
	}
	return worker, nil
}

type WorkerManager struct {
	Workers map[uuid.UUID]Worker
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

func (m *WorkerManager) RemoveWorker() {
	m.Mutex.Lock()
	defer m.Mutex.Unlock()
	for id, worker := range m.Workers {
		worker.Stop()
		delete(m.Workers, id)
		break
	}
}
