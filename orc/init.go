package main

import (
	"errors"
	"flag"
	"fmt"
	"net/netip"
	"time"
)

type Config struct {
	ListenAndServeAPIAddr            string
	ListenAndServeAPIMaxShutdownTime time.Duration
	Budget                           int64
	MachineCost                      int64
	LoadThreshold                    float64
	ServiceCheckInterval             time.Duration
	MetAddr                          netip.AddrPort
}

func LoadConfig() (*Config, error) {
	apiAddr := flag.String("apiAddr", "127.0.0.1:54932", "IP:PORT to listen for API requests")
	maxShutdownTime := flag.String("maxShutdownTime", "5s", "max time to wait for shutdown (valid time units are \"ns\", \"us\" (or \"µs\"), \"ms\", \"s\", \"m\", \"h\")")
	budget := flag.Float64("budget", 300.00, "budget")
	machineCost := flag.Float64("machineCost", 1.00, "machine cost per second") // TODO: ...
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

	if *machineCost > *budget {
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

	return &Config{
		ListenAndServeAPIAddr:            addr.String(),
		ListenAndServeAPIMaxShutdownTime: msdt,
		Budget:                           int64(*budget * 100),
		MachineCost:                      int64(*machineCost * 100),
		LoadThreshold:                    *loadThreshold,
		ServiceCheckInterval:             sci,
		MetAddr:                          met,
	}, nil
}
