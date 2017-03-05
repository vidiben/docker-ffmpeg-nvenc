FROM ubuntu:xenial
MAINTAINER Benoît Vidis <contact@benoitvidis.com>

WORKDIR /root
RUN  echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" > /etc/apt/sources.list.d/multiverse.list \
  && echo "deb-src http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list.d/multiverse.list \
  && apt-get update \
  && apt-get install -y \
      ant \
      autoconf \
      automake \
      build-essential \
      bzip2 \
      cmake \
      curl \
      libfdk-aac-dev \
      libfreetype6-dev \
      libsass-dev \
      libtheora-dev \
      libtool \
      libvorbis-dev \
      libxml2-dev \
      mercurial \
      p7zip \
      pkg-config \
      texinfo \
      zlib1g-dev \
      yasm \
  && mkdir -p "$HOME/bin" "$HOME/ffmpeg_build" "$HOME/ffmpeg_sources"

RUN  curl -SL -o fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master \
  && tar xzvf fdk-aac.tar.gz \
  && cd mstorsjo-fdk-aac* \
  && autoreconf -fiv \
  && ./configure --prefix="$HOME/ffmpeg_build" --disable-shared \
  && make \
  && make install \
  && cd /root \
  && rm -rf mstorsjo*

RUN  apt-get source libmp3lame0 \
  && cd lame* \
  && ./configure --prefix="$HOME/ffmpeg_build" --enable-nasm --disable-shared \
  && make \
  && make install \
  && cd /root \
  && rm -rf lame*

RUN  curl -SLO http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2 \
  && tar xjvf last_x264.tar.bz2 \
  && cd x264-snapshot* \
  && PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static --disable-opencl \
  && PATH="$HOME/bin:$PATH" make \
  && make install \
  && cd /root \
  && rm -rf x264*

RUN  hg clone https://bitbucket.org/multicoreware/x265 \
  && cd x265/build/linux \
  && PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source \
  && make \
  && make install \
  && cd /root \
  && rm -rf x265

RUN  curl -SLO http://downloads.xiph.org/releases/opus/opus-1.1.4.tar.gz \
  && tar xzvf opus-1.1.4.tar.gz \
  && cd opus-1.1.4 \
  && ./configure --prefix="$HOME/ffmpeg_build" --disable-shared \
  && make \
  && make install \
  && cd /root \
  && rm -rf opus*

RUN  curl -SLO http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.6.1.tar.bz2 \
  && tar xjvf libvpx-1.6.1.tar.bz2 \
  && cd libvpx-1.6.1 \
  && PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests \
  && PATH="$HOME/bin:$PATH" make \
  && make install \
  && cd /root \
  && rm -rf libvpx*

RUN  curl -SLO http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 \
  && tar xvf ffmpeg-snapshot.tar.bz2 

COPY build.sh /root/
CMD ["/root/build.sh"]

