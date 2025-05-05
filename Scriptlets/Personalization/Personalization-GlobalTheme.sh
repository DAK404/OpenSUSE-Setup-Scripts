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
echo "[ INFORMATION ] Installing: KDE & Kvantum Theme"

# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-kde/archive/refs/heads/main.zip

# Unzip the downloaded file
unzip ./Colloid-kde-main.zip

# Install the KDE and Kvantum theme for ALL users (remove if you want to install to current user only)
sh ./Colloid-kde-main/install.sh

# Delete the extracted directory to save space
rm -rf ./Colloid-kde-main

# ---------------------------------------------------------- #

# Print information message
echo "[ INFORMATION ] Installing: Colloid GTK Theme"

# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-gtk-theme/archive/refs/heads/main.zip

# Unzip the downloaded file
unzip ./Colloid-gtk-theme-main.zip

# Install the GTK theme
sh ./Colloid-gtk-theme-main/install.sh

# Delete the extracted directory to save space
rm -rf ./Colloid-gtk-theme-main

# ---------------------------------------------------------- #

# Print information message
echo "[ INFORMATION ] Installing: Colloid Icon Theme"

# Download the Colloid Icon Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-icon-theme/archive/refs/heads/main.zip

# Unzip the downloaded file
unzip ./Colloid-icon-theme-main.zip

# Install the icon theme
sh ./Colloid-icon-theme-main/install.sh

# Delete the extracted directory to save space
rm -rf ./Colloid-icon-theme-main

# ---------------------------------------------------------- #

# Print information message
echo "[ INFORMATION ] Cleaning Up ZIP Files"

# Remove all zip files in the directory to clean up
rm -rf ./*.zip

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Global Theme Installed"