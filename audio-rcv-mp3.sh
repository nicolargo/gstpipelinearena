#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, encoding-name=(string)MPA, payload=(int)96"
SOURCE="port=6969 caps=\"$CAPS\""

DECODER="gstrtpjitterbuffer latency=100 drop-on-latency=true ! rtpmpadepay ! ffdec_mp3"
gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


