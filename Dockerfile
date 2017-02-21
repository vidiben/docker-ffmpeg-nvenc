FROM ubuntu:xenial
MAINTAINER Benoît Vidis <contact@benoitvidis.com>

WORKDIR /root
RUN  echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" > /etc/apt/sources.list.d/multiverse.list \
  && echo "deb-src http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list.d/multiverse.list \
  && apt-get update \
  && apt-get install -y \
      ant \
      autoconf \
      cmake \
      curl \
      libfdk-aac-dev \
      libxml2-dev \
      p7zip-full \
  && apt-get build-dep -y \
      ffmpeg \
  && apt-get source \
      ffmpeg 

RUN  apt-get source libbluray \
  && cd libbluray* \
  && ./configure --disable-shared \
  && make \
  && make install \
  && cd /root \
  && rm -rf libbluray*

RUN  apt-get source libfdk-aac0 \
  && cd fdk-aac* \
  && ./configure --disable-shared \
  && make \
  && make install \
  && cd /root \
  && rm -rf fdk*

RUN  apt-get source libmp3lame0 \
  && cd lame* \
  && ./configure --enable-nasm --disable-shared \
  && make \
  && make install \
  && cd /root \
  && rm -rf lame*

RUN  apt-get source libx264-148 \
  && cd x264* \
  && ./configure --enable-static \
  && make \
  && make install \
  && cd /root \
  éé rm -rf x264*

RUN  apt-get source libx265-79 \
  && cd x265*/build/linux \
  && cmake -G "Unix Makefiles" -DENABLE_SHARED:bool=off ../../source \
  && make \
  && make install \
  && cd /root \
  && rm -rf x265*

RUN  curl -SLO http://downloads.xiph.org/releases/opus/opus-1.1.4.tar.gz \
  && tar xzvf opus-1.1.4.tar.gz \
  && cd opus-1.1.4 \
  && ./configure --disable-shared \
  && make \
  && make install \
  && cd /root \
  && rm -rf opus*

COPY build.sh /root/
CMD ["/root/build.sh"]

