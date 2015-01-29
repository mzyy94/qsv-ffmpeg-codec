qsv-ffmpeg-codec
================

Quick sync video as a encode codec in ffmpeg.

## Requirements
   * Intel Media Server Studio 2015 R3 (https://software.intel.com/en-us/intel-media-server-studio)
   * CentOS 7.0 x64

## Build
   0. fix library link path: sudo bash -c 'echo "/opt/intel/mediasdk/lib64" >> /etc/ld.so.conf.d/intel-mediasdk.conf; ldconfig'
   1. git submodule init && git submodule update
   2. patch -p1 -d FFmpeg-2.2 < ffmpeg-2.2.12.patch
   3. cp ./src/* ./FFmpeg-2.2/libavcodec/
   4. cd FFmpeg-2.2
   5. ./configure --extra-libs="-lsupc++ -lstdc++ -ldl -lva -lva-drm" --extra-ldflags="-L/opt/intel/mediasdk/lib64" --extra-cflags="-I/opt/intel/mediasdk/include" --prefix="/opt/intel/mediasdk"
   6. make

## Support
   * Intel Media SDK API : v1.13
   * Codec : H.264

## Codec name
   * H.264 : `h264_qsv`

## Example
   * ffmpeg -i in.mp4 -an -vcodec h264_qsv -b 2000k -f mp4 -y out.mp4
