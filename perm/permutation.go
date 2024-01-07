package main

import (
	"context"
	"strings"
)

func GeneratePermutations(ctx context.Context, n int, elements []string, out chan string) {
	if err := ctx.Err(); err != nil {
		return
	}
	if n == 1 {
		var builder strings.Builder
		for _, element := range elements {
			builder.WriteString(element)
		}
		select {
		case out <- builder.String():
		case <-ctx.Done():
			return
		}
	} else {
		for i := 0; i < n-1; i++ {
			GeneratePermutations(ctx, n-1, elements, out)
			if err := ctx.Err(); err != nil {
				return
			}
			if n%2 == 0 {
				elements[i], elements[n-1] = elements[n-1], elements[i]
			} else {
				elements[0], elements[n-1] = elements[n-1], elements[0]
			}
		}
		GeneratePermutations(ctx, n-1, elements, out)
	}
}
