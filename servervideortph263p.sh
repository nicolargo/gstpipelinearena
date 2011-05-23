# RTP

# Il faut lancer le client puis ensuite le serveur

IPCLIENT=$1
PORTCLIENT=5000

# Voir profils en bas du fichier

WIDTH=352
HEIGHT=288
FPS=25
BITRATE=200000
BITRATE_TOLERANCE=50000

gst-launch -v --gst-debug-level=2 \
	autovideosrc ! ffmpegcolorspace \
	! queue ! decodebin \
	! queue ! videoscale method=1 ! video/x-raw-yuv,width=$WIDTH,height=$HEIGHT \
	! queue ! videorate ! video/x-raw-yuv,framerate=$FPS/1 \
	! queue ! ffenc_h263p bitrate=$BITRATE bitrate-tolerance=$BITRATE_TOLERANCE \
	! queue ! rtph263ppay \
	! queue ! udpsink port=$PORTCLIENT host=$IPCLIENT sync=false async=false 
	
# PROFILS

#-----------------------------------------------------------------------------
# WIDTH=352
# HEIGHT=288
# FPS=25
# BITRATE=120000
#
# => Qualité acceptable pour visio
# => Débit entre 90 et 260 Kbps
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# WIDTH=352
# HEIGHT=288
# FPS=25
# BITRATE=200000
# BITRATE_TOLERANCE=50000
#
# => Bonne pour visio
# => Débit entre 100 et 250 Kbps
#-----------------------------------------------------------------------------


