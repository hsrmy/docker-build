# build用コンテナ
FROM alpine:latest AS build
## kea dhcp serverのバージョン
ARG VERSION=1.8.0
## buildに必要なパッケージ
ARG BUILD_PKGS="curl make gcc g++ autoconf automake libtool boost-dev log4cplus-dev mysql-dev postgresql-dev"

WORKDIR /tmp/kea
RUN apk --update --no-cache add ${BUILD_PKGS} && \
    curl -fsSL https://downloads.isc.org/isc/kea/${VERSION}/kea-${VERSION}.tar.gz | tar -xz --strip-components=1 && \
    autoreconf --install && \
    ./configure --prefix=/usr/local --sysconfdir=/etc --with-mysql --with-pgsql --disable-rpath --disable-static && \
    make -j$(nproc) && \
    make install DESTDIR=/tmp/build && \
    strip -p /tmp/build/usr/local/sbin/kea-dhcp* /tmp/build/usr/local/sbin/kea-lfc* /tmp/build/usr/local/lib/libkea-*.so.* && \
    ldconfig / && \
    rm -rf /tmp/build/var/run /tmp/build/usr/local/share/man/* /tmp/build/usr/local/include /tmp/build/usr/include \
    /tmp/build/usr/share/kea /tmp/build/usr/share/doc/kea /tmp/build/usr/local/lib/kea/hooks/*.la \
    /tmp/build/usr/local/lib/*.la /tmp/build/usr/local/include/* /tmp/build/usr/local/share/doc/kea \
    /tmp/build/usr/local/share/kea

# 実際に動かすコンテナ
FROM alpine:latest
LABEL maintainer="hsrmy <hsrmy@emradc.xyz>"
## 動かすのに必要なパッケージ
ARG PKGS="libstdc++ libgcc log4cplus mariadb-connector-c libpq tzdata"
## 実行ファイル・設定ファイルに共通な部分
ARG BIN_NAME="kea-dhcp6"

RUN apk --update --no-cache add ${PKGS} && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata
## 必要なファイルだけbuild用コンテナからコピー
COPY --from=build /tmp/build/usr/local/lib /usr/local/lib
COPY --from=build /tmp/build/usr/local/sbin/${BIN_NAME} /usr/local/sbin/
COPY --from=build /tmp/build/usr/local/var /usr/local/var
COPY --from=build /tmp/build/etc/kea/${BIN_NAME}.conf /etc/kea/
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 547/udp
ENTRYPOINT ["/entrypoint.sh"]