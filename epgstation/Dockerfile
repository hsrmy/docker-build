FROM l3tnun/epgstation:master-debian

ARG DOCKERIZE_VERSION="v0.6.1"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl tzdata && \
    curl -fsSL https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz | \
    tar -xvz -C /usr/local/bin && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apt-get -y --purge autoremove curl tzdata && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

EXPOSE 8888
WORKDIR /app