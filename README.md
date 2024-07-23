# OpenSUSE-Setup-Scripts

Description: A set of scripts to install essential software, utilities and tools after installing OpenSUSE Tumbleweed.

Version: 1.0 (19-July-2024)

---
## Introduction

This repository has a set of scripts that can be helpful for setting up OpenSUSE Tumbleweed fresh installs.

These are written for my configuration, therefore feel free to customize the list of items to be installed or changed.

[ ATTENTION ]

* The use of `opi` has now been removed.
The script needs to be automatic with least user intervention, and while using `opi` it downloads and installs latest updates from the Packman repository.
Updates from Packman may contain issues (personally, I have faced many), therefore, the use of Packman is restricted to the installation of codecs.
Therefore, `opi` has been removed. It will add the Packman repository, but will not install anything else other than the codecs.

* MacSonoma Theme by VinceLiuice is now autodownloaded and installed by the script. There is no requirement for the user to download it manually.

* I may also remove the installation logic for Sayonara theme for GRUB2 when systemd-boot becomes the default for Tumbleweed. But that may take quite some time so it will be up for the foreseeable future.

* It may not be the best to use Apple fonts (due to their licensing) therefore, I have switched to Liberation Sans (which is very similar to SF Pro fonts)
I will therefore be removing that as a prerequisite from now onwards

## Prerequisites

The script called `OpenSUSE_Installation.sh` requires a few extra items which can be downloaded from the web.

1. Sayonara + Improved Font GRUB theme: https://www.dropbox.com/s/il0dxjq5u65t0pt/Font.zip?dl=0&e=1
2. SF Pro TTF + OTF files: https://developer.apple.com/fonts/

NOTE: For the Sayonara theme, you might need to add your own image as a background, I haven't included mine. Theme may not work if the image is missing.

Once you download the files, you may need to set the permissions so that double clicking/single clicking it will execute it automatically. I have not done this because i want do do it via the command line manually.

## Script Priorities

It is recommended that the `OpenSUSE_Installation.sh` file is run first. If necessary the `GigabyteDesktop_Sleep_Fix.sh` should be run next. Next, run `OpenRGB.sh`.

It is possible for me to create a script to execute these serially, but I prefer to do them manually, since I would want to know and control what I install. Additionally, by writing a master script to execute everything may be disastrous since there are hardware specific configurations (like GigabyteDesktop_Sleep_Fix.sh) which may not work or worse, break your system. Therefore the scripts need to be manually installed by the user.

## OpenSUSE Installation

The OpenSUSE Installation script contains the following actions:

1. Check for updates and install them
2. Add Packman repository and install codecs
3. Add Microsoft repo and install Edge and VS Code
4. Add GitHub Desktop (Linux) and install it
5. Install components such as

    1. `fde-tools`: I use FDE for my installation

    2. `kdeconnect-kde`: I use KDE Connect in my installation

    3. `libdbusmenu-glib4`: Helps a few application menubar be visible in global menu (namely VS Code)

    4. `kvantum-manager`: Helps in theming the system components

    5. `partitionmanager`: KDE Partition Manager, useful to format USB drives

    6. `git`: I need git for all GitHub related stuff

    7. `discord` and `libdiscord-rpc`: Installs discord and Discord RPC library

    8. `bleachbit`: Helps in removing unwanted files in system. A useful tool

    9. `easyeffects`: Provides audio effects for speakers. Can improve sound quality
    
    10. `openrgb`: Provides control over RGB lighting of keyboards and peripherals

    11. `i2c-tools`: Helps in setting up configurations for the RGB lighting of peripherals
    
    12. `krita`: A powerful image editing tool
    
    13. `kdenlive`: A decent video editor
    
    14. `p11-kit-server`: Flatpak version of OBS have issues with certificates when using browser elements, therefore this can help fix it.

6. Install GRUB theme
7. Install EasyEffects presets; presets are required for the effects
8. Install fonts, if any
9. Add the `login_tasks.sh` script to the `.scripts` directory
10. Clean up any unneeded packages

## Login Tasks

These are tasks that I have setup on my system that shall run on every login.

Generally, VS Code shall have issues with the rendering of UI, due the GPU Cache not being cleared. This tasks shall clear the GPU caches therefore that problem shall never arise.

## Gigabyte Desktop Sleep Fix

A few Gigabyte models are affected by a BIOS bug which does not allow the system to sleep.

For more details on this, please check this reddit thread: https://www.reddit.com/r/gigabyte/comments/p5ewjn/b550i_pro_ax_f13_bios_sleep_issue_on_linux/?rdt=52322

Instead of manually doing the same tasks every setup, I have automated the process via this script file. You just need to run it once ONLY IF YOU FACE SLEEP ISSUES WITH YOUR GIGABYTE SYSTEMS!

To check if there are issues with your systems, attempt to put your system in sleep mode. If the computer immediately wakes up, this might help you.

## OpenRGB

This script shall help users to setup RGB peripheral lighting to work on Linux. A bit of configuration is required, therefore this script shall do it for you.

NOTE: This is only for AMD chipsets for now. For Intel users, please see the script file comments.
Also do check out the OpenRGB repository for more information: https://gitlab.com/CalcProgrammer1/OpenRGB#smbus-access-1

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

* Make sure you know what you're doing. I am not responsible for any damages or data loss. `sudo` commands are not meant to be used by everyone, so it is the responsibility of the person executing this script.

---
