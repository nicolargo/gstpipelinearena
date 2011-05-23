# Enregistrement du flux de la webcam en 1 img/s avec horodatage
# + Affiche webcam (+ img/sec)
# + Enregistre au format OGG
gst-launch -e v4l2src device="/dev/video0" ! queue ! videoscale method=1 ! video/x-raw-yuv,width=320,height=200 ! ffmpegcolorspace ! timeoverlay halign=right valign=top ! clockoverlay halign=left valign=top time-format="%Y/%m/%d %H:%M:%S" !    tee name="splitter" ! queue ! xvimagesink sync=false splitter. ! queue ! videorate ! video/x-raw-yuv,framerate=1/1 ! theoraenc bitrate=256 ! oggmux ! filesink location=webcam.ogg

