#!/bin/sh

CAPS="application/x-rtp, media=(string)audio, clock-rate=(int)16000, encoding-name=(string)MP4A-LATM, cpresent=(string)0, payload=(int)96, config=(string)40002810"
SOURCE="port=6868 caps=\"$CAPS\""
DESTINATION_IP=${1-"127.0.0.1"}
DESTINATION="port=6969 host=$DESTINATION_IP"

gst-launch -tv \
	udpsrc $SOURCE ! udpsink $DESTINATION qos-dscp=46
		


