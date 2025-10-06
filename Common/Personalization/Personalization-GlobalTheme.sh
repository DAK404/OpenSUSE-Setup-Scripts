#!/bin/bash

############################################################
# Personalization: Global Theme Installation
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Personalization/Personalization-GlobalTheme.sh)"
#
############################################################

# ---------------------------------------------------------- #

# Print information message
echo "[ INFORMATION ] Installing: Kvantum Manager"

# Install Kvantum Manager & GTK theme requirements
zypper in -y kvantum-manager gtk2-engine-murrine sassc

# ---------------------------------------------------------- #

# Print information message
echo "[ INFORMATION ] Installing: MacTahoe KDE & Kvantum Theme"

# Download the MacTahoe KDE Theme using git clone (Thanks Vinceliuice!) See notes
git clone https://github.com/vinceliuice/MacTahoe-kde.git

# Install the theme system-wide using the provided installer
bash ./MacTahoe-kde/install.sh

# Delete the extracted directory to save space
rm -rf ./MacTahoe-kde

# ---------------------------------------------------------- #

# Print information message
echo "[ INFORMATION ] Installing: MacTahoe GTK Theme"

# Download the MacTahoe GTK Theme using git clone (Thanks Vinceliuice!) See notes
git clone https://github.com/vinceliuice/MacTahoe-gtk-theme.git

# Install the theme using the provided installer
bash ./MacTahoe-gtk-theme/install.sh

# Delete the extracted directory to save space
rm -rf ./MacTahoe-gtk-theme

# ---------------------------------------------------------- #

# Print information message
echo "[ INFORMATION ] Installing: MacTahoe Icon Theme"

# Download the MacTahoe KDE Theme using git clone (Thanks Vinceliuice!) See notes
git clone https://github.com/vinceliuice/MacTahoe-icon-theme.git

# Install the theme using the provided installer
bash ./MacTahoe-icon-theme/install.sh

# Delete the extracted directory to save space
rm -rf ./MacTahoe-icon-theme

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Global Theme Installed"

##############################################################
# NOTES
#
# TL;DR: DO NOT USE CURL OR WGET TO DOWNLOAD THE REPO AND TO
# INSTALL THE THEMES. THAT PROCESS DOES NOT WORK RELIABLY!
#
# Please see the below discussion for the same:
# https://github.com/vinceliuice/MacTahoe-icon-theme/issues/14
#
# ------------------------------------------------------------
#
# Switched from curl to git clone because a few themes do not
# work well when downloading it as a zip file. These issues
# are not found when the repo is cloned then installed. This
# switch in logic also helps in reducing the overall file 
# sizes and avoids downloading a zip file, installing the 
# theme and then removing it.
#
##############################################################