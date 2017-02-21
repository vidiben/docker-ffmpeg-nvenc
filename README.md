# docker-ffmpeg-nvenc

Static build of ffmpeg with nvenc support.

NB: This container is dedicated to **build** ffmpeg and does not provide a ready-to-use binary.

## How to use

My understanding of Nvidia video codecs' license is that it does not allow to distribute them freely.

As such, they are not part of this repository and you will need to download them from [Nvidia website](https://developer.nvidia.com/nvidia-video-codec-sdk).

Once downloaded, mount the zip file as a volume and set its location using `SDK_PATH` environment variable.

i.e.:

```
docker run -rm --name ffmpegnvenc -v `pwd`/Video_Codec_SDK_7.1.9.zip:/tmp/sdk.zip -e SDK_PATH=/tmp/sdk.zip -ti vidiben/ffmpeg-nvenc 
```

Once built, copy the ffmpeg binary

```
docker cp ffmpegnvenc:/usr/bin/ffmpeg ~/bin/ffmpeg
```


