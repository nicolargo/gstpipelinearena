# RTP

IPCLIENT=$1
PORTCLIENT=5000
BITRATE=200000
BITRATE_TOLERANCE=20000
 
gst-launch -v --gst-debug-level=2 \
	autovideosrc ! ffmpegcolorspace \
	! queue ! decodebin \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=352,height=288 \
	! queue ! videorate ! video/x-raw-yuv,framerate=10/1 \
	! queue max-size-bytes=20971520 !  ffenc_mpeg4 bitrate=$BITRATE bitrate-tolerance=$BITRATE_TOLERANCE \
	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	

