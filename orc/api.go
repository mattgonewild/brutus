package main

import (
	"context"
	"io"
	"net/http"
	"syscall"
	"time"

	"github.com/google/uuid"
	orc "github.com/mattgonewild/brutus/orc/proto"
	"go.uber.org/zap"
	"google.golang.org/protobuf/proto"
)

type APIServer struct {
	BudgetManager            *BudgetManager
	CombinationWorkerManager *WorkerManager
	PermutationWorkerManager *WorkerManager
	DecryptionWorkerManager  *WorkerManager
}

type RequestID string

type RequestCTX struct {
	context.Context
}

func (c RequestCTX) ID() string {
	return c.Value(RequestID("request_id")).(uuid.UUID).String()
}

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start, id := time.Now(), uuid.New().String()
		ctx := &RequestCTX{context.WithValue(r.Context(), RequestID("request_id"), id)}
		next.ServeHTTP(w, r.WithContext(ctx))

		logger.Info("api request", zap.String("method", r.Method), zap.String("path", r.URL.Path),
			zap.String("remote_addr", r.RemoteAddr), zap.String("user_agent", r.UserAgent()),
			zap.Duration("duration", time.Since(start)), zap.String("request_id", id))

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
				logger.Error("failed to marshal time", zap.Error(err), zap.String("request_id", RequestCTX{r.Context()}.ID()))
				http.Error(w, "failed to get time", http.StatusInternalServerError)
				return
			}

			balance := &orc.Budget{Timestamp: string(time), Balance: s.BudgetManager.LoadBalance()}

			data, err := proto.Marshal(balance)
			if err != nil {
				logger.Error("failed to encode budget", zap.Error(err), zap.String("request_id", RequestCTX{r.Context()}.ID()))
				http.Error(w, "failed to encode budget", http.StatusInternalServerError)
				return
			}

			w.Write(data)
		case http.MethodPost:
			body, err := io.ReadAll(r.Body)
			if err != nil {
				logger.Error("failed to read request body", zap.Error(err), zap.String("request_id", RequestCTX{r.Context()}.ID()))
				http.Error(w, "failed to read request body", http.StatusInternalServerError)
			}

			budget := &orc.Budget{}

			if err := proto.Unmarshal(body, budget); err != nil {
				logger.Error("failed to decode budget", zap.Error(err), zap.String("request_id", RequestCTX{r.Context()}.ID()))
				http.Error(w, "failed to decode budget", http.StatusBadRequest)
				return
			}

			s.BudgetManager.StoreBalance(budget.Balance)
			w.WriteHeader(http.StatusNoContent)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkers() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			workers := &orc.Workers{}

			s.CombinationWorkerManager.Mutex.Lock()
			for _, worker := range s.CombinationWorkerManager.Workers {
				// TODO: query metric service for each worker by id and append to workers
				worker = worker
			}
			s.CombinationWorkerManager.Mutex.Unlock()

			s.PermutationWorkerManager.Mutex.Lock()
			for _, worker := range s.PermutationWorkerManager.Workers {
				// TODO: query metric service for each worker by id and append to workers
				worker = worker
			}
			s.PermutationWorkerManager.Mutex.Unlock()

			s.DecryptionWorkerManager.Mutex.Lock()
			for _, worker := range s.DecryptionWorkerManager.Workers {
				// TODO: query metric service for each worker by id and append to workers
				worker = worker
			}
			s.DecryptionWorkerManager.Mutex.Unlock()

			data, err := proto.Marshal(workers)
			if err != nil {
				logger.Error("failed to encode workers", zap.Error(err), zap.String("request_id", RequestCTX{r.Context()}.ID()))
				http.Error(w, "failed to encode workers", http.StatusInternalServerError)
				return
			}

			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorker() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodPost:
			// TODO: add worker type
		case http.MethodDelete:
			// TODO: delete worker by id
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkerProc() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// TODO: query metric service for worker proc by id
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkerCpu() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// TODO: query metric service for worker cpu by id
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkerMem() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// TODO: query metric service for worker mem by id
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkerNet() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// TODO: query metric service for worker net by id
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkerUptime() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// TODO: query metric service for worker uptime by id
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleWorkerLoadavg() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// TODO: query metric service for worker loadavg by id
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}
func (s *APIServer) handleLog() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			// TODO: ...
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
		}
	})
}
func (s *APIServer) handleShutdown() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodPost:
			logger.Info("api shutdown request, shutting down...", zap.String("request_id", RequestCTX{r.Context()}.ID()))
			syscall.Kill(syscall.Getegid(), syscall.SIGTERM)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", RequestCTX{r.Context()}.ID()))
		}
	})
}

func ListenAndServeAPI(shutdownCtx context.Context, config *Config, api *APIServer) error {
	mux := http.NewServeMux()
	srv := &http.Server{
		Addr:    config.ListenAndServeAPIAddr,
		Handler: loggingMiddleware(mux),
	}

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
			logger.Fatal("failed to start api server", zap.Error(err))
		}
	}()

	<-shutdownCtx.Done()

	// attempt to gracefully shutdown the server
	ctx, cancel := context.WithTimeout(context.Background(), config.ListenAndServeAPIMaxShutdownTime)
	defer cancel()

	if err := srv.Shutdown(ctx); err != nil {
		logger.Warn("failed to shutdown api server gracefully", zap.Error(err))
	}

	return nil
}
