#!/bin/bash

############################################################
# Personalization Script
#
# --- CHANGELOG ---
#
# 1.1 (14-August-2024):
#    * Remove MacSonoma theme
#    * Add Colloid Kvantum and GTK themes
#      (This is done so that the UI looks consistent)
#
# 1.0 (02-August-2024):
#    * Initial Commit
############################################################

echo "[ INFORMATION ] Installing: Kvantum Manager"
# Install Kvantum Manager & GTK theme requirements
sudo zypper in -y kvantum-manager gtk2-engine-murrine sassc

echo "[ INFORMATION ] Installing: KDE & Kvantum Theme"
# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-kde/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-kde-main.zip
# Install the KDE and Kvantum theme for ALL users (remove sudo if you want to install to current user only)
sudo sh ./Colloid-kde-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-kde-main
# Delete the zip file too
rm Colloid-kde-main.zip

echo "[ INFORMATION ] Installing: Colloid GTK Theme"
# Download the Colloid Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-gtk-theme/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-gtk-theme-main.zip
# Install the KDE and Kvantum theme
sudo sh ./Colloid-gtk-theme-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-gtk-theme-main
# Delete the zip file too
rm Colloid-gtk-theme-main.zip

echo "[ INFORMATION ] Installing: Colloid Icon Theme"
# Download the Colloid Icon Theme (Thanks Vinceliuice!)
curl -LJO https://github.com/vinceliuice/Colloid-icon-theme/archive/refs/heads/main.zip
# Unzip the dowloaded file
unzip ./Colloid-icon-theme-main.zip
# Install the KDE and Kvantum theme
sudo sh ./Colloid-icon-theme-main/install.sh
# Delete the directory to save space
rm -rf ./Colloid-icon-theme-main
# Delete the zip file too
rm Colloid-icon-theme-main.zip


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

