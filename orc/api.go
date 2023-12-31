package main

import (
	"context"
	"io"
	"net/http"
	"strings"
	"syscall"
	"time"

	"github.com/google/uuid"
	"go.uber.org/zap"
	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/types/known/timestamppb"

	met "github.com/mattgonewild/brutus/met/proto"
	orc "github.com/mattgonewild/brutus/orc/proto"
)

type APIServer struct {
	BudgetManager            *BudgetManager
	CombinationWorkerManager *WorkerManager
	PermutationWorkerManager *WorkerManager
	DecryptionWorkerManager  *WorkerManager
	MetricsClient            met.MetClient
}

type key int

const (
	WorkerIDKey key = iota
	RequestIDKey
)

func WithWorkerID(ctx context.Context, workerID string) context.Context {
	return context.WithValue(ctx, WorkerIDKey, workerID)
}

func GetWorkerID(ctx context.Context) string {
	workerID, ok := ctx.Value(WorkerIDKey).(string)
	if !ok {
		logger.Warn("failed to get worker id from context", zap.String("request_id", GetRequestID(ctx)))
		return ""
	}
	return workerID
}

func WithRequestID(ctx context.Context, requestID string) context.Context {
	return context.WithValue(ctx, RequestIDKey, requestID)
}

func GetRequestID(ctx context.Context) string {
	requestID, ok := ctx.Value(RequestIDKey).(string)
	if !ok {
		logger.Warn("failed to get request id from context")
		return ""
	}
	return requestID
}

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		requestID := uuid.New().String()

		ctx := WithRequestID(r.Context(), requestID)

		pathSegments := strings.Split(r.URL.Path, "/")
		if len(pathSegments) >= 3 && pathSegments[1] == "workers" {
			workerID := pathSegments[2]
			ctx = WithWorkerID(ctx, workerID)
		}

		r = r.WithContext(ctx)

		next.ServeHTTP(w, r)

		logger.Info("api request", zap.String("method", r.Method), zap.String("path", r.URL.Path),
			zap.String("remote_addr", r.RemoteAddr), zap.String("user_agent", r.UserAgent()),
			zap.Duration("duration", time.Since(start)), zap.String("request_id", requestID))
	})
}

func (s *APIServer) handle() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		http.Error(w, "invalid method", http.StatusMethodNotAllowed)
	})
}

func (s *APIServer) handleBudget() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			balance := &orc.Budget{Timestamp: timestamppb.Now(), Balance: s.BudgetManager.LoadBalance()}

			data, err := proto.Marshal(balance)
			if err != nil {
				logger.Error("failed to encode budget", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
				http.Error(w, "failed to encode budget", http.StatusInternalServerError)
				return
			}

			w.Write(data)
		case http.MethodPost:
			body, err := io.ReadAll(r.Body)
			if err != nil {
				logger.Error("failed to read request body", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
				http.Error(w, "failed to read request body", http.StatusInternalServerError)
			}

			budget := &orc.Budget{}
			if err := proto.Unmarshal(body, budget); err != nil {
				logger.Error("failed to decode budget", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
				http.Error(w, "failed to decode budget", http.StatusBadRequest)
				return
			}

			s.BudgetManager.StoreBalance(budget.Balance)
			w.WriteHeader(http.StatusNoContent)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}

func (s *APIServer) handleWorkers() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			workers := make([]*met.Worker, len(s.CombinationWorkerManager.Workers)+len(s.PermutationWorkerManager.Workers)+len(s.DecryptionWorkerManager.Workers))

			s.CombinationWorkerManager.Mutex.Lock()
			for _, worker := range s.CombinationWorkerManager.Workers {
				resp, err := s.MetricsClient.GetWorker(r.Context(), &met.WorkerRequest{Id: worker.UUID()})
				if err != nil {
					logger.Error("failed to get worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", worker.UUID()))
					continue
				}
				workers = append(workers, resp.Worker)
			}
			s.CombinationWorkerManager.Mutex.Unlock()

			s.PermutationWorkerManager.Mutex.Lock()
			for _, worker := range s.PermutationWorkerManager.Workers {
				resp, err := s.MetricsClient.GetWorker(r.Context(), &met.WorkerRequest{Id: worker.UUID()})
				if err != nil {
					logger.Error("failed to get worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", worker.UUID()))
					continue
				}
				workers = append(workers, resp.Worker)
			}
			s.PermutationWorkerManager.Mutex.Unlock()

			s.DecryptionWorkerManager.Mutex.Lock()
			for _, worker := range s.DecryptionWorkerManager.Workers {
				resp, err := s.MetricsClient.GetWorker(r.Context(), &met.WorkerRequest{Id: worker.UUID()})
				if err != nil {
					logger.Error("failed to get worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", worker.UUID()))
					continue
				}
				workers = append(workers, resp.Worker)
			}
			s.DecryptionWorkerManager.Mutex.Unlock()

			data, err := proto.Marshal(&met.WorkersResponse{Workers: workers}) // TODO: ...
			if err != nil {
				logger.Error("failed to encode workers", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
				http.Error(w, "failed to encode workers", http.StatusInternalServerError)
				return
			}

			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
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
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}

func (s *APIServer) handleWorkerProc() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			resp, err := s.MetricsClient.GetWorkerProc(r.Context(), &met.WorkerRequest{Id: GetWorkerID(r.Context())})
			if err != nil {
				logger.Error("failed to get worker proc", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to get worker proc", http.StatusInternalServerError)
				return
			}
			data, err := proto.Marshal(resp.Proc)
			if err != nil {
				logger.Error("failed to encode worker proc", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to encode worker proc", http.StatusInternalServerError)
				return
			}
			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}

func (s *APIServer) handleWorkerCpu() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			resp, err := s.MetricsClient.GetWorkerCpu(r.Context(), &met.WorkerRequest{Id: GetWorkerID(r.Context())})
			if err != nil {
				logger.Error("failed to get worker cpu", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to get worker cpu", http.StatusInternalServerError)
				return
			}
			data, err := proto.Marshal(resp.Cpu)
			if err != nil {
				logger.Error("failed to encode worker cpu", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to encode worker cpu", http.StatusInternalServerError)
				return
			}
			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}

func (s *APIServer) handleWorkerMem() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			resp, err := s.MetricsClient.GetWorkerMem(r.Context(), &met.WorkerRequest{Id: GetWorkerID(r.Context())})
			if err != nil {
				logger.Error("failed to get worker mem", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to get worker mem", http.StatusInternalServerError)
				return
			}
			data, err := proto.Marshal(resp.Mem)
			if err != nil {
				logger.Error("failed to encode worker mem", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to encode worker mem", http.StatusInternalServerError)
				return
			}
			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}

func (s *APIServer) handleWorkerNet() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			resp, err := s.MetricsClient.GetWorkerNet(r.Context(), &met.WorkerRequest{Id: GetWorkerID(r.Context())})
			if err != nil {
				logger.Error("failed to get worker net", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to get worker net", http.StatusInternalServerError)
				return
			}
			data, err := proto.Marshal(resp.Net)
			if err != nil {
				logger.Error("failed to encode worker net", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to encode worker net", http.StatusInternalServerError)
				return
			}
			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}

func (s *APIServer) handleWorkerUptime() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			resp, err := s.MetricsClient.GetWorkerUptime(r.Context(), &met.WorkerRequest{Id: GetWorkerID(r.Context())})
			if err != nil {
				logger.Error("failed to get worker uptime", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to get worker uptime", http.StatusInternalServerError)
				return
			}
			data, err := proto.Marshal(resp.Uptime)
			if err != nil {
				logger.Error("failed to encode worker uptime", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to encode worker uptime", http.StatusInternalServerError)
				return
			}
			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
			http.Error(w, "invalid method", http.StatusMethodNotAllowed)
		}
	})
}

func (s *APIServer) handleWorkerLoadavg() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			resp, err := s.MetricsClient.GetWorkerLoadavg(r.Context(), &met.WorkerRequest{Id: GetWorkerID(r.Context())})
			if err != nil {
				logger.Error("failed to get worker load averages", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to get worker load averages", http.StatusInternalServerError)
				return
			}
			data, err := proto.Marshal(resp.LoadAvg)
			if err != nil {
				logger.Error("failed to encode worker load averages", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
				http.Error(w, "failed to encode worker load averages", http.StatusInternalServerError)
				return
			}
			w.Write(data)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
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
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
		}
	})
}

func (s *APIServer) handleShutdown() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodPost:
			logger.Info("api shutdown request, shutting down...", zap.String("request_id", GetRequestID(r.Context())))
			syscall.Kill(syscall.Getegid(), syscall.SIGTERM)
		default:
			logger.Warn("invalid method", zap.String("method", r.Method), zap.String("request_id", GetRequestID(r.Context())))
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
