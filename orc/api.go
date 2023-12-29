package main

import (
	"context"
	"io"
	"net/http"
	"time"

	orc "github.com/mattgonewild/brutus/orc/proto"
	"google.golang.org/protobuf/proto"
)

type APIServer struct {
	BudgetManager            *BudgetManager
	CombinationWorkerManager *WorkerManager
	PermutationWorkerManager *WorkerManager
	DecryptionWorkerManager  *WorkerManager
}

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		next.ServeHTTP(w, r)
	})
}

func (s *APIServer) handle() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleBudget() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			time, err := time.Now().MarshalText()
			if err != nil {
				// TODO: ...
				http.Error(w, "failed to get time", http.StatusInternalServerError)
				return
			}

			balance := &orc.Budget{Timestamp: string(time), Balance: s.BudgetManager.LoadBalance()}

			data, err := proto.Marshal(balance)
			if err != nil {
				//  TODO: ...
				http.Error(w, "failed to encode budget", http.StatusInternalServerError)
				return
			}

			w.Write(data)
		case http.MethodPost:
			body, err := io.ReadAll(r.Body)
			if err != nil {
				http.Error(w, "failed to read request body", http.StatusInternalServerError)
			}

			budget := &orc.Budget{}

			if err := proto.Unmarshal(body, budget); err != nil {
				http.Error(w, "failed to decode budget", http.StatusBadRequest)
				return
			}

			s.BudgetManager.StoreBalance(budget.Balance)
			w.WriteHeader(http.StatusNoContent)
		default:
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkers() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleWorker() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleWorkerProc() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleWorkerCpu() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleWorkerMem() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleWorkerNet() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleWorkerUptime() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleWorkerLoadavg() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleLog() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}
func (s *APIServer) handleShutdown() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {})
}

func ListenAndServeAPI(addr string, shutdownCtx context.Context) error {
	mux := http.NewServeMux()
	srv := &http.Server{
		Addr:    addr,
		Handler: loggingMiddleware(mux),
	}

	api := APIServer{}

	// register handlers
	mux.Handle("/", loggingMiddleware(api.handle()))
	mux.Handle("/budget", loggingMiddleware(api.handleBudget()))
	mux.Handle("/workers", loggingMiddleware(api.handleWorkers()))
	mux.Handle("/workers/{id}", loggingMiddleware(api.handleWorker()))
	mux.Handle("/workers/{id}/proc", loggingMiddleware(api.handleWorkerProc()))
	mux.Handle("/workers/{id}/proc/cpu", loggingMiddleware(api.handleWorkerCpu()))
	mux.Handle("/workers/{id}/proc/mem", loggingMiddleware(api.handleWorkerMem()))
	mux.Handle("/workers/{id}/proc/net", loggingMiddleware(api.handleWorkerNet()))
	mux.Handle("/workers/{id}/proc/uptime", loggingMiddleware(api.handleWorkerUptime()))
	mux.Handle("/workers/{id}/proc/loadavg", loggingMiddleware(api.handleWorkerLoadavg()))
	mux.Handle("/log", loggingMiddleware(api.handleLog()))
	mux.Handle("/shutdown", loggingMiddleware(api.handleShutdown()))

	// start server in a goroutine so that it doesn't block.
	go func() {
		if err := srv.ListenAndServe(); err != http.ErrServerClosed {
			// TODO: error starting or closing listener
		}
	}()

	<-shutdownCtx.Done()

	// attempt to gracefully shutdown the server
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := srv.Shutdown(ctx); err != nil {
		// TODO: error from closing listeners, or context timeout:
	}

	return nil
}
