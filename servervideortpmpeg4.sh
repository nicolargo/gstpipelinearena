# RTP

IPCLIENT=${1-"127.0.0.1"}
PORTCLIENT=${2-"5000"}
LATENCY=${3-"0"}

ENCODER="ffenc_mpeg4"
PAYLOADER="rtpmp4vpay send-config=true"

# LE TOP POUR LA VISIO
VIDEOSRC="autovideosrc"
VIDEOCAPS="video/x-raw-yuv,width=352,height=288,framerate=10/1"
BITRATE=128000
ENCODER_OPT="bitrate=$BITRATE bitrate-tolerance=$BITRATE pass=0 trellis=1 idct-algo=11 quant-type=0 rc-qmod-amp=99 rc-buffer-aggressivity=99"  

# LE TOP POUR LIVE SCREENCASTING
#VIDEOSRC="ximagesrc"
#VIDEOCAPS="video/x-raw-yuv,width=352,height=288,framerate=10/1"
#BITRATE=160000
#ENCODER_OPT="bitrate=$BITRATE bitrate-tolerance=$BITRATE pass=0 trellis=0 idct-algo=11 quant-type=0 rc-qmod-amp=50 rc-buffer-aggressivity=50"  

gst-launch -tv \
	gstrtpbin name=rtpbin latency=$LATENCY buffer-mode=0 \
		$VIDEOSRC \
		! queue ! videoscale method=1 ! videorate ! $VIDEOCAPS \
		! tee name="display" \
			! queue ! cairotextoverlay text="$ENCODER $BITRATE" shaded-background=true \
			! queue ! $ENCODER $ENCODER_OPT \
			! $PAYLOADER \
			! rtpbin.send_rtp_sink_0 rtpbin.send_rtp_src_0 \
			! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false \
		display. \
			! queue ! cairotextoverlay text="Source" shaded-background=true \
			! autovideosink


##################
# OTHERS PIPELINES
##################

exit

# Sans gstrtpbin
gst-launch -v --gst-debug-level=2 \
	$VIDEOSRC ! ffmpegcolorspace \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT \
	! queue ! videorate ! video/x-raw-yuv,framerate=$FPS/1 \
	! queue max-size-bytes=20971520 !  ffenc_mpeg4 $MPEG4_OPT \
	! rtpmp4vpay send-config=true \
	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	
