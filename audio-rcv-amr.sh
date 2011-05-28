#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, clock-rate=(int)8000, encoding-name=(string)AMR, encoding-params=(string)1, octet-align=(string)1, payload=(int)96"
SOURCE="port=6969 caps=\"$CAPS\""

DECODER="gstrtpjitterbuffer latency=200 drop-on-latency=true ! rtpamrdepay ! amrnbdec"

gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


