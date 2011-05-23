#!/bin/sh

SOURCE="filesrc location=\"samples/wb_male.wav\" ! decodebin ! audioconvert ! legacyresample ! audio/x-raw-int,rate=16000"
ENCODER="lamemp3enc target=1 cbr=1 bitrate=32 encoding-engine-quality=0"
PAYLOADER="rtpmpapay"
DESTINATION="port=6969 host=127.0.0.1"

#gst-launch -tv \
#	$SOURCE ! $ENCODER ! \
#	$PAYLOADER ! udpsink $DESTINATION

# SON MAUVAIS AVEC COUPURE
gst-launch -tv \
	gstrtpbin name=rtpbin latency=100 buffer-mode=0 \
		$SOURCE \
		! queue ! $ENCODER ! $PAYLOADER \
		! rtpbin.send_rtp_sink_1 \
			rtpbin.send_rtp_src_1 ! udpsink $DESTINATION

