#!/bin/bash

############################################################
# Discord Installation Script
#
# ----------------------------------------------------------
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Discord-Install.sh)"
#
# ----------------------------------------------------------
#
# 1.0 (04-January-2025):
#    * Initial Commit
############################################################

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "curl is not installed. Please install it and run the script again."
  exit 1
fi

# Check if tar is installed
if ! command -v tar &> /dev/null; then
  echo "tar is not installed. Please install it and run the script again."
  exit 1
fi

# Define the URL for the latest Discord .tar.gz release
DISCORD_URL="https://discord.com/api/download?platform=linux&format=tar.gz"

# Define the target directory for downloading and extracting Discord
TARGET_DIR="/tmp/discord"

# Install Discord RPC library
sudo zypper install -y libdiscord-rpc*

# Remove any existing Discord installation
sudo rm -rf /opt/discord

# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Download the latest Discord .tar.gz release to the target directory
curl -L -o "$TARGET_DIR/discord.tar.gz" "$DISCORD_URL"

# Extract the downloaded .tar.gz file
tar -xzf "$TARGET_DIR/discord.tar.gz" -C "$TARGET_DIR"

# Move the extracted files to the /opt directory
sudo mv "$TARGET_DIR/Discord" /opt/discord

# Create a symbolic link to the Discord executable in /usr/bin
sudo ln -sf /opt/discord/Discord /usr/bin/discord

# Clean up the target directory
rm -rf "$TARGET_DIR"

# Create a desktop entry for Discord
cat <<EOF | sudo tee /usr/share/applications/discord.desktop
[Desktop Entry]
Name=Discord
Comment=Discord - Chat for Communities and Friends
Exec=/usr/bin/discord
Icon=/opt/discord/discord.png
Terminal=false
Type=Application
Categories=Network;InstantMessaging;
EOF

echo "Discord installation completed!"
