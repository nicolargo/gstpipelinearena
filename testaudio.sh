#!/bin/sh

echo "default"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! alsasink 2>&1 /dev/null > /dev/null

echo "audioamplify amplification=2"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! audioamplify amplification=2 ! alsasink 2>&1 /dev/null > /dev/null

echo "legacyresample ! audio/x-raw-int, rate=8000"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! legacyresample ! audio/x-raw-int, rate=8000 ! alsasink 2>&1 /dev/null > /dev/null

# Mix 2 audio channels
gst-launch -v filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! audioresample ! audio/x-raw-int,rate=44100,channel=1 ! adder name=mix ! alsasink audiotestsrc freq=500 ! audioconvert ! audioresample ! audio/x-raw-int,rate=44100,channel=1 ! mix.

# Mix 2 audio channels
gst-launch -v adder name=mix ! alsasink \
	{ filesrc location="samples/testmale.wav" ! decodebin ! audioconvert ! audioresample ! audio/x-raw-int,rate=44100,channel=1 ! mix. } \
	{ filesrc location="samples/unnatural.mp3" ! decodebin ! audioconvert ! audioresample ! audio/x-raw-int,rate=44100,channel=1 ! mix. }

# Mix 3 audio channels
gst-launch -v adder name=mix ! alsasink \
	{ filesrc location="samples/testmale.wav" ! decodebin ! audioconvert ! audioresample ! audio/x-raw-int,rate=44100,channel=1 ! mix. } \
	{ filesrc location="samples/unnatural.mp3" ! decodebin ! audioconvert ! audioresample ! audio/x-raw-int,rate=44100,channel=1 ! mix. } \
	{ filesrc location="samples/female.wav" ! decodebin ! audioconvert ! audioresample ! audio/x-raw-int,rate=44100,channel=1 ! mix. }

# Analyse spectre (-m pour voir les messages  venant du bus)
gst-launch -m autoaudiosrc ! audioconvert ! audioresample ! "audio/x-raw-float,rate=16000" ! spectrum  ! autoaudiosink
