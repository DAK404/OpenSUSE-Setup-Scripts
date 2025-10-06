#!/bin/bash

set -euo pipefail

INSTALL_DIR="/opt/waterfox"
BIN_PATH="/usr/bin/waterfox"
DESKTOP_FILE="/usr/local/share/applications/waterfox.desktop"

echo "Uninstalling Waterfox..."

# Remove desktop entry
if [[ -f "$DESKTOP_FILE" ]]; then
    sudo rm -f "$DESKTOP_FILE"
    echo "Removed desktop entry: $DESKTOP_FILE"
fi

# Remove symlink
if [[ -L "$BIN_PATH" ]]; then
    sudo rm -f "$BIN_PATH"
    echo "Removed symlink: $BIN_PATH"
fi

# Remove installation directory
if [[ -d "$INSTALL_DIR" ]]; then
    sudo rm -rf "$INSTALL_DIR"
    echo "Removed installation directory: $INSTALL_DIR"
fi

# Refresh desktop database if available
if command -v update-desktop-database &>/dev/null; then
    sudo update-desktop-database || echo "Warning: Failed to update desktop database."
fi

echo "Waterfox has been fully uninstalled."
