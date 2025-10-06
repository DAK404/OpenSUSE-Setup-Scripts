#!/bin/bash

# Print information message
echo "[ INFORMATION ] Installing: Breeze Transparent Plasma Style"

# Download the Breeze Transparent Plasma Style (Thanks Gumbachi!)
git clone https://github.com/Gumbachi/Breeze-Transparent.git

# Install the Plasma Style by copying it to the appropriate directory
cp -r ./Breeze-Transparent /usr/share/plasma/desktoptheme/

# Delete the extracted directory to save space
rm -rf ./Breeze-Transparent

echo "[ INFORMATION ] Breeze Transparent Plasma Style Installed"