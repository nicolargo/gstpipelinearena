#!/bin/sh

WEBCAM_DEV="/dev/video0"
WEBCAM_RESX=320
WEBCAM_RESY=240
WEBCAM_FPS=24

gst-launch -tv \
	v4l2src device=$WEBCAM_DEV \
	! videoscale method=1 ! videorate ! video/x-raw-yuv,width=\(int\)$WEBCAM_RESX,height=\(int\)$WEBCAM_RESY,framerate=\(fraction\)$WEBCAM_FPS/1 \
	! ffmpegcolorspace \
	! videobalance contrast=1.0 brightness=0.0 hue=0.0 saturation=1.0 \
	! videoflip method=4 \
	! fpsdisplaysink
#	! autovideosink
	
		
