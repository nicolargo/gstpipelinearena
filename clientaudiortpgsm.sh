# gst-launch-0.10 udpsrc port=6969 ! rtpgsmdepay ! gsmdec ! audioconvert ! audioresample ! alsasink
gst-launch udpsrc port=6969 ! .recv_rtp_sink_0 \
	gstrtpbin ! rtpgsmdepay ! gsmdec ! audioconvert ! audioresample ! alsasink
