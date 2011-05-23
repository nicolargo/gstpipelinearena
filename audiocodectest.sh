#!/bin/sh

echo "Encode using MP3 codec"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	lamemp3enc target=1 bitrate=8 cbr=true encoding-engine-quality=0 ! id3v2mux ! \
	filesink location="samples/wb_male_mp3_8Kbps.mp3"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	lamemp3enc target=1 bitrate=16 cbr=true encoding-engine-quality=0 ! id3v2mux ! \
	filesink location="samples/wb_male_mp3_16Kbps.mp3"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	lamemp3enc target=1 bitrate=32 cbr=true encoding-engine-quality=0 ! id3v2mux ! \
	filesink location="samples/wb_male_mp3_32Kbps.mp3"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	lamemp3enc target=1 bitrate=64 cbr=true encoding-engine-quality=0 ! id3v2mux ! \
	filesink location="samples/wb_male_mp3_64Kbps.mp3"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	lamemp3enc target=1 bitrate=128 cbr=true encoding-engine-quality=0 ! id3v2mux ! \
	filesink location="samples/wb_male_mp3_128Kbps.mp3"

echo "Encode using VORBIS codec"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	vorbisenc managed=true bitrate=16000 ! oggmux ! \
	filesink location="samples/wb_male_vorbis_16Kbps.ogg"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	vorbisenc managed=true bitrate=32000 ! oggmux ! \
	filesink location="samples/wb_male_vorbis_32Kbps.ogg"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	vorbisenc managed=true bitrate=64000 ! oggmux ! \
	filesink location="samples/wb_male_vorbis_64Kbps.ogg"

echo "Encode using FLAC codec"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	flacenc quality=5 ! \
	filesink location="samples/wb_male_flac_Q5.flac"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	flacenc quality=0 ! \
	filesink location="samples/wb_male_flac_Q0.flac"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	flacenc quality=8 ! \
	filesink location="samples/wb_male_flac_Q8.flac"

echo "Encode using GSM (8Khz) codec"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	audioresample ! audio/x-raw-int,rate=8000 ! \
	gsmenc ! \
	filesink location="samples/wb_male_gsm.gsm"

echo "Encode using SPEEX (16 Khz) codec"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	audioresample ! audio/x-raw-int,rate=16000 ! \
	speexenc quality=4 vad=true dtx=true ! oggmux ! \
	filesink location="samples/wb_male_speex_Q4.ogg"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	audioresample ! audio/x-raw-int,rate=16000 ! \
	speexenc quality=10 vad=true dtx=true ! oggmux ! \
	filesink location="samples/wb_male_speex_Q10.ogg"
gst-launch filesrc location="samples/wb_male.wav" ! decodebin ! audioconvert ! \
	audioresample ! audio/x-raw-int,rate=16000 ! \
	speexenc quality=1 vad=true dtx=true ! oggmux ! \
	filesink location="samples/wb_male_speex_Q1.ogg"


