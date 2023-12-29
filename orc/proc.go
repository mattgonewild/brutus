package main

import "time"

type Proc struct {
	Cpu     Cpu
	Mem     Mem
	Net     Net
	Uptime  Uptime
	LoadAvg LoadAvg
}

type Cpu struct {
	Used  uint64
	Total uint64
}

type Mem struct {
	Used      uint64
	Total     uint64
	SwapUsed  uint64
	SwapTotal uint64
}

type Net struct {
	Rx uint64
	Tx uint64
}

type Uptime struct {
	Duration time.Duration
}

type LoadAvg struct {
	OneMinute      float64
	FiveMinutes    float64
	FifteenMinutes float64
}
