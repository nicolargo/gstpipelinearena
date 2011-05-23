#!/bin/sh

#SOURCE="autoaudiosrc"
SOURCE="filesrc location=/home/nicolargo/dev/gstpipelinearena/samples/voicewithnoise.wav ! decodebin ! audioconvert"
TIME=10
CUTOFF=150

# Sans
echo "Sans filtrage"
timeout $TIME gst-launch $SOURCE \
	! audioresample ! "audio/x-raw-int,rate=16000" \
	! autoaudiosink

# Avec
echo "Avec filtrage audiocheblimit"
echo "Supprime les fréquence inférieure à $CUTOFF"
timeout $TIME gst-launch $SOURCE \
	! audiocheblimit mode=1 cutoff=$CUTOFF ! audiodynamic ! audioconvert noise-shaping=4 \
	! audioresample ! audio/x-raw-int,rate=16000 \
	! autoaudiosink

# Avec
echo "Avec filtrage audiowsinclimit"
timeout $TIME gst-launch $SOURCE \
	! audiowsinclimit mode=1 length=200 cutoff=$CUTOFF  ! audiodynamic ! audioconvert noise-shaping=4 \
	! audioresample ! audio/x-raw-int,rate=16000 \
	! autoaudiosink
