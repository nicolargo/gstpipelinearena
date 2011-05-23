#!/bin/sh

gst-launch autovideosrc ! videoscale ! videorate ! "video/x-raw-yuv,width=(int)320,height=(int)240,framerate=(fraction)15/1" ! tee name="display" ! queue ! cairotextoverlay text="Apres" shaded-background=true ! ffenc_mpeg4 bitrate=128000 ! decodebin ! autovideosink display. ! queue ! cairotextoverlay text="Avant" shaded-background=true ! autovideosink
