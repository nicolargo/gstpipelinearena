# RTP
# Not Work

CLIENTIP=127.0.0.1
VIDEOCAPS="video/x-raw-yuv,width=(int)320,height=(int)240,framerate=(fraction)15/1"
VIDEOPORT=5000

gst-launch -tv \
	gstrtpbin name=rtpbin latency=0 buffer-mode=0 \
		! autovideosrc ! videoscale ! videorate ! $VIDEOCAPS \
		! queue ! ffmpegcolorspace ! theoraenc bitrate=200 \
		! rtptheorapay \
		! rtpbin.send_rtp_sink_0 rtpbin.send_rtp_src_0 \
		! udpsink host=$CLIENTIP port=$VIDEOPORT 
			
#gst-launch -v --gst-debug-level=2 \
#	autovideosrc ! ffmpegcolorspace \
#	! queue ! decodebin \
#	! queue ! videoscale method=1 ! video/x-raw-yuv,width=352,height=288 \
#	! queue ! videorate ! video/x-raw-yuv,framerate=10/1 \
#	! queue max-size-bytes=20971520 ! theoraenc bitrate=200 \
#	! queue ! rtptheorapay \
#	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	

