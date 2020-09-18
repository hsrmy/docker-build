# ビルド用
FROM golang:1.15-alpine AS build

RUN apk --update --no-cache add git && \
    go get github.com/yyoshiki41/radigo/cmd/radigo

# 実際動かす用
FROM alpine:latest
ENV TZ "Asia/Tokyo"

RUN apk --update --no-cache add ffmpeg rtmpdump tzdata
COPY --from=build /go/bin/radigo /usr/bin/radigo
COPY ./program.json /usr/local/share/ 
# TODO: program.jsonの中身を解析してcront設定項目を吐き出すものを書く
# COPY ./something_command /usr/local/something_command

RUN mkdir -p /var/spool/cron/crontabs && \
    # something_command > /var/spool/cron/crontabs/root
    echo "* * * * * echo 'hello world'" > /var/spool/cron/crontabs/root 