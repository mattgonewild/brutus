package main

import (
	"math"
	"sync/atomic"
)

type BudgetManager struct {
	Balance uint64
}

func (m *BudgetManager) CanAfford(cost float64) bool {
	return math.Float64frombits(atomic.LoadUint64(&m.Balance)) >= cost
}

func (m *BudgetManager) Deduct(cost float64) {
	for {
		old := atomic.LoadUint64(&m.Balance)
		new := math.Float64bits(math.Float64frombits(old) - cost)
		if atomic.CompareAndSwapUint64(&m.Balance, old, new) {
			return
		}
	}
}

func (m *BudgetManager) StoreBalance(amount float64) {
	atomic.StoreUint64(&m.Balance, math.Float64bits(amount))
}

func (m *BudgetManager) LoadBalance() float64 {
	return math.Float64frombits(atomic.LoadUint64(&m.Balance))
}
