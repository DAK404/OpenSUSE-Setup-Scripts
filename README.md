# OpenSUSE Tumbleweed Setup Scripts

**Now with improved code in version 2.0.0 and beyond!**

This is a set of scripts that can help in configuring and setting up repositories, codecs, packages and configure applications or systems for daily use.

Further, this can be used to configure OpenSUSE Tumbleweed on multiple systems quickly by just using a shell script.

Please note that the `Testing` branch is always ahead of the `main` branch. Therefore, there may be differences. If in doubt, please use the scripts in the main branch. The testing branch is used for testing.

## Table of Contents

- [OpenSUSE Tumbleweed Setup Scripts](#opensuse-tumbleweed-setup-scripts)
  - [Table of Contents](#table-of-contents)
  - [How To Use](#how-to-use)
  - [Arguments](#arguments)
  - [The Other Shell Scripts](#the-other-shell-scripts)
  - [I Need More Information!](#i-need-more-information)
  - [DISCLAIMER!](#disclaimer)


## How To Use

To run the script without the extras, you can simply copy paste the below code to get it running.

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/OpenSUSE_Installation.sh)"
```

Please see [Arguments](README.MD#arguments) for more options.

## Arguments

The `OpenSUSE-setup.sh` script may require a few arguments as per your use-case or needs. The following arguments and the description of each is as follows:

| Argument          | Description                                                        |
|-------------------|--------------------------------------------------------------------|
| codecs-packman    | Installs codecs from Packman repository                            |
| codecs-main       | Installs codecs from Repository Main (OSS)                         |
| codecs-opi        | Installs OPI and codecs from OPI                                   |
| codecs-vlc        | Installs codecs from official VLC repository                       |
| discord           | Installs Discord using my Script                                   |
| openrgb           | Installs and sets up openRGB                                       |
| gigabyte-sleep-fix| Fixes issues with Gigabyte systems that do not go to sleep         |
| zen-browser       | Installs Zen Browser                                               |
| personalize       | Installs themes, sound themes and wallpapers                       |
| remove-flatpak    | Removes flatpak and flatpak applications                           |

Example:

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/OpenSUSE_Installation.sh)" codecs-vlc discord openrgb gigabyte-sleep-fix zen-browser personalize
```

## The Other Shell Scripts
| Script Name          | Description                                                                                           |
|----------------------|-------------------------------------------------------------------------------------------------------|
| Discord-Install.sh   | Downloads and installs Discord directly from the Discord website.                                     |
| OpenRGB.sh           | Downloads and configures OpenRGB for managing peripheral lighting. Also, please check the [Official OpenRGB Repository](https://gitlab.com/CalcProgrammer1/OpenRGB#smbus-access-1) for more information. |
| GigabyteDesktop_Sleep_Fix.sh| Please check [THIS](https://www.reddit.com/r/gigabyte/comments/p5ewjn/b550i_pro_ax_f13_bios_sleep_issue_on_linux/?rdt=52322). Essentially, a few Gigabyte motherboards have issues with Linux installations of not able to sleep. |
| Remove_Flatpak.sh    | This script will remove Flatpak and Flatpak applications installed on your system. May be helpful for anyone who does not want or use Flatpak. |
| Personalize.sh       | A script that will download and install [Vinceliuice](https://github.com/vinceliuice)'s Colloid Theme. |
| login_tasks.sh       | Still working on this one. Currently, it just removes the `GPUCache` directory inside the MS Edge and VSCode config directories. |
| Zen-Browser-Install.sh        | Installs Zen Browser, a lightweight and fast web browser.                                             |

You may run individual scripts by the following command (replace the `<SCRIPT_NAME>` with a valid script file name):

```
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
