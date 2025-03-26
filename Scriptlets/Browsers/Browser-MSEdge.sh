#!/bin/bash

############################################################
# Microsoft Edge Browser Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Browsers/Browser-MSEdge.sh)"
#
############################################################

MSEDGE_REPO_URL='https://packages.microsoft.com/yumrepos/edge'
zypper --gpg-auto-import-keys addrepo --refresh "$MSEDGE_REPO_URL" 'microsoft-edge'
zypper --gpg-auto-import-keys refresh
zypper install -y microsoft-edge-stable