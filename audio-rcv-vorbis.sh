#!/bin/sh

SOURCE="port=6969 caps=\"application/x-rtp, media=(string)audio, clock-rate=(int)16000, encoding-name=(string)VORBIS, encoding-params=(string)1\""

DECODER="gstrtpjitterbuffer latency=100 drop-on-latency=true ! rtpvorbisdepay ! vorbisdec"
gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


