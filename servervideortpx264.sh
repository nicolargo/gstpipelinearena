#!/bin/sh
# Send video (Webcam) to server with RTP/X.264

IPCLIENT=${1-"127.0.0.1"}
PORTCLIENT=${2-"5000"}
LATENCY=${3-"200"}

ENCODER="x264enc"
PAYLOADER="rtph264pay config-interval=3"

VIDEOSRC="autovideosrc"
VIDEOCAPS="video/x-raw-yuv,width=352,height=288,framerate=10/1"
BITRATE=160
ENCODER_OPT="bitrate=$BITRATE byte-stream=true bframes=4 ref=4 me=hex subme=4 weightb=true threads=0"

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

gst-launch -tv --gst-debug-level=2 \
	$VIDEOSRC ! ffmpegcolorspace \
	! queue ! videoscale method=1 ! videorate ! $VIDEOCAPS \
	! queue ! x264enc $ENCODER_OPT ! rtph264pay config-interval=$RTP_CONFIG_INTERVAL \
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

