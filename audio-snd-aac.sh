#!/bin/sh

SOURCE="filesrc location=\"samples/wb_male.wav\" ! decodebin ! audioconvert ! legacyresample ! audio/x-raw-int,rate=16000"
ENCODER="faac bitrate=32000"
PAYLOADER="rtpmp4apay"
DESTINATION_IP=${1-"127.0.0.1"}
# Vers relay
#DESTINATION="port=6868 host=$DESTINATION_IP"
# Vers rcv
DESTINATION="port=6969 host=$DESTINATION_IP"

# SON OK mais attention à voir si le CAPS ne change pas dynamiquement d'une machine à l'autre
gst-launch -tv \
	gstrtpbin name=rtpbin latency=100 buffer-mode=0 \
		$SOURCE \
		! queue ! $ENCODER ! $PAYLOADER \
		! rtpbin.send_rtp_sink_1 \
			rtpbin.send_rtp_src_1 ! udpsink $DESTINATION qos-dscp=46

