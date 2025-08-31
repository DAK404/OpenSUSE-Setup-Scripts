#!/bin/bash

############################################################
# Personalization: Breeze Transparent Plasma Style
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Personalization/Personalization-PosysCursors.sh)"
#
############################################################

# Print information message
echo "[ INFORMATION ] Installing: Posy's Cursor Set"

# Download the Posy's Cursor Set (Thanks Michel "Posy" de Boer and Simtrani for porting this to Linux!)
git clone https://github.com/simtrami/posy-improved-cursor-linux.git

# Clean up unwanted directories and files
rm -rf ./posy-improved-cursor-linux/readme_files
rm -rf ./posy-improved-cursor-linux/README.md

# Install the cursor sets by copying them to the appropriate directory
cp -r ./posy-improved-cursor-linux/* /usr/share/icons

# Delete the extracted directory to save space
rm -rf ./posy-improved-cursor-linux

echo "[ INFORMATION ] Posy's Cursor Set Installed"