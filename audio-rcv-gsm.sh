#!/bin/sh

SOURCE="port=6969 caps=\"application/x-rtp, media=(string)audio, clock-rate=(int)8000, encoding-name=(string)GSM\""

DECODER="gstrtpjitterbuffer latency=100 drop-on-latency=true ! rtpgsmdepay ! gsmdec"

gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


