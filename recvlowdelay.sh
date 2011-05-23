#!/bin/sh
# Receive video with low delay

RECV_UDP_PORT=5000

CAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)JPEG,payload=\(int\)96"
gst-launch -tv --gst-debug-level=2\
	udpsrc caps=$CAPS port=$RECV_UDP_PORT \
	! queue ! decodebin sync=true \
	! queue ! ffmpegcolorspace ! autovideosink

exit 0

# MJPEG
CAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)JPEG,payload=\(int\)96"
gst-launch -tv --gst-debug-level=2\
	udpsrc caps=$CAPS port=$RECV_UDP_PORT \
	! queue ! decodebin \
	! queue ! ffmpegcolorspace ! autovideosink



