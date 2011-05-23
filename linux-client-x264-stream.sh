#!/bin/sh

CLIENT="192.168.29.150"

gst-launch -tv autovideosrc ! ffmpegcolorspace ! videoscale method=1 ! videorate ! "video/x-raw-yuv,width=(int)480, height=(int)360,framerate=(fraction)10/1" ! x264enc byte-stream=true bitrate=512 ! decodebin latency=0 ! ffmpegcolorspace ! xvimagesink sync=false

exit

# Marche pas bien avec autovideosink mais ok avec xvimagesink...
gst-launch -tv autovideosrc ! ffmpegcolorspace ! videoscale method=1 ! videorate ! "video/x-raw-yuv,width=(int)480, height=(int)360,framerate=(fraction)10/1" ! x264enc byte-stream=true bitrate=512 ! decodebin latency=0 ! ffmpegcolorspace ! autovideosink

