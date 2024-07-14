#!/bin/bash

# Check for OpenSUSE Tumbleweed updates
sudo zypper dup -y

# ---- ADD REPOSITORIES ---- #

# Add OpenSUSE Packman repository
sudo zypper addrepo --refresh 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman

# Add Microsoft Repositories
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo --refresh 'https://packages.microsoft.com/yumrepos/edge' microsoft-edge
sudo zypper addrepo --refresh 'https://packages.microsoft.com/yumrepos/vscode' vscode

# Add GitHub Desktop for Linux Repository
sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'

# ---- INSTALL SOFTWARE ---- #

# Refresh all repositories
sudo zypper refresh

# Installing the codecs separately to avoid updating other packages
# Install the codecs required for multimedia playback
#
# NOTE: Not using opi here since it will switch ALL packages that exist in the Packman repository to use Packman.
# We manually specify Packman repository and the codecs that need to be installed by the system
sudo zypper install -y --allow-vendor-change --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs

# Refresh the repositories
sudo zypper refresh
# Begin package installation
sudo zypper install -y openrgb i2c-tools fde-tools kdeconnect-kde discord libdiscord-rpc* bleachbit easyeffects libdbusmenu-glib4 git kvantum-manager partitionmanager microsoft-edge-stable code github-desktop MozillaThunderbird krita kdenlive

# ---- INSTALL EXTRAS ---- #

# Install GRUB Theme
sudo mkdir -p /boot/misc/themes
sudo cp -r sayonara/* /boot/misc/themes

# Copy the wallpapers over to the system wallpapers directory
sudo cp ./custom-wallpapers/* /usr/share/wallpapers

# Install fonts
sudo cp ./Fonts/*.ttf /usr/share/fonts/
sudo cp ./Fonts/*.otf /usr/share/fonts/

# Install EasyEffects presets
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"

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

# Create '.scripts' directory in the user home directory and move the login tasks script there
mkdir ~/.scripts
cp login_tasks.sh ~/.scripts/

# Install the custom MacOcean theme (Ocean theme with the Mac startup sound)
sudo cp -r ./MacOcean /usr/share/sounds

# ---- CLEANUP ---- #

# Add "autoremove" command to remove any unneeded packages.
echo "alias autoremove=\"sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps >> ~/Cleanup.log\"" | sudo tee -a /etc/bash.bashrc.local
# Run the command to autoremove packages
sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps
