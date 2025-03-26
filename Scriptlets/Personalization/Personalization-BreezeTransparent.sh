#!/bin/bash

############################################################
# Personalization: Breeze Transparent Plasma Style
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Personalization/Personalization-BreezeTransparent.sh)"
#
############################################################

# Print information message
echo "[ INFORMATION ] Installing: Breeze Transparent Plasma Style"

# Download the Breeze Transparent Plasma Style (Thanks Gumbachi!)
curl -LJO https://github.com/Gumbachi/Breeze-Transparent/archive/refs/heads/main.zip

# Unzip the downloaded file
unzip ./Breeze-Transparent-main.zip

# Install the Plasma Style by copying it to the appropriate directory
cp -r ./Breeze-Transparent-main /usr/share/plasma/desktoptheme/

# Delete the extracted directory to save space
rm -rf ./Breeze-Transparent-main

# Delete the downloaded zip file to clean up
rm -rf ./Breeze-Transparent-main.zip