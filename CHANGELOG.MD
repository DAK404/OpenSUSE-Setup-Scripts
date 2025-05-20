# Changelog

This is the changelog since version 2.0.0. Each section contains divisions for each addition, modification and deletion. Please go through the commits to find specific versions of the script.

# Table of Contents
- [Changelog](#changelog)
- [Table of Contents](#table-of-contents)
  - [2.1.1](#211)
    - [Additions](#additions)
    - [Modifications](#modifications)
    - [Deletions](#deletions)
  - [2.1.0](#210)
    - [Additions](#additions)
    - [Modifications](#modifications)
    - [Deletions](#deletions)
  - [2.0.2](#202)
    - [Additions](#additions-1)
    - [Modifications](#modifications-1)
    - [Deletions](#deletions-1)
  - [2.0.1](#201)
    - [Additions](#additions-2)
    - [Modifications](#modifications-2)
  - [2.0.0](#200)
    - [Additions](#additions-3)
    - [Modifications](#modifications-3)
    - [Deletions](#deletions-2)

---

## 2.1.1

### Additions

* Added JetBrains Toolbox installation Script

### Modifications

* Updated the documentation

### Deletions

## 2.1.0

### Additions

* Added a Guided Installation option
* Added Tweak to configure firewall rules for mDNS
* Added a help file to help users understand the script features
+ Added Google Chrome, Brave, MS Edge and Zen Browser installation scripts
+ Added option to install codecs from Packman Essentials
+ Added a fix to turn on NumLock in SDDM
+ Added a fix to download and install the `google-noto` font for all languages (essentially, websites and apps are not broken)
+ Added a fix to install ICM profiles for your monitors
+ Added script for package installation to download and install Warp Terminal (https://warp.dev)
+ Added script to add a systemd service and timer to perform system updates on every 1st day of the month

### Modifications

* Added Filelight to be included in SysUtilities
* All steps of the installation are independent scripts
* All scripts are structured inside directories based on actions
* Updated the documentation

### Deletions

- Removed `message_logger()` function in the install scripts (Will reintroduce it once the scriptlets are improved)
- Removed Discord installation script since Flatpak is official (plus discord media will not be broken due to codecs)
- Removed `login_tasks.sh` (will be back soon)

## 2.0.2

### Additions

+ Added Zen Browser Install scripts
+ Added logic to install ICM profiles inside the `colors` directory

### Modifications

* Added function to install Zen Browser to be installed from the `OpenSUSE_Installation.sh` script
* Fixed a typo.
* Optimized `Discord-Install.sh` script code with strict error handling, dependency checks, safer temporary directory handling, and improved logging
* Removed `:` for each version in `CHANGELOG.MD` file
* Updated `README.md` files

### Deletions

- Removed code for installing Microsoft Edges


## 2.0.1

### Additions

+ Added the CHANGELOG file

### Modifications

* Function Nomenclature: Changed functions to have only underscores
* Added `-y` to automate the installation to a few commands
* Modified Discord-Install script to not install discord by using the `--no-recommends` option

## 2.0.0

### Additions

+ Message Logger: Log messages while performing setup
+ Check Internet Connection: Checks for internet connection when running the script
+ Functions: Added functions for each step making it easy to read and modify code
+ Multiple Sources For Codecs Installation: Provided multiple sources to install codecs from
+ Run Scriptlets: Ability to run scriptlets from the main scripts
+ Argument Processing: Ability to customize an installation by using arguments
+ Log File: Script statuses are saved to log file for future reference
+ More Repositories: Added Games repository

### Modifications

* VLC Installation: Existing VLC versions are removed before installing the ones from the official website
* Software installation happens only if an internet connection can be established

### Deletions

- Check For Updates: Script does not check for updates using `zypper dup`
