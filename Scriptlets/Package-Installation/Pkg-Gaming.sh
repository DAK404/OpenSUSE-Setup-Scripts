#!/bin/bash

############################################################
# Gaming Packages Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-Gaming.sh)"
#
############################################################

zypper install -y dxvk wine lutris steam gamemode gamescope

flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.obsproject.Studio
flatpak install -y flathub org.freedesktop.Platform.GStreamer.gstreamer-vaapi
flatpak install -y flathub com.obsproject.Studio.Plugin.VkCapture