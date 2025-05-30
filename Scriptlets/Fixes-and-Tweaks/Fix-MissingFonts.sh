#!/bin/bash

############################################################
# Download and install missing fonts
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Fix-MissingFonts.sh)"
#
############################################################

zypper in -y symbols-only-nerd-fonts google-noto-*

echo "[ INFORMATION ] Missing Fonts Installed"