gst-launch-0.10 udpsrc port=6969 caps="" ! gstrtpjitterbuffer ! rtpg726depay ! ffdec_g726 ! audioconvert ! audioresample ! alsasink

