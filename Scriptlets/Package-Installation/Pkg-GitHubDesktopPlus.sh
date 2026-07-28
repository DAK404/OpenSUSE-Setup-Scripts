#!/bin/bash

############################################################
# GitHub Desktop Plus Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-GitHubDesktopPlus.sh)"
#
############################################################

sudo rpm --import https://gpg.desktop-plus.org/public.key
echo -e "[desktop-plus]\nname=Desktop Plus\nbaseurl=https://rpm.desktop-plus.org/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gpg.desktop-plus.org/public.key" | sudo tee /etc/zypp/repos.d/desktop-plus.repo
sudo zypper refresh
sudo zypper install desktop-plus
