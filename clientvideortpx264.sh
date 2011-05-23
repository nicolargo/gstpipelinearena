#!/bin/sh
# Receive video from client with RTP/X.264

gst-launch -tv --gst-debug-level=2 \
	udpsrc caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264, payload=(int)96" port=5000 \
	! queue ! rtph264depay \
	! queue ! ffdec_h264 ! gconfvideosink

# A mettre avant le rtph264depay si gros débit vidéo
#	! queue ! gstrtpjitterbuffer latency=3000 \

