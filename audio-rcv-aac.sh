#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, clock-rate=(int)16000, encoding-name=(string)MP4A-LATM, cpresent=(string)0, payload=(int)96, config=(string)40002810"
SOURCE="port=6969 caps=\"$CAPS\""

DECODER="gstrtpjitterbuffer latency=200 drop-on-latency=true ! rtpmp4adepay ! faad"

gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


