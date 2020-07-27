FROM alpine:latest
LABEL maintainer="hsrmy <hsrmy@emradc.xyz>"

ENV VERSION=1.6.2

RUN apk update && \
    apk add wget make gcc g++ autoconf automake libtool boost-dev log4cplus-dev mysql-dev postgresql-dev && \
    cd /tmp && \
    wget https://downloads.isc.org/isc/kea/1.6.2/kea-1.6.2.tar.gz && \
    tar -xvf ${VERSION}.tar.gz && \
    cd kea-${VERSION} && \
    autoreconf --install && \
    ./configure --prefix=/usr --with-mysql --with-pgsql && \
    make -j 8 && \
    make install && \
    rm -rf /tmp/* && \
    apk del autoconf automake && \
    rm -rf /var/cache/apk/*

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 67/udp
ENTRYPOINT ["/entrypoint.sh"]
