# RTP
#
# OK but had to set the config string in the caps

PORTCLIENT=${1-"5000"}
LATENCY=${2-"200"}

DECODER="ffdec_mpeg4"
DEPAYLOADER="rtpmp4vdepay"

RTPCAPS="application/x-rtp, media=\(string\)video, clock-rate=\(int\)90000, encoding-name=\(string\)MP4V-ES, profile-level-id=\(string\)1, payload=\(int\)96"

gst-launch -tvm \
	gstrtpbin name=rtpbin latency=$LATENCY buffer-mode=0 \
		udpsrc caps="$RTPCAPS" port=$PORTCLIENT \
		! rtpbin.recv_rtp_sink_0 \
			rtpbin. ! queue ! $DEPAYLOADER ! $DECODER ! autovideosink

##################
# OTHERS PIPELINES
##################

exit

gst-launch -tv \
	udpsrc caps="$RTPCAPS" port=5000 \
	! queue ! rtpmp4vdepay \
	! queue ! ffdec_mpeg4 \
	! ffmpegcolorspace ! autovideosink 

