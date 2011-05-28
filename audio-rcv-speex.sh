#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, clock-rate=(int)24000, encoding-name=(string)SPEEX, encoding-params=(string)1, payload=(int)110"
SOURCE="port=6969 caps=\"$CAPS\""

DECODER="gstrtpjitterbuffer latency=200 drop-on-latency=true ! rtpspeexdepay ! speexdec"

gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


