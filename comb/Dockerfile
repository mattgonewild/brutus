# build
FROM golang:1.21.5-bookworm as builder
WORKDIR /app
RUN apt-get update -y; apt-get install -y xz-utils
ADD https://github.com/upx/upx/releases/download/v4.2.1/upx-4.2.1-amd64_linux.tar.xz ./upx-4.2.1-amd64_linux.tar.xz
RUN tar xf ./upx-4.2.1-amd64_linux.tar.xz; mv ./upx-4.2.1-amd64_linux/upx /usr/bin
RUN chmod +x /usr/bin/upx

COPY . ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -mod=readonly -v -o orchestration-service
RUN upx --best --lzma combination-service

# out
FROM gcr.io/distroless/static-debian11
COPY --from=builder /app/orchestration-service /orchestration-service
EXPOSE 54934
ENTRYPOINT ["/combination-service"]