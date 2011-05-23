# RTP
# Work but add to force de fps to 24 on the client

gst-launch -v --gst-debug-level=2 \
	udpsrc caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)H263-1998, payload=(int)96, ssrc=(guint)3985667982, clock-base=(guint)1172933003, seqnum-base=(guint)16690" port=5000 \
	! queue ! rtph263pdepay \
	! queue ! ffdec_h263 ! autovideosink 

