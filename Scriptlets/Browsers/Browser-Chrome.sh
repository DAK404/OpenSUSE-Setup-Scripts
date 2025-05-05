#!/bin/bash

############################################################
# Google Chrome Browser Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Browsers/Browser-Chrome.sh)"
#
############################################################

rpm --import https://dl.google.com/linux/linux_signing_key.pub
zypper addrepo --refresh https://dl.google.com/linux/chrome/rpm/stable/x86_64 google-chrome
zypper --gpg-auto-import-keys refresh 
zypper install -y google-chrome-stable