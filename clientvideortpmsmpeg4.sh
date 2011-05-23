# RTP

gst-launch -v --gst-debug-level=2 \
	udpsrc caps="" port=5000 \
	! queue ! gstrtpjitterbuffer latency=3000 \
	! queue ! rtpmp4vdepay \
	! queue ! ffdec_msmpeg4 ! autovideosink 

