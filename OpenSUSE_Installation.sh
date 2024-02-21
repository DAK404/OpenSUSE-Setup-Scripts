#!/bin/bash

#first check for updates
sudo zypper dup -y

#install codecs
sudo zypper install -y opi
opi codecs

#install vscode and edge
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo --refresh https://packages.microsoft.com/yumrepos/edge microsoft-edge
sudo zypper addrepo --refresh https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper install -y microsoft-edge-stable
sudo zypper install -y code

#install github desktop
sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
sudo sh -c 'echo -e "[shiftkey-packages]\nname=GitHub Desktop\nbaseurl=https://rpm.packages.shiftkey.dev/rpm/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://rpm.packages.shiftkey.dev/gpg.key" > /etc/zypp/repos.d/shiftkey-packages.repo'
sudo zypper ref && sudo zypper in -y github-desktop

#install the essentials for consumer systems, comment out the ones that you might not need
sudo zypper in -y plymouth-plugin-script
sudo zypper in -y fde-tools
sudo zypper in -y kdeconnect-kde
sudo zypper in -y libdbusmenu-glib4
sudo zypper in -y kvantum-manager
sudo zypper in -y partitionmanager
sudo zypper in -y git
sudo zypper in -y discord
sudo zypper in -y libdiscord-rpc*
sudo zypper in -y bleachbit
sudo zypper in -y easyeffects

#install plymouth theme
sudo cp -r colorful /usr/share/plymouth/themes/
sudo plymouth-set-default-theme colorful -R

#make the theme folders and install GRUB theme
sudo mkdir -p /boot/misc/themes
sudo cp -r sayonara/* /boot/misc/themes

#install the easy effects presets
bash -c "$(curl -fsSL https://raw.githubusercontent.com/JackHack96/PulseEffects-Presets/master/install.sh)"

#install KDE theme
sh ./MacSonoma-kde-main/install.sh --round

#install fonts, place any TTF or OTF fonts in the folder
sudo cp *.ttf /usr/share/fonts/
sudo cp *.otf /usr/share/fonts/

#make .scripts directory in the /home directory and move the login tasks script there
mkdir ../.scripts
cp login_tasks.sh ../.scripts/

#cleanup
sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove --clean-deps > CleanupLog.txt
