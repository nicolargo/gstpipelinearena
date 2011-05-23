#!/bin/sh
# Send video (Webcam) with low delay (local preview)

WEBCAM_DEV="/dev/video0"
WEBCAM_WIDTH=704
WEBCAM_HEIGHT=576
WEBCAM_FPS=10

SERVER_IP=$1
SEND_UDP_PORT=5000

BITRATE=2000000
gst-launch -tv --gst-debug-level=2 \
	v4l2src device=$WEBCAM_DEV \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=\(int\)$WEBCAM_WIDTH,height=\(int\)$WEBCAM_HEIGHT \
	! queue ! videorate ! video/x-raw-yuv,framerate=\(fraction\)$WEBCAM_FPS/1 \
	! queue ! ffenc_mjpeg bitrate=$BITRATE \
	! tee name="streamdisplay" \
	! queue ! rtpjpegpay ! udpsink port=$SEND_UDP_PORT host=$SERVER_IP sync=true \
	streamdisplay. \
	! queue ! ffdec_mjpeg \
	! ffmpegcolorspace ! queue ! cairotextoverlay text="Local" shaded-background=true \
	! queue ! autovideosink 

exit 0

# MJPEG
BITRATE=2000000
gst-launch -tv --gst-debug-level=2 \
	v4l2src device=$WEBCAM_DEV \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=\(int\)$WEBCAM_WIDTH,height=\(int\)$WEBCAM_HEIGHT \
	! queue ! videorate ! video/x-raw-yuv,framerate=\(fraction\)$WEBCAM_FPS/1 \
	! queue ! ffenc_mjpeg bitrate=$BITRATE \
	! tee name="streamdisplay" \
	! queue ! rtpjpegpay ! udpsink port=$SEND_UDP_PORT host=$SERVER_IP \
	streamdisplay. \
	! queue ! ffdec_mjpeg \
	! ffmpegcolorspace ! queue ! cairotextoverlay text="Local" shaded-background=true \
	! queue ! autovideosink 

