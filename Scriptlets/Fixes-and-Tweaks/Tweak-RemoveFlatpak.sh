#!/bin/bash

############################################################
# Flatpak Removal Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Tweak-RemoveFlatpak.sh)"
#
############################################################

# Remove flatpak and KDE Plasma Discover store
zypper remove discover6 flatpak

# Remove the flatpak directories
rm -rf ~/.local/share/flatpak
rm -rf /etc/flatpak
rm -rf /var/lib/flatpak
