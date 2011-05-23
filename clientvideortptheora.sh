# RTP
# Not Work: needs string "configuration" in caps...

gst-launch -v --gst-debug-level=2 \
	udpsrc caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)THEORA, sampling=(string)YCbCr-4:2:0, width=(string)352, height=(string)288, delivery-method=(string)inline, payload=(int)96, ssrc=(guint)384708083, clock-base=(guint)355459878, seqnum-base=(guint)6971" port=5000 \
	! queue ! gstrtpjitterbuffer latency=3000 \
	! queue ! rtptheoradepay \
	! queue ! theoradec ! autovideosink 

