#!/bin/sh

CLIENT="192.168.29.150"

gst-launch -v gstrtpbin name=rtpbin \
	v4l2src ! videoscale method=1 ! video/x-raw-yuv,width=352,height=288,framerate=\(fraction\)10/1 \
	! queue ! x264enc byte-stream=true bitrate=300 ! rtph264pay \
	! rtpbin.send_rtp_sink_0 \
	rtpbin.send_rtp_src_0 ! udpsink port=5000 host=$CLIENT \
	rtpbin.send_rtcp_src_0 ! udpsink port=5001 host=$CLIENT sync=false async=false \
	udpsrc port=5002 ! rtpbin.recv_rtcp_sink_0 \
	alsasrc \
	! queue ! speexenc ! rtpspeexpay \
	! rtpbin.send_rtp_sink_1 \
	rtpbin.send_rtp_src_1 ! udpsink port=5003 host=$CLIENT \
	rtpbin.send_rtcp_src_1 ! udpsink port=5004 host=$CLIENT sync=false async=false \
	udpsrc port=5005 ! rtpbin.recv_rtcp_sink_1


