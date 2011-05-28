#!/bin/sh
# Script to test video codecs (live)
# Nicolargo - http://blog.nicolargo.com/gstreamer

CODEC1="ffenc_mpeg4" ; CODEC1_OPT="bitrate=128000"
CODEC2="xvidenc" ; CODEC2_OPT="bitrate=128000 profile=145"
#CODEC1="vp8enc" ; CODEC_OPT1="max-latency=1 mode=cbr"

# Compare two codecs (CODEC1 vs CODEC2) and also vs source

gst-launch -tv autovideosrc ! videoscale ! videorate \
  ! "video/x-raw-yuv,width=(int)320,height=(int)240,framerate=(fraction)15/1" \
  ! tee name="source" \
    ! tee name="codec1" \
      ! queue ! cairotextoverlay text="$CODEC2" shaded-background=true \
      ! $CODEC2 $CODEC_OPT2 ! decodebin ! autovideosink \
    codec1. \
      ! queue ! cairotextoverlay text="$CODEC1" shaded-background=true \
      ! $CODEC1 $CODEC_OPT1 ! decodebin ! autovideosink \
  source. \
    ! queue ! cairotextoverlay text="Source" shaded-background=true ! autovideosink

# Compare codec vs source

gst-launch -tv autovideosrc ! videoscale ! videorate \
  ! "video/x-raw-yuv,width=(int)320,height=(int)240,framerate=(fraction)15/1" \
  ! tee name="source" \
      ! queue ! cairotextoverlay text="$CODEC1" shaded-background=true \
      ! $CODEC1 $CODEC_OPT1 ! decodebin ! autovideosink \
  source. \
    ! queue ! cairotextoverlay text="Source" shaded-background=true ! autovideosink
