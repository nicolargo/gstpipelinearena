#!/bin/sh

gst-launch -tv tcpserversrc host=192.168.29.65 port=1234 ! decodebin ! autovideosink
