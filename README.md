qsv_h264-ffmpeg
================

Quick sync video as a encode codec in ffmpeg.

## Requirements
   * Intel Media Server Studio 2015 R3 (https://software.intel.com/en-us/intel-media-server-studio)
   * CentOS 7.0 x64

## Build
   0. fix library link path:
        sudo bash -c '(ldconfig -p -N | grep intel.mediasdk) || echo "/opt/intel/mediasdk/lib64" >> /etc/ld.so.conf.d/intel-mediasdk.conf && ldconfig'
   1. ./setup.sh
   2. cd FFmpeg-2.2
   3. make

## Support
   * Intel Media SDK API : v1.13
   * Codec : H.264

## Codec name
   * H.264 : `h264_qsv`

## Example
   * ffmpeg -i in.m2ts -acodec copy -vcodec h264_qsv -b:v 2000k -f mp4 -y out.mp4
