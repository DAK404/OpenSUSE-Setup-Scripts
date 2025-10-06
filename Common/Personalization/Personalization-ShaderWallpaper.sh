#!/bin/bash

# Download the repository from GitHub (Thanks y4my4my4m!)
git clone https://github.com/y4my4my4m/kde-shader-wallpaper.git

# Remove any existing installation of Shader Wallpaper
rm -rf ~/.local/share/plasma/wallpapers/online.knowmad.shaderwallpaper/

# Install the shader wallpaper downloaded
kpackagetool6 -t Plasma/Wallpaper -i kde-shader-wallpaper/package

# Remove downloaded files
rm -rf kde-shader-wallpaper