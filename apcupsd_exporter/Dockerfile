FROM golang:1.23-bookworm as builder
RUN git clone https://github.com/mdlayher/apcupsd_exporter.git && \
    cd apcupsd_exporter && \
    go get -t -u && \
    go build -o /go/bin/apcupsd_exporter cmd/apcupsd_exporter/main.go

FROM debian:bookworm-slim
LABEL org.opencontainers.image.source https://github.com/hsrmy/docker-build
LABEL org.opencontainers.image.description="Provides a Prometheus exporter for the apcupsd Network Information Server (NIS)."
LABEL org.opencontainers.image.licenses=MIT
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
COPY --from=builder /go/bin/apcupsd_exporter /usr/local/bin
EXPOSE 9162
ENTRYPOINT [ "/usr/local/bin/apcupsd_exporter" ]