FROM l3tnun/epgstation:master-alpine

ARG DOCKERIZE_VERSION="v0.6.1"

RUN apk --update --no-cache add wget openssl tzdata && \
    wget https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz && \
    rm dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY --from=hsrmy/ffmpeg /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=hsrmy/ffmpeg /usr/local/bin/ffplay /usr/local/bin/ffplay
COPY --from=hsrmy/ffmpeg /usr/local/bin/ffprobe /usr/local/bin/ffprobe

EXPOSE 8888
WORKDIR /app