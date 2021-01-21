FROM ubuntu:focal as build

ARG PKGS="pbuilder debootstrap devscripts curl lsb-release"

RUN sed -i -e 's/# deb-src/deb-src/g' /etc/apt/sources.list && \
    apt-get update && apt-get -y --no-install-recommends install ${PKGS} && \
    pbuilder create --distribution $(lsb_release -c -s) && \
    apt-get source ffmpeg && \
    pbuilder build *.dsc