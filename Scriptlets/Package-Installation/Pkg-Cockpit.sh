#!/bin/bash

############################################################
# Cockpit Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-Cockpit.sh)"
#
############################################################

# Install Cockpit and Myrlyn packages
zypper in cockpit myrlyn

# Enable cockpit
systemctl enable --now cockpit.socket

# Add Cockpit to the firewall to be able to access the tool
sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload

echo "Now, go to https://localhost:9090 to access Cockpit"