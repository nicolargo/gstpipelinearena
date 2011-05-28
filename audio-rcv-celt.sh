#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, clock-rate=(int)32000, encoding-name=(string)CELT, encoding-params=(string)1, frame-size=(string)480, payload=(int)96"
SOURCE="port=6969 caps=\"$CAPS\""

DECODER="gstrtpjitterbuffer latency=200 drop-on-latency=true ! rtpceltdepay ! celtdec"

gst-launch -tv \
	udpsrc $SOURCE ! $DECODER ! audioconvert ! audioresample ! alsasink
		


