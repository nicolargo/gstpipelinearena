# gst-launch-0.10 -v alsasrc ! gsmenc ! rtpgsmpay ! udpsink port=6969 
# gst-launch-0.10 -v audiotestsrc ! gsmenc ! rtpgsmpay ! udpsink port=6969 
gst-launch -v gstrtpbin name=rtpbin \
	audiotestsrc ! gsmenc ! rtpgsmpay ! rtpbin.send_rtp_sink_0 \
	rtpbin.send_rtp_src_1 ! udpsink port=6969
		
