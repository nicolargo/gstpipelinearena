#!/bin/sh
# Receive 3D video stream (left and right) with low delay

LEFT_UDP_PORT=5000
RIGHT_UDP_PORT=5001

# MPEG-4
CAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)MP4V-ES,payload=\(int\)96"
gst-launch -tv --gst-debug-level=2 \
	tee name="leftright" \
		udpsrc caps=$CAPS port=$LEFT_UDP_PORT do-timestamp=true \
		! queue ! decodebin sync=true \
		! queue ! ffmpegcolorspace ! autovideosink \
	leftright. \
		udpsrc caps=$CAPS port=$RIGHT_UDP_PORT do-timestamp=true \
		! queue ! decodebin sync=true \
		! queue ! ffmpegcolorspace ! autovideosink 

exit 0

# MPEG-4
#CAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)MP4V-ES,payload=\(int\)96,config=\(string\)000001b001000001b58913000001000000012000c48d88005514043c1463000001b24c61766335322e37392e31"
CAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)MP4V-ES,payload=\(int\)96"
		! queue ! decodebin sync=true \

# MJPEG
CAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)JPEG,payload=\(int\)96"

