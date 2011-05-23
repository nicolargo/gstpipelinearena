#!/bin/sh
#
# Encodeur MP4 basé sur GStreamer
#
# Syntaxe:
# ./mp4encoder <source>
#    avec <source> : fichier video
# => Fichier au format .mp4 (X.264 + AAC)
#
# Paramètres d'encodage à modifier dans variable (VIDEO|AUDIO)_ENCODER_PARAMETERS
# - Video: threads=0
# - Audio:
#
VERSION="1.0"

SOURCE=$1
BASENAME=$(basename $1 .${1##*.})
DESTINATION=$BASENAME.mp4

VIDEO_ENCODER="x264enc"
VIDEO_ENCODER_PARAMETERS="threads=0"
AUDIO_ENCODER="faac"
AUDIO_ENCODER_PARAMETERS=""
VIDEOAUDIO_MUXER="ffmux_mp4"

# Test des paramètres
param() {
	if [ "$#" -ne "1" ]; then
		echo "Syntaxe: $0 <video>"
		exit 1
	fi
	if [ ! -r $@ ]; then
		echo "Impossible de lire le fichier $@"
	fi
}

# Fonction permettant de tester la présence des plugins Gstreamer
check() {
	# Test plugins gstreamer
	gst-inspect $VIDEO_ENCODER 2>&1 > /dev/null
	if [ "$?" -ne "0" ]; then 
		echo "Encodeur $VIDEO_ENCODER introuvable / Installer le plugin gstreamer $VIDEO_ENCODER"; 
		exit 10
	fi
	gst-inspect $AUDIO_ENCODER 2>&1 > /dev/null
	if [ "$?" -ne "0" ]; then 
		echo "Encodeur $AUDIO_ENCODER introuvable / Installer le plugin gstreamer $AUDIO_ENCODER"; 
		exit 11
	fi
}

encode() {
	# Pipeline d'encodage
	PIPELINE="gst-launch -t filesrc location=$SOURCE ! progressreport ! decodebin name=decoder \
	 decoder. ! queue ! audioconvert ! $AUDIO_ENCODER $AUDIO_ENCODER_PARAMETERS ! queue ! \
	 $VIDEOAUDIO_MUXER name=muxer \
	 decoder. ! queue ! ffmpegcolorspace ! $VIDEO_ENCODER $VIDEO_ENCODER_PARAMETERS ! queue ! \
	 muxer. muxer. ! queue ! filesink location=$DESTINATION"

	# Resume
	echo
	echo "Encodage de $SOURCE vers $DESTINATION"
	echo "Paramètres video: $VIDEO_ENCODER_PARAMETERS"
	echo "Paramètres audio: $AUDIO_ENCODER_PARAMETERS"
	echo

	# Encodage
	time $PIPELINE
}

# Programme principal
param $@
check
encode
exit 0

