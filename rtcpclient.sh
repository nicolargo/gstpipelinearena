#!/bin/sh

SERVER="192.168.29.148"
LATENCY="200"

gst-launch-0.10 -v gstrtpbin name=rtpbin latency=$LATENCY \
	udpsrc caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H264" port=5000 \
	! rtpbin.recv_rtp_sink_0 \
	rtpbin. ! rtph264depay ! ffdec_h264 ! xvimagesink sync=false \
	udpsrc port=5001 ! rtpbin.recv_rtcp_sink_0 \	
rtpbin.send_rtcp_src_0 ! udpsink port=5002 host=$SERVER sync=false async=false \
	udpsrc caps="application/x-rtp, media=(string)audio, clock-rate=(int)44100, encoding-name=(string)SPEEX, encoding-params=(string)1, ssrc=(guint)419764010, payload=(int)110, clock-base=(guint)3478167082, seqnum-base=(guint)57894" port=5003 \	
	! rtpbin.recv_rtp_sink_1 \
	rtpbin. ! rtpspeexdepay ! decodebin ! alsasink \
	udpsrc port=5004 ! rtpbin.recv_rtcp_sink_1 \
	rtpbin.send_rtcp_src_1 ! udpsink port=5005 host=$SERVER sync=false async=false

