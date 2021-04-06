# ビルド用
FROM golang:1.15-alpine AS build

RUN apk --update --no-cache add git && \
    go get github.com/yyoshiki41/radigo/cmd/radigo

# 実際動かす用
FROM python:3.9.4-alpine
ENV TZ "Asia/Tokyo"

RUN apk --update --no-cache add ffmpeg rtmpdump tzdata coreutils
COPY --from=build /go/bin/radigo /usr/bin/radigo
COPY ./program.json /usr/local/share/ 
COPY ./cron_output.py /usr/local/bin

RUN mkdir -p /var/spool/cron/crontabs && \
    /usr/local/bin/python /usr/local/bin/cron_output.py > /var/spool/cron/crontabs/root