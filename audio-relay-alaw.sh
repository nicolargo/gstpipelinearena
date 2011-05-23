#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, clock-rate=(int)8000, encoding-name=(string)PCMA, payload=(int)8"
SOURCE="port=6868 caps=\"$CAPS\""
DESTINATION_IP=${1-"127.0.0.1"}
DESTINATION="port=6969 host=$DESTINATION_IP"

gst-launch -tv \
	udpsrc $SOURCE ! udpsink $DESTINATION
		


