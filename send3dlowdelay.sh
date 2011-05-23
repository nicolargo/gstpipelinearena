#!/bin/sh
# Send 3D video signal (left and right) with low delay (local preview)

VIDEO_LEFT="./btc2Left.avi"
VIDEO_RIGHT="./btc2Right.avi"
#VIDEO_LEFT="./webcam-lossless.avi"
#VIDEO_RIGHT="./webcam-lossless.avi"

VIDEO_FPS=10

SERVER_IP=$1
LEFT_UDP_PORT=5000
RIGHT_UDP_PORT=5001

# MPEG-4
# No caps needed anymore with the 'rtpmp4vpay send-config=true' option
# Bitrate per channel (bps)
VIDEO_BITRATE=1500000
gst-launch -tv --gst-debug-level=2 \
	tee name="leftright" \
		filesrc location=$VIDEO_LEFT do-timestamp=true \
		! queue ! decodebin ! ffmpegcolorspace \
		! timeoverlay \
		! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! ffenc_mpeg4 name=leftenc bitrate=$VIDEO_BITRATE \
		! tee name="streamdisplayleft" \
			! rtpmp4vpay send-config=true ! udpsink port=$LEFT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayleft. \
			! ffdec_mpeg4 \
			! ffmpegcolorspace ! cairotextoverlay text="Left channel" shaded-background=true \
			! queue ! autovideosink \
	leftright. \
		filesrc location=$VIDEO_RIGHT do-timestamp=true \
		! queue ! decodebin ! ffmpegcolorspace \
		! timeoverlay \
		! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! ffenc_mpeg4 name=rightenc bitrate=$VIDEO_BITRATE \
		! tee name="streamdisplayright" \
			! rtpmp4vpay send-config=true ! udpsink port=$RIGHT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayright. \
			! ffdec_mpeg4 \
			! ffmpegcolorspace ! cairotextoverlay text="Right channel" shaded-background=true \
			! queue ! autovideosink		

exit 0

# MPEG-4
# No caps needed anymore with the 'rtpmp4vpay send-config=true' option
# Bitrate per channel (bps)
VIDEO_BITRATE=1500000
gst-launch -tv --gst-debug-level=2 \
	tee name="leftright" \
		filesrc location=$VIDEO_LEFT do-timestamp=true \
		! queue ! decodebin ! ffmpegcolorspace \
		! timeoverlay \
		! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! ffenc_mpeg4 name=leftenc bitrate=$VIDEO_BITRATE \
		! tee name="streamdisplayleft" \
			! rtpmp4vpay send-config=true ! udpsink port=$LEFT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayleft. \
			! ffdec_mpeg4 \
			! ffmpegcolorspace ! cairotextoverlay text="Left channel" shaded-background=true \
			! queue ! autovideosink \
	leftright. \
		filesrc location=$VIDEO_RIGHT do-timestamp=true \
		! queue ! decodebin ! ffmpegcolorspace \
		! timeoverlay \
		! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! ffenc_mpeg4 name=rightenc bitrate=$VIDEO_BITRATE \
		! tee name="streamdisplayright" \
			! rtpmp4vpay send-config=true ! udpsink port=$RIGHT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayright. \
			! ffdec_mpeg4 \
			! ffmpegcolorspace ! cairotextoverlay text="Right channel" shaded-background=true \
			! queue ! autovideosink	

# X.264
# Bitrate per channel (! in Kbps)
VIDEO_BITRATE=2000
gst-launch -tv --gst-debug-level=2 \
	tee name="leftright" \
		filesrc location=$VIDEO_LEFT \
		! queue ! decodebin ! ffmpegcolorspace \
		! queue ! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! queue ! x264enc bitrate=$VIDEO_BITRATE byte-stream=true \
		! tee name="streamdisplayleft" \
			! queue ! rtph264pay ! udpsink port=$LEFT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayleft. \
			! queue ! decodebin \
			! ffmpegcolorspace ! queue ! cairotextoverlay text="Left channel" shaded-background=true \
			! queue ! autovideosink \
	leftright. \
		filesrc location=$VIDEO_RIGHT \
		! queue ! decodebin ! ffmpegcolorspace \
		! queue ! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! queue ! x264enc bitrate=$VIDEO_BITRATE byte-stream=true \
		! tee name="streamdisplayright" \
			! queue ! rtph264pay ! udpsink port=$RIGHT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayright. \
			! queue ! decodebin \
			! ffmpegcolorspace ! queue ! cairotextoverlay text="Right channel" shaded-background=true \
			! queue ! autovideosink		


# MJPEG
# Bitrate per channel
VIDEO_BITRATE=2000000
gst-launch -tv --gst-debug-level=2 \
	tee name="leftright" \
		filesrc location=$VIDEO_LEFT \
		! queue ! decodebin ! ffmpegcolorspace \
		! queue ! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! queue ! ffenc_mjpeg bitrate=$VIDEO_BITRATE \
		! tee name="streamdisplayleft" \
			! queue ! rtpjpegpay ! udpsink port=$LEFT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayleft. \
			! queue ! ffdec_mjpeg \
			! ffmpegcolorspace ! queue ! cairotextoverlay text="Left channel" shaded-background=true \
			! queue ! autovideosink \
	leftright. \
		filesrc location=$VIDEO_RIGHT \
		! queue ! decodebin ! ffmpegcolorspace \
		! queue ! videorate ! video/x-raw-yuv,framerate=\(fraction\)$VIDEO_FPS/1 \
		! queue ! ffenc_mjpeg bitrate=$VIDEO_BITRATE \
		! tee name="streamdisplayright" \
			! queue ! rtpjpegpay ! udpsink port=$RIGHT_UDP_PORT host=$SERVER_IP sync=true \
		streamdisplayright. \
			! queue ! ffdec_mjpeg \
			! ffmpegcolorspace ! queue ! cairotextoverlay text="Right channel" shaded-background=true \
			! queue ! autovideosink		


