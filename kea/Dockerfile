FROM alpine:latest
LABEL maintainer="hsrmy <hsrmy@emradc.xyz>"

ENV VERSION=Kea-1.7.9

RUN apk update && \
    apk add wget make gcc g++ autoconf automake libtool boost-dev log4cplus-dev mysql-dev postgresql-dev && \
    cd /tmp && \
    wget https://github.com/isc-projects/kea/archive/${VERSION}.tar.gz && \
    tar -xvf ${VERSION}.tar.gz && \
    cd kea-${VERSION} && \
    autoreconf --install && \
    ./configure --prefix=/usr --with-mysql --with-pgsql && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    apk del autoconf automake && \
    rm -rf /var/cache/apk/*

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 67/udp
ENTRYPOINT ["/entrypoint.sh"]    