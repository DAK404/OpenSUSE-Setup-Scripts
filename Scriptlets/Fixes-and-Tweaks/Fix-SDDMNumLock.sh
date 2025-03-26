#!/bin/bash

############################################################
# Enable Number Lock on SDDM
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Fix-SDDMNumLock.sh)"
#
############################################################

echo -e "[General]\nNumLock=on" | tee -a /etc/sddm.conf > /dev/null