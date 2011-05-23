#!/bin/sh

# gst-launch -tv  videotestsrc ! cairotimeoverlay ! queue ! videoscale method=1 ! video/x-raw-yuv,width=352,height=288 ! ffmpegcolorspace ! theoraenc ! oggmux ! tcpserversink host=192.168.29.65 port=2345 sync=false async=false

# Send Webcam (320x200) using X.264 (Mux TS) => Very long delay (4-5 seconds)
# gst-launch -tv  v4l2src device="/dev/video0" ! queue ! videoscale method=1 ! video/x-raw-yuv,width=320,height=200 ! ffmpegcolorspace ! x264enc ! mpegtsmux ! tcpserversink host=192.168.29.65 port=2345 sync=false async=false

# Send Webcam (320x200) using X.264 (Mux RTP) => 
 gst-launch -tv  v4l2src device="/dev/video0" ! queue ! videoscale method=1 ! video/x-raw-yuv,width=320,height=200,framerate=15/1 ! ffmpegcolorspace ! x264enc ! video/x-h264 ! rtph264pay pt=96 ! tcpserversink host=192.168.29.65 port=2345 sync=false async=false


