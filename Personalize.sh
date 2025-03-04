#!/bin/bash

############################################################
# Personalization Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Personalize.sh)"
#
############################################################

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Kvantum Manager"
# Install Kvantum Manager & GTK theme requirements
sudo zypper in -y kvantum-manager gtk2-engine-murrine sassc

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: KDE & Kvantum Theme"
# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-kde/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-kde-main.zip
# Install the KDE and Kvantum theme for ALL users (remove sudo if you want to install to current user only)
sudo sh ./Colloid-kde-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-kde-main

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Colloid GTK Theme"
# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-gtk-theme/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-gtk-theme-main.zip
# Install the KDE and Kvantum theme
sudo sh ./Colloid-gtk-theme-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-gtk-theme-main

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Colloid Icon Theme"
# Download the Colloid Icon Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-icon-theme/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-icon-theme-main.zip
# Install the KDE and Kvantum theme
sudo sh ./Colloid-icon-theme-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-icon-theme-main

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Breeze Transparent Plasma Style"
# Download the Breeze Transparent Plasma Style (Thanks Gumbachi!)
curl -LJO https://github.com/Gumbachi/Breeze-Transparent/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Breeze-Transparent-main.zip
# Install the Plasma Style
sudo cp -r ./Breeze-Transparent-main /usr/share/plasma/desktoptheme/
# Delete the directory to save space
rm -rf ./Breeze-Transparent-main

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Posy's Cursor Set"
# Download the Posy's Cursor Set (Thanks Michel "Posy" de Boer and Simtrani for porting this to Linux!)
curl -LJO https://github.com/simtrami/posy-improved-cursor-linux/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./posy-improved-cursor-linux-main.zip
# Clean up unwanted directories and files
rm -rf ./posy-improved-cursor-linux-main/readme_files
rm -rf ./posy-improved-cursor-linux-main/README.md
# Install the cursor sets
sudo cp -r ./posy-improved-cursor-linux-main/* /usr/share/icons
# Delete the directory
rm -rf ./posy-improved-cursor-linux-main/

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Custom Wallpapers"
sudo cp ./custom-wallpapers/* /usr/share/wallpapers

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Sound Theme"
# Install the custom MacOcean theme (Ocean theme with the Mac startup sound)
sudo cp -r ./MacOcean /usr/share/sounds

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Login Task"
# Create directory '~/.scripts'
mkdir ~/.scripts
# Copy the login_tasks.sh file to '~/.scripts/' directory
cp login_tasks.sh ~/.scripts/

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Installing: Display ICM Profiles"
sudo cp ./color/*.icm /users/share/color

# ---------------------------------------------------------- #

echo "[ INFORMATION ] Cleaning Up ZIP Files"
# remove all zip files in the directory
rm -rf ./*.zip

# ---------------------------------------------------------- #
