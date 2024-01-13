package main

import (
	"context"
	"errors"
	"fmt"
	"net/netip"
	"sync"

	"go.uber.org/zap"
)

type WorkerFactory struct {
	ctx  context.Context
	conf *Config
}

type WorkerManager struct {
	Factory        *WorkerFactory
	Mutex          sync.Mutex
	ActiveWorkers  map[string]*Worker
	StoppedWorkers map[string]*Worker
}

func (f *WorkerFactory) NewWorker(t ServiceType, in chan []byte, out chan []byte) (*Worker, error) {
	var (
		appName string
		image   string
		port    int
	)

	switch t {
	case Combination:
		appName = f.conf.ServiceConf[Combination].AppName
		image = f.conf.ServiceConf[Combination].Image
		port = f.conf.ServiceConf[Combination].Port
	case Permutation:
		appName = f.conf.ServiceConf[Permutation].AppName
		image = f.conf.ServiceConf[Permutation].Image
		port = f.conf.ServiceConf[Permutation].Port
	case Decryption:
		appName = f.conf.ServiceConf[Decryption].AppName
		image = f.conf.ServiceConf[Decryption].Image
		port = f.conf.ServiceConf[Decryption].Port
	default:
		return nil, errors.New("invalid service type")
	}

	worker := new(Worker)
	worker.addr = netip.AddrPortFrom(netip.Addr{}, uint16(port))

	err := worker.Init(f.ctx, f.conf.MachineCPU, f.conf.MachineRAM, appName, image, t)
	if err != nil {
		return nil, err
	}

	return worker, nil
}

func (m *WorkerManager) AddWorker(t ServiceType, in chan []byte, out chan []byte) error {
	var worker *Worker
	var err error

	m.Mutex.Lock()
	defer m.Mutex.Unlock()

	// check stopped
	if len(m.StoppedWorkers) > 0 {
		for uuid, stoppedWorker := range m.StoppedWorkers {
			err = stoppedWorker.Start(m.Factory.ctx, in, out)
			if err != nil {
				logger.Error("failed to start worker", zap.Error(err), zap.String("uuid", stoppedWorker.uuid))
				continue
			}
			worker = stoppedWorker
			delete(m.StoppedWorkers, uuid)
			break
		}
	}

	// otherwise get more help
	if worker == nil {
		worker, err = m.Factory.NewWorker(t, in, out)
		if err != nil {
			return err
		}
		err = worker.Start(m.Factory.ctx, in, out)
		if err != nil {
			return err
		}
	}

	m.ActiveWorkers[worker.uuid] = worker
	return nil
}

func (m *WorkerManager) StopWorker(uuid string) error {
	m.Mutex.Lock()
	defer m.Mutex.Unlock()
	worker, ok := m.ActiveWorkers[uuid]
	if !ok {
		return errors.New("worker not found")
	}
	err := worker.Stop()
	if err != nil {
		return err
	}
	delete(m.ActiveWorkers, uuid)
	m.StoppedWorkers[uuid] = worker
	return nil
}

func (m *WorkerManager) StopAnyWorker() {
	m.Mutex.Lock()
	defer m.Mutex.Unlock()
	for uuid, worker := range m.ActiveWorkers {
		err := worker.Stop()
		if err != nil {
			logger.Error("failed to stop worker", zap.Error(err),
				zap.String("uuid", worker.uuid), zap.String("ip", worker.addr.String()))
			continue
		}
		delete(m.ActiveWorkers, uuid)
		m.StoppedWorkers[uuid] = worker
		break
	}
}

func (m *WorkerManager) StopAllWorkers() {
	m.Mutex.Lock()
	defer m.Mutex.Unlock()
	for uuid, worker := range m.ActiveWorkers {
		err := worker.Stop()
		if err != nil {
			logger.Error("failed to stop worker", zap.Error(err),
				zap.String("uuid", worker.uuid), zap.String("ip", worker.addr.String()))
			continue
		}
		delete(m.ActiveWorkers, uuid)
		m.StoppedWorkers[uuid] = worker
	}
}

func (m *WorkerManager) DestroyAllWorkers() error {
	m.Mutex.Lock()
	defer m.Mutex.Unlock()

	errs := make([]error, 0, len(m.ActiveWorkers)+len(m.StoppedWorkers))

	// destroy active workers
	for uuid, worker := range m.ActiveWorkers {
		err := worker.Destroy()
		if err != nil {
			logger.Error("failed to destroy worker", zap.Error(err), zap.String("uuid", worker.uuid))
			errs = append(errs, err)
		} else {
			delete(m.ActiveWorkers, uuid)
		}
	}

	// destroy stopped workers
	for uuid, stoppedWorker := range m.StoppedWorkers {
		err := stoppedWorker.Destroy()
		if err != nil {
			logger.Error("failed to destroy worker", zap.Error(err), zap.String("uuid", stoppedWorker.uuid))
			errs = append(errs, err)
		} else {
			delete(m.StoppedWorkers, uuid)
		}
	}

	// return any errors that occured
	if len(errs) > 0 {
		return fmt.Errorf("errors while destroying workers: %v", errs)
	}

	return nil
}
