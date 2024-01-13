// TODO: better validation and error messages
package main

import (
	"errors"
	"flag"
	"fmt"
	"math"
	"net/netip"
	"os"
	"time"

	"gopkg.in/yaml.v3"
)

type Plans struct {
	Plans map[int64]float64 `yaml:"plans"`
}

type Machines struct {
	Machines map[string]Plans `yaml:",inline"`
}

type ServiceConf struct {
	AppName string `yaml:"appName"`
	Image   string `yaml:"image"`
	Port    int    `yaml:"port"`
}

type Config struct {
	ListenAndServeAPIAddr            string
	ListenAndServeAPIMaxShutdownTime time.Duration
	Budget                           float64
	MachineCPU                       string
	MachineRAM                       int64
	MachineCost                      float64
	LoadThreshold                    float64
	ServiceCheckInterval             time.Duration
	MetAddr                          netip.AddrPort
	ServiceConf                      map[ServiceType]ServiceConf `yaml:"services"`
}

func LoadConfig() (*Config, error) {
	apiAddr := flag.String("apiAddr", "127.0.0.1:54932", "IP:PORT to listen for API requests")
	maxShutdownTime := flag.String("maxShutdownTime", "5s", "max time to wait for shutdown (valid time units are \"ns\", \"us\" (or \"µs\"), \"ms\", \"s\", \"m\", \"h\")")
	budget := flag.Float64("budget", 300.00, "budget")
	machineCPU := flag.String("machineCPU", "shared-cpu-1x", "machine CPU: names must match https://fly.io/docs/about/pricing/ (i.e. shared-cpu-1x, etc...)")
	machineRAM := flag.Int64("machineRAM", 256, "machine RAM: values must match https://fly.io/docs/about/pricing/ represented as MB")
	loadThreshold := flag.Float64("loadThreshold", 1.0, "load threshold... above which a new worker is started, below which a worker is stopped")
	serviceCheckInterval := flag.String("serviceCheckInterval", "1s", "how often the budget and machine loads are checked (valid time units are \"ns\", \"us\" (or \"µs\"), \"ms\", \"s\", \"m\", \"h\")")
	metAddr := flag.String("metAddr", "127.0.0.1:54933", "IP:PORT of metric service")

	flag.Parse()

	addr, err := netip.ParseAddrPort(*apiAddr)
	if err != nil {
		return nil, fmt.Errorf("invalid address: %w", err)
	}

	if !addr.IsValid() {
		return nil, errors.New("invalid address")
	}

	msdt, err := time.ParseDuration(*maxShutdownTime)
	if err != nil {
		return nil, fmt.Errorf("invalid max shutdown time: %w", err)
	}

	_, err = safeFloat64ToUint64(*budget)
	if err != nil {
		return nil, fmt.Errorf("error converting budget to uint64: %w", err)
	}

	data, err := os.ReadFile("machines.yaml")
	if err != nil {
		return nil, fmt.Errorf("failed to read machines.yaml: %w", err)
	}

	m := new(Machines)
	err = yaml.Unmarshal(data, m)
	if err != nil {
		return nil, fmt.Errorf("failed to unmarshal machines.yaml: %w", err)
	}

	// check valid cpu
	if _, ok := m.Machines[*machineCPU]; !ok {
		return nil, fmt.Errorf("invalid machine CPU: %s", *machineCPU)
	}

	// check valid ram
	if _, ok := m.Machines[*machineCPU].Plans[*machineRAM]; !ok {
		return nil, fmt.Errorf("invalid machine RAM: %d", *machineRAM)
	}

	// check cost
	if m.Machines[*machineCPU].Plans[*machineRAM] > *budget {
		return nil, errors.New("machine cost cannot be greater than budget")
	}

	sci, err := time.ParseDuration(*serviceCheckInterval)
	if err != nil {
		return nil, fmt.Errorf("invalid service check interval: %w", err)
	}

	met, err := netip.ParseAddrPort(*metAddr)
	if err != nil {
		return nil, fmt.Errorf("invalid address: %w", err)
	}

	conf := new(Config)

	data, err = os.ReadFile("services.yaml")
	if err != nil {
		return nil, fmt.Errorf("failed to read services.yaml: %w", err)
	}

	err = yaml.Unmarshal(data, conf)
	if err != nil {
		return nil, fmt.Errorf("failed to unmarshal services.yaml: %w", err)
	}

	err = validatePort(conf.ServiceConf[Combination].Port)
	if err != nil {
		return nil, fmt.Errorf("invalid port for combination service: %w", err)
	}

	err = validatePort(conf.ServiceConf[Permutation].Port)
	if err != nil {
		return nil, fmt.Errorf("invalid port for permutation service: %w", err)
	}

	err = validatePort(conf.ServiceConf[Decryption].Port)
	if err != nil {
		return nil, fmt.Errorf("invalid port for decryption service: %w", err)
	}

	conf.ListenAndServeAPIAddr = addr.String()
	conf.ListenAndServeAPIMaxShutdownTime = msdt
	conf.Budget = *budget
	conf.MachineCPU = *machineCPU
	conf.MachineRAM = *machineRAM
	conf.MachineCost = m.Machines[*machineCPU].Plans[*machineRAM]
	conf.LoadThreshold = *loadThreshold
	conf.ServiceCheckInterval = sci
	conf.MetAddr = met

	return conf, nil
}

func validatePort(port int) error {
	if port < 0 {
		return errors.New("port cannot be negative")
	}
	if port > 65535 {
		return errors.New("port cannot be greater than 65535")
	}
	return nil
}

func safeFloat64ToUint64(f float64) (uint64, error) {
	if f < 0 {
		return 0, fmt.Errorf("cannot convert negative float64 to uint64")
	}
	if f != math.Trunc(f) {
		return 0, fmt.Errorf("cannot convert float64 with fractional part to uint64")
	}
	if f > math.MaxUint64 {
		return 0, fmt.Errorf("float64 is too large to convert to uint64")
	}
	return uint64(f), nil
}
