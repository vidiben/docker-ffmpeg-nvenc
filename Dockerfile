FROM ubuntu:xenial
MAINTAINER Benoît Vidis <contact@benoitvidis.com>

WORKDIR /root
COPY build.sh /root/
RUN  echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" > /etc/apt/sources.list.d/multiverse.list \
  && apt-get update \
  && apt-get install -y \
      ant \
      autoconf \
      cmake \
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

RUN apt-get source apt-get source libx265-79 \
  && cd x265*/build/linux \
  && cmake -G "Unix Makefiles" -DENABLE_SHARED:bool=off ../../source \
  && make \
  && make install \
  && cd /root \
  && rm -rf x265*

CMD ["/root/build.sh"]

