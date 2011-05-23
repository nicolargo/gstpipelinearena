#!/bin/sh

CAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)MP4V-ES,payload=\(int\)96"

gst-launch -tv gstrtpbin name=rtpbin latency=0 buffer-mode=0 \
	udpsrc caps=$CAPS port=5000 do-timestamp=true \
	! rtpbin.recv_rtp_sink_0 \
		rtpbin. ! rtpmp4vdepay ! ffdec_mpeg4 ! autovideosink

exit

gst-launch -tv udpsrc caps=$CAPS port=5000 do-timestamp=true \
	! queue ! decodebin sync=true ! ffmpegcolorspace ! autovideosink

