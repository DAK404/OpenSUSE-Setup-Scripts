#!/bin/bash

############################################################
# GitHub Desktop Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Package-Installation/Pkg-GitHubDesktop.sh)"
#
############################################################

GITHUB_GPG_KEY_URL='https://mirror.mwt.me/shiftkey-desktop/gpgkey'
GITHUB_REPO_URL='https://mirror.mwt.me/shiftkey-desktop/rpm'
zypper --gpg-auto-import-keys addrepo --refresh "$GITHUB_REPO_URL" 'GitHub Desktop'
zypper install -y github-desktop git