#!/bin/sh

SOURCE="filesrc location=\"samples/wb_male.wav\" ! decodebin ! audioconvert ! legacyresample ! audio/x-raw-int,rate=8000"
ENCODER="gsmenc"
PAYLOADER="rtpgsmpay"
DESTINATION_IP=${1-"127.0.0.1"}
DESTINATION="port=6969 host=$DESTINATION_IP"

# SON OK
gst-launch -tv \
	gstrtpbin name=rtpbin latency=200 buffer-mode=0 \
		$SOURCE \
		! queue ! $ENCODER ! $PAYLOADER \
		! rtpbin.send_rtp_sink_1 \
			rtpbin.send_rtp_src_1 ! udpsink $DESTINATION

