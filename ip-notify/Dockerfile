FROM golang:1.19.0-alpine

RUN apk --update --no-cache add git && \
    cd /go/src && \
    git clone https://github.com/hsrmy/ip-notify && \
    cd ip-notify && \
    go install && \
    mkdir -p /var/spool/cron/crontabs && \
    echo "30 */2 * * * /go/bin/ip-notify" >> /var/spool/cron/crontabs/root