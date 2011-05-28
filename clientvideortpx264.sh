#!/bin/sh
# Receive video from client with RTP/X.264

PORTCLIENT=${1-"5000"}
LATENCY=${2-"500"}

DECODER="ffdec_h264"
DEPAYLOADER="rtph264depay"

RTPCAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)H264,ssrc=\(guint\)2834894965,payload=\(int\)96,clock-base=\(guint\)751940475,seqnum-base=\(guint\)56645"

gst-launch -tvm \
	gstrtpbin name=rtpbin latency=$LATENCY buffer-mode=0 \
		udpsrc caps=$RTPCAPS port=$PORTCLIENT \
		! rtpbin.recv_rtp_sink_0 \
			rtpbin. ! queue ! $DEPAYLOADER ! $DECODER ! autovideosink

##################
# OTHERS PIPELINES
##################

exit

gst-launch -tv --gst-debug-level=2 \
	udpsrc caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264, payload=(int)96" port=5000 \
	! queue ! rtph264depay \
	! queue ! ffdec_h264 ! autovideosink


# A mettre avant le rtph264depay si gros débit vidéo
#	! queue ! gstrtpjitterbuffer latency=3000 \

