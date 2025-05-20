#!/bin/bash

####################################################################
# JetBrains Toolbox Installation Script for openSUSE
#
# Based on original script by: JanPokorny
# Modified and adapted by: wz790
# Reviewed by by: DAK404
#
# ⚠️ ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-JetBrainsToolbox.sh)"
#
####################################################################

# Exit immediately if a command exits with a non-zero status
set -e
set -o pipefail

# Define install paths
TMP_DIR="/tmp"
INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
SYMLINK_DIR="$HOME/.local/bin"

echo "### JETBRAINS TOOLBOX INSTALLATION STARTED ###"

echo -e "\e[94mFetching the latest JetBrains Toolbox download URL...\e[39m"
ARCHIVE_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' \
    | grep -Po '"linux":.*?[^\\]",' \
    | awk -F ':' '{print $3,":"$4}' \
    | sed 's/[", ]//g')
ARCHIVE_FILENAME=$(basename "$ARCHIVE_URL")

echo -e "\e[94mDownloading $ARCHIVE_FILENAME...\e[39m"
rm -f "$TMP_DIR/$ARCHIVE_FILENAME"
wget -q --show-progress -cO "$TMP_DIR/$ARCHIVE_FILENAME" "$ARCHIVE_URL"

echo -e "\e[94mExtracting toolbox to $INSTALL_DIR...\e[39m"
mkdir -p "$INSTALL_DIR"
rm -f "$INSTALL_DIR/jetbrains-toolbox"
tar -xzf "$TMP_DIR/$ARCHIVE_FILENAME" -C "$INSTALL_DIR" --strip-components=1
rm -f "$TMP_DIR/$ARCHIVE_FILENAME"
chmod +x "$INSTALL_DIR/jetbrains-toolbox"

echo -e "\e[94mCreating symlink in $SYMLINK_DIR...\e[39m"
mkdir -p "$SYMLINK_DIR"
rm -f "$SYMLINK_DIR/jetbrains-toolbox"
ln -s "$INSTALL_DIR/jetbrains-toolbox" "$SYMLINK_DIR/jetbrains-toolbox"

# Run the toolbox once unless in a CI environment
if [ -z "$CI" ]; then
    echo -e "\e[94mLaunching JetBrains Toolbox for initial setup...\e[39m"
    ("$INSTALL_DIR/jetbrains-toolbox" &)
    echo -e "\n\e[32mDone! JetBrains Toolbox should now be running.\n"
    echo -e "\e[32mYou can also run it using 'jetbrains-toolbox' in your terminal.\e[39m\n"
else
    echo -e "\n\e[32mDone! CI environment detected — skipping initial run.\e[39m\n"
fi
