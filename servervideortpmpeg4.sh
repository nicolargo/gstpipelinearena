# RTP

IPCLIENT=$1
PORTCLIENT=5000

WIDTH=704
HEIGHT=576
FPS=20
BITRATE=200000
BITRATE_TOLERANCE=20000
 
gst-launch -v --gst-debug-level=2 \
	autovideosrc ! ffmpegcolorspace \
	! queue ! decodebin \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT \
	! queue ! videorate ! video/x-raw-yuv,framerate=$FPS/1 \
	! queue max-size-bytes=20971520 !  ffenc_mpeg4 bitrate=$BITRATE bitrate-tolerance=$BITRATE_TOLERANCE \
	! rtpmp4vpay \
	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	
# WIDTH=352
# HEIGTH=288
# FPS=20
# BITRATE=200000
# BITRATE_TOLERANCE=20000
#
# -> OK bonne qualité

