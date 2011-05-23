#!/bin/sh

# sudo gst-launch v4l2src device="/dev/video1" ! queue ! videoscale method=1 ! video/x-raw-yuv,width=704,height=576 ! avimux ! filesink location=videotest.avi

videosrc="./videotest.avi"
reslist="width=704,height=576 width=352,height=288 width=176,height=144 width=128,height=96"
fpslist="24 12 6 3"
bitratelist="400 300 200 100 50"

for res in `echo $reslist`
do 
 resname=`echo $res | sed "s/width=//" | sed "s/height=//" | sed "s/,/x/"`
 for fps in `echo $fpslist`
 do
  for bitrate in `echo $bitratelist`
  do
   echo ---
   echo videotest-${resname}-${fps}fps-${bitrate}kbps.avi
   gst-launch filesrc location=$videosrc ! decodebin ! ffmpegcolorspace ! queue ! cairotextoverlay text="${resname} ${fps}fps ${bitrate}kbps" shaded-background=true ! queue ! videorate ! video/x-raw-yuv,framerate=$fps/1 ! queue ! videoscale method=1 !  video/x-raw-yuv,$res ! queue ! ffmpegcolorspace ! x264enc byte-stream=true bitrate=$bitrate bframes=4 ref=4 me=hex subme=4 weightb=true threads=0 ! avimux ! filesink location=videotest-${resname}-${bitrate}kbps-${fps}fps.avi
   echo ---
  done
 done
done

