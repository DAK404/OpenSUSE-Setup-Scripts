#!/bin/bash

############################################################
# Warp Terminal Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-WarpTerminal.sh)"
#
############################################################

rpm --import https://releases.warp.dev/linux/keys/warp.asc
zypper addrepo https://releases.warp.dev/linux/rpm/stable warpdotdev
zypper install -y warp-terminal
