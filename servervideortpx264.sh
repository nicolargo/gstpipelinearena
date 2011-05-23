#!/bin/sh
# Send video (Webcam) to server with RTP/X.264

IPCLIENT=$1
PORTCLIENT=5000

WEBCAM_DEV="/dev/video0"
WEBCAM_WIDTH=352
WEBCAM_HEIGHT=288
WEBCAM_FPS=24

X264_BITRATE=600
X264_PARAM="byte-stream=true bframes=4 ref=4 me=hex subme=4 weightb=true threads=0"
RTP_CONFIG_INTERVAL=5

gst-launch -tv --gst-debug-level=2 \
	v4l2src device=$WEBCAM_DEV \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=$WEBCAM_WIDTH,height=$WEBCAM_HEIGHT \
	! queue ! videorate ! video/x-raw-yuv,framerate=$WEBCAM_FPS/1 \
	! queue ! x264enc bitrate=$X264_BITRATE $X264_PARAM ! rtph264pay config-interval=$RTP_CONFIG_INTERVAL \
	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	
# PROFILS

#-----------------------------------------------------------------------------
# WIDTH=352
# HEIGHT=288
# FPS=6
# BITRATE=50
#
# => Qualité tout juste acceptable pour visio
# => Débit entre 45 et 60 Kbps
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# WIDTH=352
# HEIGHT=288
# FPS=12
# BITRATE=60
#
# => Qualité acceptable pour visio
# => Débit entre 55 et 85 Kbps
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# WIDTH=352
# HEIGHT=288
# FPS=25
# BITRATE=80
#
# => Qualité acceptable pour visio
# => Débit entre 85 et 115 Kbps
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# WIDTH=352
# HEIGHT=288
# FPS=12
# BITRATE=120
#
# => Bonne qualité pour visio
# => Débit entre 110 et 150 Kbps
# => 15% CPU sur encodeur (Dual-core 2.6 Ghz)
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# WIDTH=352
# HEIGHT=288
# FPS=25
# BITRATE=150
#
# => Bonne qualité pour visio
# => Débit entre 140 et 200 Kbps
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# WIDTH=704
# HEIGHT=576
# FPS=25
# BITRATE=200
#
# => Qualité acceptable pour du full-screen
# => Débit entre 205 et 275 Kbps
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# WIDTH=704
# HEIGHT=576
# FPS=25
# BITRATE=300
#
# => Bonne qualité pour du full-screen
# => Débit entre 280 et 390 Kbps
# => 50% CPU sur encodeur (Dual-core 2.6 Ghz)
#-----------------------------------------------------------------------------

