# [Not Ready to Use] OpenSUSE Leap Setup Scripts (w/ NVIDIA G06 Drivers)

**Fork of [this](https://github.com/DAK404/OpenSUSE-Setup-Scripts) repo (version 2.0.0) for Tumbleweed**

This is a set of scripts that can help in configuring and setting up repositories, codecs, packages and configure applications or systems for daily use.

Further, this can be used to configure OpenSUSE Leap (15.6) on multiple systems quickly by just using a shell script.

## Table of Contents

- [OpenSUSE Leap Setup Scripts](#opensuse-tumbleweed-setup-scripts)
  - [Table of Contents](#table-of-contents)
  - [How To Use](#how-to-use)
  - [Arguments](#arguments)
  - [DISCLAIMER!](#disclaimer)


## How To Use

To run the script without the extras, you can simply copy paste the below code to get it running.

TODO: edit
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
| codecs-vlc        | Installs codecs from official VLC                                  |
| nvidia-g06        | Installs NVIDIA G06 drivers (the easy way, see [also](https://en.opensuse.org/SDB:NVIDIA_the_hard_way))                         |

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
