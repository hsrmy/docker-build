# build用コンテナ
FROM alpine:latest AS build
## kea dhcp serverのバージョン
ARG VERSION=1.8.0
## buildに必要なパッケージ
ARG BUILD_PKGS="curl make gcc g++ autoconf automake libtool boost-dev log4cplus-dev mysql-dev postgresql-dev openssl"

WORKDIR /tmp/kea
RUN apk --update --no-cache add ${BUILD_PKGS} && \
    curl -fsSL https://downloads.isc.org/isc/kea/${VERSION}/kea-${VERSION}.tar.gz | tar -xz --strip-components=1 && \
    autoreconf --install && \
    ./configure --prefix=/usr/local --sysconfdir=/etc --with-mysql --with-pgsql --disable-rpath --enable-static && \
    make -j$(nproc) install

# 実際に動かすコンテナ
FROM alpine:latest
LABEL maintainer="hsrmy <hsrmy@emradc.xyz>"
## 動かすのに必要なパッケージ
ARG PKGS="curl libstdc++ libgcc log4cplus mariadb-connector-c libpq openssl tzdata"
## 実行ファイル・設定ファイルに共通な部分
ARG BIN_NAME="kea-dhcp4"
## Dockerizeのバージョン
ARG DOCKERIZE_VERSION="v0.6.1"

RUN apk --update --no-cache add ${PKGS} && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    curl -fsSL https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-alpine-linux-amd64-${DOCKERIZE_VERSION}.tar.gz | \
    tar -xz -C /usr/local/bin && \
    apk del tzdata curl
## 必要なファイルだけbuild用コンテナからコピー
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/sbin/${BIN_NAME} /usr/local/sbin/
COPY --from=build /usr/local/var /usr/local/var
COPY --from=build /etc/kea/${BIN_NAME}.conf /etc/kea/
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 67/udp