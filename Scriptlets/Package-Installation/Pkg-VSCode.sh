#!/bin/bash

############################################################
# Visual Studio Code Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-VSCode.sh)"
#
############################################################
VSCODE_REPO_URL='https://packages.microsoft.com/yumrepos/vscode'
zypper --gpg-auto-import-keys addrepo --refresh "$VSCODE_REPO_URL" 'vscode'
zypper --gpg-auto-import-keys refresh
zypper install -y code