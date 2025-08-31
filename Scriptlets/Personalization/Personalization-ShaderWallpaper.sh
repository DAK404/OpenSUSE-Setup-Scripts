#!/bin/bash

############################################################
# Personalization: Shader Wallpaer Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Personalization/Personalization-ShaderWallpaper.sh)"
#
############################################################

# Download the repository from GitHub (Thanks y4my4my4m!)
git clone https://github.com/y4my4my4m/kde-shader-wallpaper.git

# Remove any existing installation of Shader Wallpaper
rm -rf ~/.local/share/plasma/wallpapers/online.knowmad.shaderwallpaper/

# Install the shader wallpaper downloaded
kpackagetool6 -t Plasma/Wallpaper -i kde-shader-wallpaper/package

# Remove downloaded files
rm -rf kde-shader-wallpaper