#!/bin/bash

############################################################
# Alias Installation  Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Tweak-Aliases.sh)"
#
############################################################

echo "alias autoremove=\"sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | xargs -r sudo zypper remove -y --clean-deps >> ~/Cleanup.log\"" | tee -a /etc/bash.bashrc.local
