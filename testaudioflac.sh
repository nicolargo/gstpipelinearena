#!/bin/sh

# HIFI 96Khz (la source est à 96 KHz)
gst-launch -v filesrc location="./samples/SchumSym1Munch.flac" ! decodebin ! queue ! audioconvert dithering=0 ! alsasink

# CD Quality
gst-launch -v filesrc location="./samples/SchumSym1Munch.flac" ! decodebin ! queue ! audioconvert dithering=0 ! audioresample ! audio/x-raw-int,rate=44100 ! alsasink
