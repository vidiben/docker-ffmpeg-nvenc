#!/bin/bash

cd /root
7z x "$SDK_PATH"
cp *SDK*/Samples/common/inc/*.h /usr/local/include/

cd /root/ffmpeg-2.8.11

./configure \
  --prefix=/usr \
  --pkg-config-flags="--static" \
  --extra-version=0ubuntu0.16.04.1 \
  --build-suffix=-ffmpeg \
  --toolchain=hardened \
  --libdir=/usr/lib/x86_64-linux-gnu \
  --incdir=/usr/include/x86_64-linux-gnu \
  --cc=cc \
  --cxx=g++ \
  --enable-gpl \
  --disable-shared \
  --disable-stripping \
  --disable-decoder=libopenjpeg \
  --disable-decoder=libschroedinger \
  --enable-avresample \
  --enable-avisynth \
  --enable-gnutls \
  --enable-ladspa \
  --enable-libass \
  --enable-libbluray \
  --enable-libbs2b \
  --enable-libcaca \
  --enable-libcdio \
  --enable-libflite \
  --enable-libfontconfig \
  --enable-libfreetype \
  --enable-libfribidi \
  --enable-libgme \
  --enable-libgsm \
  --enable-libmodplug \
  --enable-libmp3lame \
  --enable-libopenjpeg \
  --enable-libopus \
  --enable-libpulse \
  --enable-librtmp \
  --enable-libschroedinger \
  --enable-libshine \
  --enable-libsnappy \
  --enable-libsoxr \
  --enable-libspeex \
  --enable-libssh \
  --enable-libtheora \
  --enable-libtwolame \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libwavpack \
  --enable-libwebp \
  --enable-libx265 \
  --enable-libxvid \
  --enable-libzvbi \
  --enable-openal \
  --enable-opengl \
  --enable-x11grab \
  --enable-libdc1394 \
  --enable-libiec61883 \
  --enable-libzmq \
  --enable-frei0r \
  --enable-libx264 \
  --enable-libopencv \
  --enable-nonfree \
  --enable-nvenc
  
make
make install

exec tail -f /dev/null

