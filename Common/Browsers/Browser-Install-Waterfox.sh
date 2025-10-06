#!/bin/bash

# Description: Installs the latest Waterfox Current release on Linux systems
# Author: Deepak
# License: MIT (or your preferred license)

set -euo pipefail

INSTALL_DIR="/opt/waterfox"
BIN_PATH="/usr/bin/waterfox"
DESKTOP_FILE="/usr/local/share/applications/waterfox.desktop"

LATEST_URL="https://cdn1.waterfox.net/waterfox/releases/latest/linux"

# Download and extract Waterfox
TMP_FILE=$(mktemp)
echo "Downloading Waterfox Current..."
curl -fsSL "$LATEST_URL" -o "$TMP_FILE" || { echo "Error: Download failed." >&2; exit 1; }

sudo mkdir -p "$INSTALL_DIR"
sudo tar xjf "$TMP_FILE" -C "$INSTALL_DIR" --strip-components=1 || {
    echo "Error: Extraction failed." >&2
    exit 1
}
rm -f "$TMP_FILE"

echo "Waterfox Current installed successfully in $INSTALL_DIR"

# Ensure executable is in PATH
if [[ ! -L "$BIN_PATH" ]]; then
    sudo ln -sf "$INSTALL_DIR/waterfox" "$BIN_PATH"
    echo "Created symbolic link: $BIN_PATH"
fi

# Create a desktop entry
sudo mkdir -p "$(dirname "$DESKTOP_FILE")"
echo "Creating desktop entry..."
echo "[Desktop Entry]
Version=1.0
Name=Waterfox Current
Comment=Browse the web with privacy and performance.
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=$BIN_PATH %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=$INSTALL_DIR/browser/chrome/icons/default/default128.png
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true" | sudo tee "$DESKTOP_FILE" > /dev/null

# Update desktop database
sudo update-desktop-database || echo "Warning: Failed to update desktop database."

echo "Waterfox Current installation completed successfully."
