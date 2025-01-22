#!/bin/bash

############################################################
# OpenSUSE Installation Script
#
# ----------------------------------------------------------
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/OpenSUSE_Installation.sh)"
#
# ----------------------------------------------------------
#
# --- CHANGELOG ---
#
# 1.8 (22-January-2025):
#    * Give options to end user to install codecs from
#      Packman, Main repositories, OPI and VLC Repository
#    * Fix the command to install system utilities
#    * Install package 'gamemode' while installing WINE
#      and Gaming Components.
#    * Added comments for clarity.
#
# 1.7 (06-January-2025):
#    * Disable the installation of Discord Linux client
#      NOTE: Please use the Discord-Install.sh script if
#      Packman is not added and enabled!
#    * Remove EasyEffects installation
#    * Modify installation of codecs
#
# 1.6 (12-November-2024):
#    * Add logic to install gaming software
#      (Steam, lutris, Wine, DXVK)
#    * Remove installation logic for Mozilla Thunderbird
#
# 1.5 (05-November-2024):
#    * Revert Edge repository to microsoft-edge
#      (Prevents repo duplication under different name)
#
# 1.4 (22-August-2024):
#    * Install codecs from the main repository
#    * Disable the addition of Packman and installation
#      of codecs from Packman repository
#    * NOTE: Please enable it if you want to use packages
#      from Packman!
# 
# 1.3 (01-August-2024):
#    * GPG keys are now auto imported with repository
#    * Add quotes to repo aliases
#    * Fix packman -> Packman
#    * Import keys for GitHub Desktop and Microsoft
#      since they caused errors for me.
#    * Move personalization commands to personalize.sh
#    * NOTE:
#      This script no longer has external dependencies,
#      therefore, like the EasyEffects installation,
#      this too can be done over the internet directly.
#    * Add '\n' to printf statement for autoremove alias
#
# 1.2 (28-July-2024):
#    * Add a new section to import repository keys first
#      and then install the necessary packages. Avoids
#      the script from erroring out and skip the packages
#      that requires installation.
#    * Move OpenRGB tools installation to OpenRGB.sh
#      (Makes more sense if the user does not want OpenRGB
#      to be installed on their system)
#    * Add '-y' flag to automate installation of 
#      GitHubDesktop and git
#    * Cleared up the logic to import the GitHub Desktop
#      repository and the GPG Key.
#
# 1.1 (23-July-2024):
#    * Add the VLC repository
#    * Make the script install VLC from the VideoLAN repos
#    * Add tags to echo statements to show the status of
#      an action.
#    * Disable font installation logic.
#    * Disable repository Packman after installation of
#      codecs. This will prevent vendor change to Packman.
#    * Reorder logic to check updates after importing keys
#      and adding relevant repositories.
#
# 1.0 (19-July-2024):
#    * Improve comments
#    * Add p11-kit-server
#    * Segregated each step of installation
#    * Fix the OpenRGB package name
#    * Automated Easyeffects preset installation
#    * echo each stage of script
############################################################

echo "--- OpenSUSE Installation Script ---"

# ---- ADD REPOSITORIES ---- #

echo "[ INFORMATION ] Adding Repository: Microsoft"
# Add Microsoft Repositories
sudo rpm --import 'https://packages.microsoft.com/keys/microsoft.asc'
sudo zypper --gpg-auto-import-keys addrepo --refresh 'https://packages.microsoft.com/yumrepos/edge' 'microsoft-edge'
sudo zypper --gpg-auto-import-keys addrepo --refresh 'https://packages.microsoft.com/yumrepos/vscode' 'Visual Studio Code'

echo "[ INFORMATION ] Adding Repository: GitHub"
# Add GitHub Desktop for Linux Repository
sudo rpm --import 'https://rpm.packages.shiftkey.dev/gpg.key'
sudo zypper --gpg-auto-import-keys addrepo --refresh 'https://rpm.packages.shiftkey.dev/rpm/' 'GitHub Desktop'

echo "[ INFORMATION ] Adding Repository: VLC"
# Add VLC Repository
sudo zypper --gpg-auto-import-keys addrepo --refresh 'https://download.videolan.org/pub/vlc/SuSE/Tumbleweed/' 'VLC'

# --- Install Codecs from Packman --- #

#echo "[ INFORMATION ] Adding Repository: Packman"
# Add OpenSUSE Packman repository
#sudo zypper --gpg-auto-import-keys addrepo --refresh 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' 'Packman'

echo "[ INFORMATION ] Refreshing Repositories; Importing GPG Keys..."
sudo zypper --gpg-auto-import-keys refresh

# echo "[  ATTENTION  ] Installing: Codecs"
# Install the codecs required for multimedia playback from the main repository
#
# Please comment/uncomment whichever is necessary
#
# Install Codecs from
# A) Packman
# B) OpenSUSE Main Repositories
# C) OPI
# D) VLC Repositories (RECOMMENDED)
#
# A) Packman Repository Codecs - Please ENABLE Packman repository above
# sudo zypper install -y --allow-vendor-change --from Packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs
#
# B) OpenSUSE Main Repository Codecs - Please DISABLE Packman repository above
# sudo zypper install -y ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs
#
# C) Codecs from OPI
# sudo zypper install -y opi
# opi codecs -n
#
# D) VLC Codecs installation is below.

# echo "[  ATTENTION  ] Disabling Packman Repository"
# Disable Packman repository
#
# sudo zypper mr -d Packman

# ---- INSTALL SOFTWARE ---- #

# Begin package installation

echo "[  ATTENTION  ] Installing: KDE Utilities"
# --- Install KDE Utilities --- #
sudo zypper install -y kdeconnect-kde krita kdenlive partitionmanager kvantum-manager

# --------- PLEASE UNCOMMENT WHEN USING PACKMAN ---------#
# echo "[  ATTENTION  ] Installing: Discord"
# --- Install Discord IM --- #
# sudo zypper install -y discord libdiscord-rpc*
# -------------------------------------------------------#

echo "[  ATTENTION  ] Installing: Microsoft Edge and VS Code"
# --- Install Microsoft Edge and VS Code --- #
sudo zypper install -y microsoft-edge-stable code

echo "[  ATTENTION  ] Installing: GitHub Desktop & Git"
# --- Install GitHub Desktop and Git --- #
sudo zypper install -y github-desktop git

echo "[  ATTENTION  ] Installing: System Utilities"
# --- Install System Level Utilities --- #
sudo zypper install -y fde-tools bleachbit libdbusmenu-glib4 p11-kit-server

echo "[  ATTENTION  ] Installing: WINE and Gaming Components"
# --- Install Gaming Software and Utilities --- #
sudo zypper install -y dxvk wine lutris steam gamemode

# --------- PLEASE COMMENT WHEN USING PACKMAN ---------#
echo "[  ATTENTION  ] Installing: VLC and Codecs"
# --- Install VLC from VideoLAN Repositories --- #
sudo zypper remove vlc
sudo zypper install ffmpeg gstreamer-plugins-{good,bad,ugly,libav}
latest_version=$(zypper search -s libavcodec | grep -Eo 'libavcodec[0-9]+' | sort -V | tail -1)
sudo zypper install --from VLC --allow-vendor-change vlc vlc-codecs x264 x265 $latest_version
# -----------------------------------------------------#

# Check for OpenSUSE Tumbleweed updates
echo "[ INFORMATION ] Checking for Updates..."
sudo zypper dup -y

# ---- CLEANUP ---- #

printf "[ INFORMATION ] Installing: \'autoremove\' command\n"
# Add "autoremove" command to remove any unneeded packages.
echo "alias autoremove=\"sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps >> ~/Cleanup.log\"" | sudo tee -a /etc/bash.bashrc.local

echo "[ INFORMATION ] Cleaning Up..."
# Run the command to autoremove packages
sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps >> ~/Cleanup.log

echo "End Of Script. It is recommended to reboot to apply changes."
