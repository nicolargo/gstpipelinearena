#!/bin/sh

VIDEOCAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)MP4V-ES,payload=\(int\)96"
AUDIOCAPS="application/x-rtp,media=\(string\)audio,clock-rate=\(int\)8000,encoding-name=\(string\)PCMA,payload=\(int\)96"
VIDEOPORT=5000
AUDIOPORT=5001

gst-launch -tv gstrtpbin name=rtpbin latency=0 buffer-mode=0 \
	udpsrc caps=$VIDEOCAPS port=$VIDEOPORT do-timestamp=true \
		! rtpbin.recv_rtp_sink_0 \
			rtpbin. ! rtpmp4vdepay ! ffdec_mpeg4 ! autovideosink \
	udpsrc caps=$AUDIOCAPS port=$AUDIOPORT do-timestamp=true \
		! rtpbin.recv_rtp_sink_1 \
			rtpbin. ! rtppcmadepay ! alawdec ! autoaudiosink


