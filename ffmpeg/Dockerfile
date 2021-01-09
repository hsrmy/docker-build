# build用コンテナ
FROM alpine:latest AS build

## FFMPEGのバージョン
ARG VERSION=4.3.1
## 開発用パッケージ
ARG DEVELOP_PKG="curl make gcc g++ musl-dev cmake pkgconfig zlib-dev"
## ライブラリをビルドする際に必要なパッケージ
ARG DEPENDENCEY_PKG="libsndfile-dev mpg123-dev pulseaudio-dev portaudio-dev"
## コンパイルに必要なパッケージ
ARG BUILD_PKG="nasm chromaprint-dev frei0r-plugins-dev gnutls-dev aom-dev libass-dev libbluray-dev libcaca-dev libdc1394-dev \
    libdrm-dev flite-dev gsm-dev lame-dev openjpeg-dev opus-dev librsvg-dev soxr-dev speex-dev libssh-dev libtheora-dev \
    libvpx-dev wavpack-dev libwebp-dev x264-dev x265-dev xvidcore-dev zeromq-dev libxml2-dev openal-soft-dev jack-dev \
    libcdio-dev libcdio-paranoia-dev libva-dev libva-intel-driver libvdpau-dev mesa-va-gallium mesa-vdpau-gallium"
## コンパイルに必要なパッケージ (alpine linuxのedgeブランチのcommunityリポジトリにしかないもの)
ARG BUILD_EDGE_COMMUNITY_PKG="ladspa-dev vidstab-dev intel-media-driver-dev"
## コンパイルに必要なパッケージ (alpine linuxのedgeブランチのtestingリポジトリにしかないもの)
ARG BUILD_EDGE_TESTING_PKG="lilv-dev libgme-dev libmysofa-dev rubberband-dev shine snappy-dev libva-vdpau-driver"

## 必要なパッケージのインストール
RUN apk --update --no-cache add ${DEVELOP_PKG} ${DEPENDENCEY_PKG} ${BUILD_PKG} && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community ${BUILD_EDGE_COMMUNITY_PKG} && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing ${BUILD_EDGE_TESTING_PKG}

## alpine linuxのパッケージがないライブラリのコンパイル
### for --enable-avisynth
WORKDIR /tmp/AviSynthPlus
RUN curl -fsSL https://github.com/AviSynth/AviSynthPlus/archive/v3.6.1.tar.gz | tar -xvz --strip-components=1 && \
    mkdir avisynth-build && cd avisynth-build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../ -DHEADERS_ONLY:bool=on && \
    make install
### for --enable-libbs2b
WORKDIR /tmp/bs2b
RUN curl -fsSL https://downloads.sourceforge.net/project/bs2b/libbs2b/3.1.0/libbs2b-3.1.0.tar.gz | tar -xvz --strip-components=1 && \
    cd ./build-aux && \
    curl -fsSL 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' -o config.guess && \
    curl -fsSL 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD' -o config.sub && \
    cd ../ && \
    ./configure --prefix=/usr/local --disable-static --enable-shared && \
    make -j $(nproc) && \
    make install
### for --enable-libcodec2
WORKDIR /tmp/codec2
RUN curl -fsSL https://github.com/drowe67/codec2/archive/v0.9.2.tar.gz | tar -xvz --strip-components=1 && \
    mkdir codec2-build && cd codec2-build && \
    cmake -DCMAKE_BUILD_TYPE=Release ../ && \
    make install
### for --enable-libopenmpt
WORKDIR /tmp/libopenmpt
RUN curl -fsSL https://lib.openmpt.org/files/libopenmpt/src/libopenmpt-0.5.0+release.autotools.tar.gz | tar -xvz --strip-components=1 && \
    ./configure --prefix=/usr/local --disable-static --enable-shared && \
    make -j $(nproc) && \
    make install
### for --enable-libtwolame
WORKDIR /tmp/twolame
RUN curl -fsSL https://downloads.sourceforge.net/twolame/twolame-0.4.0.tar.gz | tar -xz --strip-components=1 && \
    ./configure --prefix=/usr/local --disable-static --enable-shared && \
    make -j $(nproc) && \
    make install

## ffmpegのコンパイル
WORKDIR /tmp/ffmpeg
RUN curl -fsSL https://ffmpeg.org/releases/ffmpeg-${VERSION}.tar.gz | tar -xvz --strip-components=1 && \
    curl -fsSL https://github.com/GPUOpen-LibrariesAndSDKs/AMF/archive/v1.4.18.tar.gz | tar -xvz --strip-components=1 && \
    mkdir -p /usr/local/include/AMF && \
    cp -r amf/public/include/* /usr/local/include/AMF && \
    ./configure --enable-gpl --disable-stripping --disable-doc --disable-filter=resample --enable-avisynth --enable-gnutls \
    --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio \
    --enable-libcodec2 --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libgme \
    --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt \
    --enable-libopus --enable-libpulse --enable-librsvg --enable-librubberband --enable-libshine --enable-libsnappy \
    --enable-libsoxr --enable-libspeex --enable-libssh --enable-libtheora --enable-libtwolame --enable-libvidstab \
    --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid \
    --enable-libzmq --enable-lv2 --enable-openal --enable-sdl2 --enable-libdc1394 --enable-libdrm --enable-vaapi \
    --enable-vdpau --enable-chromaprint \--enable-frei0r --enable-libx264 --enable-shared --enable-nonfree --enable-small \
    --enable-version3 --disable-rpath --disable-static && \
    make -j $(nproc) && \
    make -j $(nproc) install && \
    make distclean

## 不要なものの削除
WORKDIR /tmp
RUN rm -rf /tmp/* && \
    apk --purge del ${DEVELOP_PKG} ${DEPENDENCEY_PKG} ${BUILD_PKG} ${BUILD_EDGE_COMMUNITY_PKG} ${BUILD_EDGE_TESTING_PKG}

# 実際のコンテナ
FROM alpine:latest

RUN apk --update --no-cache add ffmpeg-libs

COPY --from=build /usr/local/bin/ffmpeg /usr/local/bin/ffmpeg
COPY --from=build /usr/local/bin/ffplay /usr/local/bin/ffplay
COPY --from=build /usr/local/bin/ffprobe /usr/local/bin/ffprobe