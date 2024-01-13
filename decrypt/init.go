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
	MetAddr                          netip.AddrPort
}

func LoadConfig() (*Config, error) {
	apiAddr := flag.String("apiAddr", "127.0.0.1:54936", "IP:PORT to listen for API requests")
	maxShutdownTime := flag.String("maxShutdownTime", "5s", "max time to wait for shutdown (valid time units are \"ns\", \"us\" (or \"µs\"), \"ms\", \"s\", \"m\", \"h\")")
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

	met, err := netip.ParseAddrPort(*metAddr)
	if err != nil {
		return nil, fmt.Errorf("invalid address: %w", err)
	}

	return &Config{
		ListenAndServeAPIAddr:            addr.String(),
		ListenAndServeAPIMaxShutdownTime: msdt,
		MetAddr:                          met,
	}, nil
}
