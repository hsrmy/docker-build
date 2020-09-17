FROM alpine:latest
LABEL maintainer="hsrmy <hsrmy@emradc.xyz>"

ENV VERSION=1.8.0

RUN echo "Number of CPU cores used during compilation: $(($(nproc)/2))" && \
    apk update && \
    apk add wget make gcc g++ autoconf automake libtool boost-dev log4cplus-dev mysql-dev postgresql-dev && \
    cd /tmp && \
    wget https://downloads.isc.org/isc/kea/${VERSION}/kea-${VERSION}.tar.gz && \
    tar -xvf kea-${VERSION}.tar.gz && \
    cd kea-${VERSION} && \
    autoreconf --install && \
    ./configure --prefix=/usr --with-mysql --with-pgsql && \
    make -j$(($(nproc)/2)) && \
    make install && \
    rm -rf /tmp/* && \
    apk del autoconf automake && \
    rm -rf /var/cache/apk/*

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENV TZ Asia/Tokyo
EXPOSE 547/udp
ENTRYPOINT ["/entrypoint.sh"]