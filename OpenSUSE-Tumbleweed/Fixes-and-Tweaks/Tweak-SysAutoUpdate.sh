#!/bin/bash

set -euo pipefail

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Set the script name
SCRIPT_NAME="SystemAutoUpdate.sh"

# Script content
SCRIPT_CONTENT='#!/bin/bash
zypper refresh
zypper dup -y
flatpak update -y'

# Script directory
SCRIPT_DIR="/usr/local/bin"

# Create the script file
tee "$SCRIPT_DIR/$SCRIPT_NAME" > /dev/null <<EOF
$SCRIPT_CONTENT
EOF
echo "Created script file: $SCRIPT_DIR/$SCRIPT_NAME"

# Make the script executable
chmod +x "$SCRIPT_DIR/$SCRIPT_NAME"
echo "Made script executable"

## TO DO: Call the script from Common