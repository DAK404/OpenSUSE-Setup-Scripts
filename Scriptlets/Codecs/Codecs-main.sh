#!/bin/bash

############################################################
# Codecs Installation from Main Repositories
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Codecs/Codecs-main.sh)"
#
############################################################

zypper install ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs