#!/bin/bash

############################################################
# Zen Browser Install Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Zen-Browser-Install.sh)"
#
############################################################

#!/bin/bash

set -euo pipefail  # Ensure strict error handling

REPO_OWNER="zen-browser"
REPO_NAME="desktop"
INSTALL_DIR="/opt/zen"
BIN_PATH="/usr/bin/zen"
DESKTOP_FILE="/usr/local/share/applications/zen-browser.desktop"

# Fetch the latest release information
LATEST_URL=$(curl -fsSL "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest" |
    grep -oP '"browser_download_url": "\K(.*zen\.linux-x86_64\.tar\.xz)(?=")')

if [[ -z "$LATEST_URL" ]]; then
    echo "Error: Failed to retrieve the latest release URL." >&2
    exit 1
fi

# Download and extract Zen Browser
TMP_FILE=$(mktemp)
echo "Downloading Zen Browser..."
curl -fsSL "$LATEST_URL" -o "$TMP_FILE" || { echo "Error: Download failed." >&2; exit 1; }

sudo mkdir -p "$INSTALL_DIR"
sudo tar xJf "$TMP_FILE" -C "$INSTALL_DIR" --strip-components=1 || {
    echo "Error: Extraction failed." >&2
    exit 1
}
rm -f "$TMP_FILE"

echo "Zen Browser installed successfully in $INSTALL_DIR"

# Ensure executable is in PATH
if [[ ! -L "$BIN_PATH" ]]; then
    sudo ln -sf "$INSTALL_DIR/zen" "$BIN_PATH"
    echo "Created symbolic link: $BIN_PATH"
fi

# Create a desktop entry
sudo mkdir -p "$(dirname "$DESKTOP_FILE")"
echo "Creating desktop entry..."
echo "[Desktop Entry]
Version=1.0
Name=Zen Browser
Comment=Experience tranquillity while browsing the web without people tracking you!
GenericName=Web Browser
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=$BIN_PATH
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=$INSTALL_DIR/browser/chrome/icons/default/default128.png
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true" | sudo tee "$DESKTOP_FILE" > /dev/null

# Update desktop database
sudo update-desktop-database || echo "Warning: Failed to update desktop database."

echo "Zen Browser installation completed successfully."