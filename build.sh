#!/bin/bash

set -ex

NPROC="`grep -c ^processor /proc/cpuinfo`"

cd /root
7z x -y "$SDK_PATH"
cp *SDK*/Samples/common/inc/*.h /usr/local/include/

cd /root/ffmpeg

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include -static" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib -static" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-vaapi \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree \
  --enable-nvenc \
  --enable-static \
  --disable-ffplay \
  --disable-ffserver \
  --disable-shared
  
make -j$NPROC
make install

echo
echo
echo "Build done"
echo "You can now get ffmpeg binary from /root/ffmpeg/ffmpeg"
echo
echo "ex: docker cp <container id>:/root/ffmpeg/ffmpeg ~/bin/ffmpeg"
echo


exec tail -f /dev/null

