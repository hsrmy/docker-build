FROM golang:1.16.5-alpine

ENV TZ "Asia/Tokyo"

RUN apk --update --no-cache add git && \
    cd /go/src && \
    git clone https://github.com/hsrmy/mirakurun-exporter && \
    cd mirakurun-exporter && \
    go install

EXPOSE 9100