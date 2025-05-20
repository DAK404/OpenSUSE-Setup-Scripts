# OpenSUSE Tumbleweed Setup Scripts

**Now with improved code in version 2.1.1 and beyond!**

This is a set of scripts that can help in configuring and setting up repositories, codecs, packages and configure applications or systems for daily use.

Further, this can be used to configure OpenSUSE Tumbleweed on multiple systems quickly by just using a shell script.

Please note that the `Testing` branch is always ahead of the `main` branch. Therefore, there may be differences. If in doubt, please use the scripts in the main branch. The testing branch is used for testing.

## Table of Contents

- [OpenSUSE Tumbleweed Setup Scripts](#opensuse-tumbleweed-setup-scripts)
  - [Table of Contents](#table-of-contents)
  - [IMPORTANT](#important)
  - [Quick Run](#quick-run)
  - [Arguments](#arguments)
  - [I Need More Information!](#i-need-more-information)
  - [DISCLAIMER!](#disclaimer)

## IMPORTANT

I would like to highlight 2 of the forks that is significant.

1. N Shamsi's Fork: [https://github.com/n-shamsi/OpenSUSE-Setup-Scripts](https://github.com/n-shamsi/OpenSUSE-Setup-Scripts) - This is a modified version of the scripts for OpenSUSE Leap versions.
2. Percy Panelo's Fork: [https://github.com/PercyPanleo/OpenSUSE-Setup-Scripts](https://github.com/PercyPanleo/OpenSUSE-Setup-Scripts) - This contains an alternative fix for Gigabyte sleep issues. If the version provided does not work as expected, please use Percy Panelo's version.

A big thank you to you both for contributing to this project!

## Quick Run

For normal users, you may run this command:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/OpenSUSE_Installation.sh)"
```

This will bring up a CLI menu based installer to know what to install.

Please see [Arguments](README.MD#arguments) for more options.

## Arguments

The `OpenSUSE-Installation.sh` script may require a few arguments as per your use-case or needs. The following arguments and the description of each is as follows:

| Type            | Argument                  | Description                                                |
| --------------- | ------------------------- | ---------------------------------------------------------- |
| Browser         | Browser-Brave             | Installs the Brave Browser                                 |
| Browser         | Browser-Chrome            | Installs the Google Chrome Browser                         |
| Browser         | Browser-MSEdge            | Installs the Microsoft Edge Browser                        |
| Browser         | Browser-Zen               | Installs the Zen Browser                                   |
| Codecs          | Codecs-packman-essentials | Installs codecs from Packman Essential repository          |
| Codecs          | Codecs-opi                | Installs OPI and codecs from OPI                           |
| Codecs          | Codecs-main               | Installs codecs from Repository Main (OSS)                 |
| Fix             | GigabyteDesktopSleepFix   | Fixes issues with Gigabyte systems that do not go to sleep |
| Fix             | ICMProfiles               | Installs ICM profiles                                      |
| Fix             | MissingFonts              | Installs Missing Fonts (Google Noto fonts pack)            |
| Fix             | SDDMNumLock               | Enables NumLock on boot to SDDM                            |
| Tweak           | Aliases                   | Installs useful aliases to the system                      |
| Tweak           | mDNSFirewallRules         | Adds mDNS to public and external zones in the firewall     |
| Tweak           | OpenRGB                   | Installs and sets up openRGB                               |
| Tweak           | SysAutoUpdate             | Adds service to update system on 1st day of every month    |
| Pkg             | Gaming                    | Installs Gaming components to the system                   |
| Pkg             | GitHubDesktop             | Installs GitHub Desktop and Git                            |
| Pkg             | SysUtilities              | Installs Essential System Utilities                        |
| Pkg             | VSCode                    | Installs Visual Studio Code                                |
| Pkg             | JetBrains Toolbox         | Installs JetBrains Toolbox                                 |
| Pkg             | WarpTerminal              | Installs Warp Terminal (warp.dev)                          |
| Personalization | BreezeTransparent         | Installs Breeze Transparent Plasma Style                   |
| Personalization | GlobalTheme               | Installs Colloid KDE Plasma, GTK and Icon themes           |
| Personalization | PosysCursors              | Installs Posy's Cursors                                    |


For using the arguments, use the following syntax:

```bash
Type1=Option1,Option2,Option3... Type2=Option1,Option2,Option3...
```
Example:

```bash
Browser=Brave Codecs=opi Fix=SDDMNumLock,ICMProfiles
```

You may run individual scripts by the following command (replace the `<SCRIPT_NAME>` with a valid script file name):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/<SCRIPT_NAME>.sh)"
```

## I Need More Information!

Please check the [GitHub Wiki](https://github.com/DAK404/OpenSUSE-Setup-Scripts/wiki) to learn more about the project.

If you are looking for the older scripts, please check the [Legacy Branch](https://github.com/DAK404/OpenSUSE-Setup-Scripts/tree/Legacy). However, these scripts will not be maintained anymore, since the scripts in version `2.0.0` are better in all aspects.

## DISCLAIMER!

**Use at Your Own Risk**

This script is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

**Before You Run the Script**

1. **Backup Your Data**: Always perform a full backup of your system and important files before running any script that modifies your system.
2. **Understand the Script**: Read through the script carefully to understand what it does. Ensure that it meets your specific requirements and that you trust it to interact with your system.
3. **Test Environment**: If possible, test the script in a virtual machine or a non-production environment first to avoid any unintended consequences.
4. **Dependencies**: Make sure that all dependencies and required software are installed on your system before running the script. This includes any necessary packages, libraries, or external tools.

**Liability**

By using this script, you acknowledge and agree that the authors shall not be held responsible for any damage or loss of data that may occur as a result of using the script. You are solely responsible for the consequences of running the script, including any issues that may arise on your system.

**Permissions**

You may modify and distribute the script as per the project's license. However, you must include this disclaimer in any copies of the script or substantial portions of it.
