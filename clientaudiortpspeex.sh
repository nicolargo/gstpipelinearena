gst-launch-0.10 udpsrc port=6969 caps="application/x-rtp, media=(string)audio, clock-rate=(int)16000, encoding-name=(string)SPEEX, encoding-params=(string)1, payload=(int)110" ! gstrtpjitterbuffer ! rtpspeexdepay ! speexdec ! audioconvert ! audioresample ! alsasink

