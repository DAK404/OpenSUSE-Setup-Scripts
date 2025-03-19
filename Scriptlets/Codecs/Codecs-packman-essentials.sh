#!/bin/bash

zypper ar -cfp 90 'http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Slowroll/Essentials/' packman-essentials
#zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials/' packman-essentials
zypper dup --from packman-essentials --allow-vendor-change
zypper install --allow-vendor-change --from packman-essentials ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs
