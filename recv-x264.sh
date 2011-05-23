gst-launch -tv udpsrc caps="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)H264,payload=\(int\)96" port=5000 do-timestamp=true ! queue ! decodebin sync=true ! ffmpegcolorspace ! xvimagesink sync=false

exit

gst-launch -tv udpsrc caps="application/x-rtp,media=\(string\)video,clock-rate=\(int\)90000,encoding-name=\(string\)H264,payload=\(int\)96" port=5000 do-timestamp=true ! queue ! decodebin sync=true ! ffmpegcolorspace ! autovideosink
