# OpenSUSE-Setup-Scripts
A set of useful scripts that can help in setting up and maintaining OpenSUSE Tumbleweed systems

---
## Introduction

This repository has a set of scripts that can be helpful for setting up OpenSUSE Tumbleweed fresh installs.

These are for my configurations, therefore feel free to customize the list of items to be installed or changed.

## Prerequisites

The script called `OpenSUSE_Installation.sh` requires a few extra items which can be downloaded from the web.

1. Colors Plymouth Theme: https://github.com/adi1090x/plymouth-themes
2. Sayonara + Improved Font GRUB theme: https://www.dropbox.com/s/il0dxjq5u65t0pt/Font.zip?dl=0&e=1
3. MacSonoma-KDE theme: https://github.com/vinceliuice/MacSonoma-kde
3. SF Pro TTF + OTF files: https://developer.apple.com/fonts/

NOTE: For the Sayonara theme, you might need to add your own image as a background, I haven't included mine. Theme may not work if the image is missing.

## OpenSUSE Installation

The OpenSUSE Installation script contains the following actions:

1. Check for updates and install them
2. Install `opi` and install codecs for media playback
3. Add Microsoft repo and install Edge and VS Code
4. Add GitHub Desktop (Linux) and install it
5. Install components such as

    1. `plymouth-plugin-script`: Some plymouth themes need this for it to work

    2. `fde-tools`: I use FDE for my installation

    3. `kdeconnect-kde`: I use KDE Connect in my installation

    4. `libdbusmenu-glib4`: Helps a few application menubar be visible in 
    global menu (namely VS Code)

    5. `kvantum-manager`: Helps in theming the system components

    6. `partitionmanager`: KDE Partition Manager, useful to format USB drives

    7. `git`: I need git for all GitHub related stuff

    8. `discord` and `libdiscord-rpc`: Installs discord and Discord RPC library

    9. `bleachbit`: Helps in removing unwanted files in system. A useful tool

    10. `easyeffects`: Provides audio effects for speakers. Can improve sound quality

6. Install Colors Plymouth theme
7. Install GRUB theme
8. Install EasyEffects presets; presets are required for the effects
9. Install fonts, if any
10. Add the `login_tasks.sh` script to the `.scripts` directory
11. Clean up any unneeded packages

## Login Tasks

These are tasks that I have setup on my system that shall run on every login.

Generally, VS Code and MS Edge shall have issues with the rendering of webpages and UI, due the GPU Cache not being cleared. This tasks shall clear the GPU caches therefore that problem shall never arise.

## Gigabyte Desktop Sleep Fix

A few Gigabyte models are affected by a BIOS bug which does not allow the system to sleep.

For more details on this, please check this reddit thread: https://www.reddit.com/r/gigabyte/comments/p5ewjn/b550i_pro_ax_f13_bios_sleep_issue_on_linux/?rdt=52322

Instead of manually doing the same tasks every setup, I have automated the process via this script file. You just need to run it once ONLY IF YOU FACE SLEEP ISSUES WITH YOUR GIGABYTE SYSTEMS!

To check if there are issues with your systems, attempt to put your system in sleep mode. If the computer immediately wakes up, this might help you.

## Usage

1. Download this repository

2. Extract the contents to `Downloads` directory

3. Download and extract the prerequisites into `Downloads` directory

4. Make any necessary modifications to the script file

5. If the script prompts for input, provide the same.

6. Once done, enjoy!

---

## Note

* You might need to modify the script to your needs, therefore, feel free to do so

* These scripts are tested on OpenSUSE Tumbleweed

* Make sure you know what you're doing. I am not responsible for any damages or data loss. `sudo` commands are not meant to be used by everyone, so it is the responsibility of the user, should they use this script.

---