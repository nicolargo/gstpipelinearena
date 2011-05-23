gst-launch tcpserversrc host=localhost port=3000 ! decodebin ! audioconvert ! alsasink
