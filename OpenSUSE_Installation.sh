#!/bin/bash

############################################################
# OpenSUSE Installation Script
# Version 1.0
# Date Modified: 19-July-2024
#
# --- CHANGELOG ---
#
# 1.0 (19-July-2024):
#    * Improve comments
#    * Add p11-kit-server
#    * Segregated each step of installation
#    * Fix the OpenRGB package name
#    * Automated Easyeffects preset installation
#    * echo each stage of script
############################################################

echo "OpenSUSE Installation Script"

# --- CHECK FOR UPDATES --- #

# Check for OpenSUSE Tumbleweed updates
echo "Checking for Updates..."
sudo zypper dup -y

# ---- ADD REPOSITORIES ---- #

echo "Adding Repository: Packman"
# Add OpenSUSE Packman repository
sudo zypper addrepo --refresh 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman

echo "Adding Repository: Microsoft"
# Add Microsoft Repositories
sudo rpm --import 'https://packages.microsoft.com/keys/microsoft.asc'
sudo zypper addrepo --refresh 'https://packages.microsoft.com/yumrepos/edge' microsoft-edge
sudo zypper addrepo --refresh 'https://packages.microsoft.com/yumrepos/vscode' vscode

echo "Adding Repository: GitHub"
# Add GitHub Desktop for Linux Repository
sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'

# ---- INSTALL SOFTWARE ---- #

echo "Refreshing ALL Repositories..."
# Refresh all repositories
sudo zypper refresh

# Begin package installation

# --- Install Codecs from Packman --- #

echo "Installing: Codecs"
# Install the codecs required for multimedia playback
#
# NOTE: Not using opi here since it will switch ALL packages that exist in the Packman repository to use Packman.
# We manually specify to install codecs from Packman repository so all other programs are not switched to Packman.
sudo zypper install -y --allow-vendor-change --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs

echo "Installing: OpenRGB & Utilities"
# --- Install OpenRGB Tools --- #
sudo zypper install -y OpenRGB i2c-tools

echo "Installing: KDE Utilities"
# --- Install KDE Utilities --- #
sudo zypper install -y kdeconnect-kde krita kdenlive partitionmanager kvantum-manager

echo "Installing: Discord"
# --- Install Discord IM --- #
sudo zypper install -y discord libdiscord-rpc*

echo "Installing: Microsoft Edge and VS Code"
# --- Install Microsoft Edge and VS Code --- #
sudo zypper install -y microsoft-edge-stable code

echo "Installing: GitHub Desktop & Git"
# --- Install GitHub Desktop and Git --- #
sudo zypper install github-desktop git

echo "Installing: System Utilities"
# --- Install System Level Utilities --- #
sudo zypper install -y fde-tools bleachbit easyeffects libdbusmenu-glib4 MozillaThunderbird p11-kit-server


# ---- INSTALL FONTS AND THEMES ---- #

echo "Installing: GRUB2 Theme"
# Install GRUB Theme
sudo mkdir -p /boot/misc/themes
sudo cp -r sayonara/* /boot/misc/themes

echo "Installing: Custom Wallpapers"
# Copy the wallpapers over to the system wallpapers directory
sudo cp ./custom-wallpapers/* /usr/share/wallpapers

echo "Installing: Fonts"
# Install fonts
sudo cp ./Fonts/*.ttf /usr/share/fonts/
sudo cp ./Fonts/*.otf /usr/share/fonts/

echo "Installing: EasyEffects Presets"
# Install EasyEffects presets
echo 1 | bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"

echo "Installing: KDE & Kvantum Theme"
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

echo "Installing: Login Scripts"
# Create '.scripts' directory in the user home directory and move the login tasks script there
mkdir ~/.scripts
cp login_tasks.sh ~/.scripts/

echo "Installing: Sound Theme"
# Install the custom MacOcean theme (Ocean theme with the Mac startup sound)
sudo cp -r ./MacOcean /usr/share/sounds

# ---- CLEANUP ---- #

echo "Installing: \'autoremove\' command"
# Add "autoremove" command to remove any unneeded packages.
echo "alias autoremove=\"sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps >> ~/Cleanup.log\"" | sudo tee -a /etc/bash.bashrc.local

echo "Cleaning Up..."
# Run the command to autoremove packages
sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps >> ~/Cleanup.log

echo "End Of Script. It is recommended to reboot to apply changes."
