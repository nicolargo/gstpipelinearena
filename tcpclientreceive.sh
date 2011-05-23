#!/bin/sh

# Without RTP
# gst-launch -tv tcpclientsrc host=192.168.29.65 port=2345 ! decodebin ! autovideosink

# With RTP (H.264)
gst-launch -tv gstrtpbin name="rtpbin" latency=200 \
	tcpclientsrc host=192.168.29.65 port=2345 typefind=true do-timestamp=true \
	! rtpbin.recv_rtp_sink_0
	rtpbin. ! rtph264depay ! decodebin ! autovideosink

