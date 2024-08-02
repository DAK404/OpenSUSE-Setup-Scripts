#!/bin/bash

############################################################
# Personalization Script
#
# --- CHANGELOG ---
#
# 1.0 (02-August-2024):
#    * Initial Commit
############################################################

echo "[ INFORMATION ] Installing: Kvantum Manager"
# Install Kvantum Manager
sudo zypper in -y kvantum-manager kvantum-themes

echo "[ INFORMATION ] Installing: KDE & Kvantum Theme"
# Download the MacSonoma Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/MacSonoma-kde/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./MacSonoma-kde-main.zip
# Install the KDE and Kvantum theme
sh ./MacSonoma-kde-main/install.sh
# Delete the directory to save space
rm -r ./MacSonoma-kde-main
# Delete the zip file too
rm MacSonoma-kde-main.zip

echo "[ INFORMATION ] Installing: Custom Wallpapers"
sudo cp ./custom-wallpapers/* /usr/share/wallpapers

echo "[ INFORMATION ] Installing: Sound Theme"
# Install the custom MacOcean theme (Ocean theme with the Mac startup sound)
sudo cp -r ./MacOcean /usr/share/sounds

echo "[ INFORMATION ] Installing: Login Task"
# Create directory '~/.scripts'
mkdir ~/.scripts
# Copy the login_tasks.sh file to '~/.scripts/' directory
cp login_tasks.sh ~/.scripts/

