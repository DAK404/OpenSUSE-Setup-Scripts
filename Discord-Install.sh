#!/bin/bash

############################################################
# Discord Install Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Discord-Install.sh)"
#
############################################################

# Ensure strict error handling
set -euo pipefail

DISCORD_URL="https://discord.com/api/download?platform=linux&format=tar.gz"
INSTALL_DIR="/opt/discord"
BIN_PATH="/usr/bin/discord"
DESKTOP_FILE="/usr/share/applications/discord.desktop"
TMP_DIR=$(mktemp -d)

# Ensure required dependencies are installed
deps=(curl tar zypper)
for dep in "${deps[@]}"; do
    if ! command -v "$dep" &> /dev/null; then
        echo "Error: $dep is not installed. Please install it and rerun the script." >&2
        exit 1
    fi
done

# Remove any existing Discord installation
if [[ -d "$INSTALL_DIR" ]]; then
    sudo rm -rf "$INSTALL_DIR"
    echo "Removed existing Discord installation."
fi

# Download and extract Discord
echo "Downloading Discord..."
curl -fsSL "$DISCORD_URL" -o "$TMP_DIR/discord.tar.gz" || {
    echo "Error: Download failed." >&2
    exit 1
}

tar -xzf "$TMP_DIR/discord.tar.gz" -C "$TMP_DIR" || {
    echo "Error: Extraction failed." >&2
    exit 1
}

sudo mv "$TMP_DIR/Discord" "$INSTALL_DIR"
rm -rf "$TMP_DIR"

echo "Discord installed successfully in $INSTALL_DIR"

# Ensure executable is in PATH
sudo ln -sf "$INSTALL_DIR/Discord" "$BIN_PATH"
echo "Created symbolic link: $BIN_PATH"

# Create a desktop entry
echo "Creating desktop entry..."
echo "[Desktop Entry]
Name=Discord
Comment=Discord - Chat for Communities and Friends
Exec=$BIN_PATH
Icon=$INSTALL_DIR/discord.png
Terminal=false
Type=Application
Categories=Network;InstantMessaging;" | sudo tee "$DESKTOP_FILE" > /dev/null

# Install required libraries
sudo zypper install -y --no-recommends libdiscord-rpc* || echo "Warning: Failed to install libdiscord-rpc."

echo "Discord installation completed successfully."
