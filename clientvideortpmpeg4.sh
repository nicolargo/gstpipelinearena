# RTP
#
# OK but had to set the config string in the caps

gst-launch -v --gst-debug-level=2 \
	udpsrc caps="application/x-rtp, media=(string)video, clock-rate=(int)90000, encoding-name=(string)MP4V-ES, profile-level-id=(string)1, config=(string)000001b001000001b58913000001000000012000c48d8800a51604481463000001b24c61766335322e32302e30, payload=(int)96" port=5000 \
	! queue ! rtpmp4vdepay \
	! queue ! ffdec_mpeg4 ! autovideosink 

