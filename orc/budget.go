package main

import "sync/atomic"

type BudgetManager struct {
	Balance int64
}

func (m *BudgetManager) CanAfford(cost int64) bool {
	return atomic.LoadInt64(&m.Balance) >= int64(cost)
}

func (m *BudgetManager) Deduct(cost int64) {
	atomic.AddInt64(&m.Balance, -int64(cost))
}

func (m *BudgetManager) StoreBalance(amount int64) {
	atomic.StoreInt64(&m.Balance, amount)
}

func (m *BudgetManager) LoadBalance() int64 {
	return atomic.LoadInt64(&m.Balance)
}
