FROM l3tnun/epgstation:master-alpine

ARG DOCKERIZE_VERSION="v0.6.1"
ARG FFMPEG_VERSION="4.3.1"

RUN apk --update --no-cache add curl openssl tzdata && \
    curl -fsSL https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz | \
    tar -xvz -C /usr/local/bin && \
    curl -fsSL https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz | \
    tar -xJ -C /usr/local/bin --strip-components=1 ffmpeg-${FFMPEG_VERSION}-amd64-static/ffmpeg ffmpeg-${FFMPEG_VERSION}-amd64-static/ffprobe && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del curl tzdata

EXPOSE 8888
WORKDIR /app