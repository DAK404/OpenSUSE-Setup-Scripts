#!/bin/bash

############################################################
# System Utilities Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-SysUtilities.sh)"
#
############################################################

zypper install -y kdeconnect-kde fde-tools bleachbit libdbusmenu-glib4 p11-kit-server gnome-disk-utility gnome-keyring gnome-keyring-pam
