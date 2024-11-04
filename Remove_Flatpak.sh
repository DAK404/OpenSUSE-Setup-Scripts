#!/bin/bash

############################################################
# Flatpak Removal Script
#
# --- CHANGELOG ---
#
# 1.0 (05-November-2024):
#    * Initial Commit
############################################################

# Remove flatpak and KDE Plasma Discover store
sudo zypper remove discover6 flatpak

# Remove the flatpak directories
sudo rm -rf ~/.local/share/flatpak
sudo rm -rf /etc/flatpak
sudo rm -rf /var/lib/flatpak
