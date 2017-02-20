FROM debian:jessie
MAINTAINER Benoît Vidis <contact@benoitvidis.com>

RUN  apt-get update \
  && apt-get install -y \
      build-essential \
      curl \
      sudo \
      wget \
  && curl -o build.sh -SL https://gist.githubusercontent.com/Brainiarc7/3f7695ac2a0905b05c5b/raw/dedfb86452070f80391468510639d6f2455b8e49/compile-ffmpeg-nvenc.sh \
  && sh ./build.sh
