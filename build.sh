#!/bin/bash

set -ex

cd /root
7z x "$SDK_PATH"
cp *SDK*/Samples/common/inc/*.h /usr/local/include/

cd /root/ffmpeg

./configure \
  --prefix=/usr \
  --pkg-config-flags="--static" \
  --build-suffix=-ffmpeg \
  --toolchain=hardened \
  --enable-gpl \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-vaapi \
  --enable-libbluray \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-nonfree \
  --enable-nvenc
  
make
make install

for i in {0..5}; do echo; done
echo "Build done"
echo "You can now get ffmpeg binary from /usr/bin/ffmpeg"
echo
echo "ex: docker cp <container id>:/usr/bin/ffmpeg ~/bin/ffmpeg"
echo


exec tail -f /dev/null

