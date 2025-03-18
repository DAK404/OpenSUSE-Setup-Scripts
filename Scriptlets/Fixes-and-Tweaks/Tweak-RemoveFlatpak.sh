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
zypper remove discover6 flatpak

# Remove the flatpak directories
rm -rf ~/.local/share/flatpak
rm -rf /etc/flatpak
rm -rf /var/lib/flatpak
