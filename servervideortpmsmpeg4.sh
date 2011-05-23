# RTP
#
# !!! Pas de payloader msmpeg4

IPCLIENT=127.0.0.1
PORTCLIENT=5000
BITRATE=200000
BITRATE_TOLERANCE=20000
 
gst-launch -v --gst-debug-level=2 \
	autovideosrc ! ffmpegcolorspace \
	! queue ! decodebin \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=352,height=288 \
	! queue ! videorate ! video/x-raw-yuv,framerate=10/1 \
	! queue max-size-bytes=20971520 !  ffenc_msmpeg4 bitrate=$BITRATE bitrate_tolerance=$20000 \
	! rtpmp4vpay \
	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	

