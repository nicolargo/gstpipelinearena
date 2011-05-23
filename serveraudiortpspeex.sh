gst-launch-0.10 -v filesrc location=./samples/unnatural.mp3 ! mad ! audioconvert ! audioresample ! "audio/x-raw-int,rate=16000,width=16,channels=1" ! speexenc ! rtpspeexpay ! udpsink port=6969 
