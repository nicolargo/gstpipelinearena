# RTP
# Not Work: needs string "configuration" in caps...

VIDEOCAPS="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)THEORA,sampling=\(string\)YCbCr-4:2:0,width=\(string\)320,height=\(string\)240,delivery-method=\(string\)inline,ssrc=\(guint\)1157217335,payload=\(int\)96,clock-base=\(guint\)1092900643,seqnum-base=\(guint\)22781"
VIDEOPORT=5000

gst-launch -tvm \
	gstrtpbin name=rtpbin latency=0 buffer-mode=0 \
		udpsrc caps=$VIDEOCAPS port=$VIDEOPORT do-timestamp=true \
		! rtpbin.recv_rtp_sink_0 \
			rtpbin. ! rtptheoradepay ! theoradec ! autovideosink

