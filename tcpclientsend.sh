#!/bin/sh

gst-launch -tv  videotestsrc ! cairotimeoverlay ! queue ! videoscale method=1 ! video/x-raw-yuv,width=352,height=288 ! ffmpegcolorspace ! queue ! theoraenc ! oggmux ! tcpclientsink host=192.168.29.65 port=1234 sync=false async=false

# gst-launch -tv  videotestsrc ! queue ! videoscale method=1 ! video/x-raw-yuv,width=352,height=288 ! ffmpegcolorspace ! queue ! x264enc ! ffmux_mp4 ! tcpclientsink host=192.168.29.65 port=1234 sync=false async=false

