#!/bin/sh

# Marche quand on décode puis re-encode
gst-launch -tv tcpserversrc host=192.168.29.65 port=1234 ! oggdemux ! theoradec ! queue ! theoraenc ! oggmux ! tcpserversink host=192.168.29.65 port=2345 sync=false async=false

# Ne marche pas quand on "relay": problème de caps
# gst-launch -tv tcpserversrc host=192.168.29.65 port=1234 ! queue ! tcpserversink host=192.168.29.65 port=2345 sync=false async=false
