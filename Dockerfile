FROM ubuntu:xenial
MAINTAINER Benoît Vidis <contact@benoitvidis.com>

WORKDIR /root
COPY build.sh /root/
RUN  echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" > /etc/apt/sources.list.d/multiverse.list \
  && apt-get update \
  && apt-get install -y \
      libfdk-aac-dev \
      p7zip-full \
  && apt-get build-dep -y \
      ffmpeg \
  && apt-get source ffmpeg

CMD ["/root/build.sh"]

