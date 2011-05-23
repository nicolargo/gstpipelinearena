#!/bin/sh

WEBCAM_RESX=320
WEBCAM_RESY=200
WEBCAM_FPS=24

gst-launch -tv  v4l2src device="/dev/video0" \
                ! queue ! videoscale method=1 ! videorate \
                ! video/x-raw-yuv,width=\(int\)$WEBCAM_RESX,height=\(int\)$WEBCAM_RESY,framerate=\(fraction\)$WEBCAM_FPS/1 \
                ! ffmpegcolorspace \
                ! vp8enc max-latency=1 mode="cbr" \
                ! webmmux streamable=true \
                ! progressreport \
                ! matroskademux \
                ! vp8dec \
                ! xvimagesink sync=false

# Ne marche pas bien si on utilise ! autovideosink sync=false

