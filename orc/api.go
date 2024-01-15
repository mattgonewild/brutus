// TODO: go through all this again
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
	brutus "github.com/mattgonewild/brutus/proto/go"
)

type APIServer struct {
	BudgetManager *BudgetManager
	Services      map[ServiceType]*Service
	MetricsClient met.MetClient
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

func requestIDMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		requestID := uuid.New().String()
		ctx := WithRequestID(r.Context(), requestID)
		r = r.WithContext(ctx)
		next.ServeHTTP(w, r)
	})
}

func workerIDMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		pathSegments := strings.Split(r.URL.Path, "/")
		if len(pathSegments) >= 3 && pathSegments[1] == "workers" {
			workerID := pathSegments[2]
			ctx := WithWorkerID(r.Context(), workerID)
			r = r.WithContext(ctx)
		}
		next.ServeHTTP(w, r)
	})
}

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()
		next.ServeHTTP(w, r)
		logger.Info("api request", zap.String("method", r.Method), zap.String("path", r.URL.Path),
			zap.String("remote_addr", r.RemoteAddr), zap.String("user_agent", r.UserAgent()),
			zap.Duration("duration", time.Since(start)), zap.String("request_id", GetRequestID(r.Context())))
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
			balance := &brutus.Budget{Timestamp: timestamppb.Now(), Balance: s.BudgetManager.LoadBalance()}

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
				return
			}

			budget := new(brutus.Budget)
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

func (s *APIServer) handleElements() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// TODO:
	})
}

func (s *APIServer) handleTarget() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// TODO:
	})
}

func (s *APIServer) handleMachine() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// TODO:
	})
}

func (s *APIServer) handleWorkers() http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		switch r.Method {
		case http.MethodGet:
			workers := []*brutus.Worker{}

			for _, service := range s.Services {
				service.WorkerManager.Mutex.Lock()
				for _, worker := range service.WorkerManager.ActiveWorkers {
					resp, err := s.MetricsClient.GetWorker(r.Context(), &brutus.WorkerRequest{Id: worker.uuid})
					if err != nil {
						logger.Error("failed to get worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", worker.uuid))
						continue
					}
					workers = append(workers, resp.Worker)
				}
				service.WorkerManager.Mutex.Unlock()
			}

			data, err := proto.Marshal(&brutus.WorkersResponse{Workers: workers}) // TODO: ...
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
			body, err := io.ReadAll(r.Body)
			if err != nil {
				logger.Error("failed to read request body", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
				http.Error(w, "failed to read request body", http.StatusInternalServerError)
				return
			}

			worker := new(brutus.Worker)
			if err := proto.Unmarshal(body, worker); err != nil {
				logger.Error("failed to decode worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
				http.Error(w, "failed to decode worker", http.StatusBadRequest)
				return
			}

			switch worker.Type {
			case string(Combination):
				err := s.Services[Combination].WorkerManager.AddWorker(Combination, s.Services[Combination].InChan, s.Services[Combination].OutChan)
				if err != nil {
					logger.Error("failed to add worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
					http.Error(w, "failed to add worker", http.StatusInternalServerError)
					return
				}
				w.WriteHeader(http.StatusCreated)
			case string(Permutation):
				err := s.Services[Permutation].WorkerManager.AddWorker(Permutation, s.Services[Permutation].InChan, s.Services[Permutation].OutChan)
				if err != nil {
					logger.Error("failed to add worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
					http.Error(w, "failed to add worker", http.StatusInternalServerError)
					return
				}
				w.WriteHeader(http.StatusCreated)
			case string(Decryption):
				err := s.Services[Decryption].WorkerManager.AddWorker(Decryption, s.Services[Decryption].InChan, s.Services[Decryption].OutChan)
				if err != nil {
					logger.Error("failed to add worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())))
					http.Error(w, "failed to add worker", http.StatusInternalServerError)
					return
				}
				w.WriteHeader(http.StatusCreated)
			default:
				logger.Warn("invalid worker type", zap.String("type", worker.Type), zap.String("request_id", GetRequestID(r.Context())))
				http.Error(w, "invalid worker type", http.StatusBadRequest)
				return
			}
		case http.MethodDelete:
			for _, service := range s.Services {
				service.WorkerManager.Mutex.Lock()
				for _, worker := range service.WorkerManager.ActiveWorkers {
					if worker.uuid == GetWorkerID(r.Context()) {
						err := service.WorkerManager.StopWorker(worker.uuid)
						if err != nil {
							service.WorkerManager.Mutex.Unlock()
							logger.Error("failed to stop worker", zap.Error(err), zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
							http.Error(w, "failed to stop worker", http.StatusInternalServerError)
							return
						}
						service.WorkerManager.Mutex.Unlock()

						logger.Info("worker stopped", zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
						w.WriteHeader(http.StatusNoContent)
						return
					}
				}
				service.WorkerManager.Mutex.Unlock()
			}

			logger.Warn("worker not found", zap.String("request_id", GetRequestID(r.Context())), zap.String("worker_id", GetWorkerID(r.Context())))
			http.Error(w, "worker not found", http.StatusNotFound)
			return
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
			resp, err := s.MetricsClient.GetWorkerProc(r.Context(), &brutus.WorkerRequest{Id: GetWorkerID(r.Context())})
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
			resp, err := s.MetricsClient.GetWorkerCpu(r.Context(), &brutus.WorkerRequest{Id: GetWorkerID(r.Context())})
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
			resp, err := s.MetricsClient.GetWorkerMem(r.Context(), &brutus.WorkerRequest{Id: GetWorkerID(r.Context())})
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
			resp, err := s.MetricsClient.GetWorkerNet(r.Context(), &brutus.WorkerRequest{Id: GetWorkerID(r.Context())})
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
			resp, err := s.MetricsClient.GetWorkerUptime(r.Context(), &brutus.WorkerRequest{Id: GetWorkerID(r.Context())})
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
			resp, err := s.MetricsClient.GetWorkerLoadAvg(r.Context(), &brutus.WorkerRequest{Id: GetWorkerID(r.Context())})
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

func ListenAndServeAPI(shutdownCtx context.Context, config *Config, api *APIServer) {
	mux := http.NewServeMux()
	srv := &http.Server{
		Addr:    config.ListenAndServeAPIAddr,
		Handler: loggingMiddleware(mux),
	}

	// register handlers
	mux.Handle("/", requestIDMiddleware(loggingMiddleware(api.handle())))
	mux.Handle("/budget", requestIDMiddleware(loggingMiddleware(api.handleBudget())))
	mux.Handle("/elements", requestIDMiddleware(loggingMiddleware(api.handleElements())))
	mux.Handle("/target", requestIDMiddleware(loggingMiddleware(api.handleTarget())))
	mux.Handle("/machine", requestIDMiddleware(loggingMiddleware(api.handleMachine())))
	mux.Handle("/workers", requestIDMiddleware(loggingMiddleware(api.handleWorkers())))
	mux.Handle("/workers/{id}", requestIDMiddleware(workerIDMiddleware(loggingMiddleware(api.handleWorker()))))
	mux.Handle("/workers/{id}/proc", requestIDMiddleware(workerIDMiddleware(loggingMiddleware(api.handleWorkerProc()))))
	mux.Handle("/workers/{id}/proc/cpu", requestIDMiddleware(workerIDMiddleware(loggingMiddleware(api.handleWorkerCpu()))))
	mux.Handle("/workers/{id}/proc/mem", requestIDMiddleware(workerIDMiddleware(loggingMiddleware(api.handleWorkerMem()))))
	mux.Handle("/workers/{id}/proc/net", requestIDMiddleware(workerIDMiddleware(loggingMiddleware(api.handleWorkerNet()))))
	mux.Handle("/workers/{id}/proc/uptime", requestIDMiddleware(workerIDMiddleware(loggingMiddleware(api.handleWorkerUptime()))))
	mux.Handle("/workers/{id}/proc/loadavg", requestIDMiddleware(workerIDMiddleware(loggingMiddleware(api.handleWorkerLoadavg()))))
	mux.Handle("/log", requestIDMiddleware(loggingMiddleware(api.handleLog())))
	mux.Handle("/shutdown", requestIDMiddleware(loggingMiddleware(api.handleShutdown())))

	// start server in a goroutine so that it doesn't block
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
}
