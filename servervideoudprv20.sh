# UDP

IPCLIENT=$1
PORTCLIENT=5000

# Voir profils en bas du fichier

WIDTH=352
HEIGHT=288
FPS=25
BITRATE=100000

gst-launch -v --gst-debug-level=2 \
	autovideosrc \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT \
	! queue ! videorate ! video/x-raw-yuv,framerate=$FPS/1 \
	! queue !  ffenc_rv20 bitrate=$BITRATE \
	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	

