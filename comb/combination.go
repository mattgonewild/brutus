// https://github.com/carlmjohnson/go-utils/blob/master/combinations/combinations.go
package main

import (
	brutus "github.com/mattgonewild/brutus/proto/go"
)

// Iterator iterates through the length K combinations of
// an N sized set. E.g. for K = 2 and N = 3, it sets Comb to {0, 1},
// then {0, 2}, and finally {1, 2}.
type Iterator struct {
	N, K int
	Comb []int
}

// Init initializes Comb as []int{0, 1, ..., k-1}. Automatically called
// on first call to Next().
func (c *Iterator) Init() {
	c.Comb = make([]int, c.K)
	for i := 0; i < c.K; i++ {
		c.Comb[i] = i
	}
}

// Next sets Comb to the next combination in lexicographic order.
// Returns false if Comb is already the last combination in
// lexicographic order. Initializes Comb if it doesn't exist.
func (c *Iterator) Next() bool {
	var (
		i int
	)

	if len(c.Comb) != c.K {
		c.Init()
		return true
	}

	// Combination (n-k, n-k+1, ..., n) reached
	// No more combinations can be generated
	if c.Comb[0] == c.N-c.K {
		return false
	}

	for i = c.K - 1; i >= 0; i-- {
		c.Comb[i]++
		if c.Comb[i] < c.N-c.K+1+i {
			break
		}
	}

	// c.Comb now looks like (..., x, n, n, n, ..., n).
	// Turn it into (..., x, x + 1, x + 2, ...)
	for i = i + 1; i < c.K; i++ {
		c.Comb[i] = c.Comb[i-1] + 1
	}

	return true
}

// ElementCombinatorK iterates through combinations of length K.
//
// E.g. For "abc", 2; Comb is set to "ab", "ac", and "bc" succesively.
type ElementCombinatorK struct {
	Comb []*brutus.Element
	src  []*brutus.Element
	// This is private because it violates the law of Demeter
	i Iterator
}

func NewElementCombinatorK(src []*brutus.Element, k int) ElementCombinatorK {
	return ElementCombinatorK{
		src: src,
		i: Iterator{
			N: len(src),
			K: k,
		},
	}
}

func (s *ElementCombinatorK) Next() bool {
	if !s.i.Next() {
		return false
	}

	src := s.src
	comb := make([]*brutus.Element, len(s.i.Comb))
	for i, v := range s.i.Comb {
		comb[i] = src[v]
	}
	s.Comb = comb

	return true
}

// ElementCombinator iterates through all sub-string combinations of its source
// from shortest to longest.
type ElementCombinator struct {
	sk   ElementCombinatorK
	Comb []*brutus.Element
}

func NewElementCombinator(src []*brutus.Element) ElementCombinator {
	return ElementCombinator{
		sk: NewElementCombinatorK(src, 1),
	}
}

func (s *ElementCombinator) Next() bool {
	if !s.sk.Next() {
		if s.sk.i.K+1 > len(s.sk.src) {
			return false
		}
		s.sk.i.K++
		s.sk.Next()
	}
	s.Comb = s.sk.Comb
	return true
}
