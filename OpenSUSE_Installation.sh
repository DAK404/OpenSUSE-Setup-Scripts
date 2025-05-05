#!/bin/bash

############################################################
# OpenSUSE Setup Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/OpenSUSE_Installation.sh)"
#
############################################################

SCRIPT_VERSION="2.1.0"
INTERNET_CONNECTION=true

LOG_FILE=/tmp/DAK404-OpenSUSE-Setup.log
SCRIPT_PATH="https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/"

CODECS_TYPE="none"
BROWSER_TYPE="none"

# Declare arrays to store scriptlet names
declare -a FIXES
declare -a TWEAKS
declare -a PKGS
declare -a PRSNL
declare -a OTHER

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Function to check if the computer is able to ping GitHub servers
check_internet_connection()
{
    if ping -c 1 github.com &> /dev/null
    then
        echo "[ INFORMATION ] Ping to GitHub Successful."
    else
        echo "[ WARNING ] Ping to GitHub Failed!"
        INTERNET_CONNECTION=false
        SCRIPT_PATH="./"
    fi

    echo "[ INFORMATION ] Internet Connection Check Complete"
}

# Function to run scriptlets
scriptlet_runner()
{
    local scriptlet_name="$1"
    local scriptlet_path="$SCRIPT_PATH/Scriptlets/$scriptlet_name.sh"

    if [ ! -f "$scriptlet_path" ]; then
        echo "[ ERROR ] Scriptlet $scriptlet_name not found at $scriptlet_path!"
        return 1
    fi

    sudo bash "$scriptlet_path"
}

# Function to perform clean up
cleanup()
{
    sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs -r zypper remove -y --clean-deps >> ~/Cleanup.log
    mv /tmp/DAK404-OpenSUSE-Setup.log ~/

    echo "Setup Complete! Log file saved to $HOME/DAK404-OpenSUSE-Setup.log"
    echo "It is recommended to restart your system to apply changes."
}

# ********************************************************* #
#                     SCRIPT ENTRY POINT
# ********************************************************* #

echo "[I] OpenSUSE Setup Script - Version: $SCRIPT_VERSION"
echo "[I] Log File stored in: $LOG_FILE"

# Check internet connection
check_internet_connection

# If no internet connection, set script path to local
if ! $INTERNET_CONNECTION
then
    SCRIPT_PATH="./"
fi

# Parse arguments and store scriptlet names in arrays
for arg in "$@"
do
    case "$arg" in
        codecs=*)
            CODECS_TYPE="${arg#*=}"
            ;;
        browser=*)
            BROWSER_TYPE="${arg#*=}"
            ;;
        Fix=*)
            IFS=',' read -r -a fix_array <<< "${arg#*=}"
            FIXES+=("${fix_array[@]}")
            ;;
        Tweak=*)
            IFS=',' read -r -a tweak_array <<< "${arg#*=}"
            TWEAKS+=("${tweak_array[@]}")
            ;;
        Pkg=*)
            IFS=',' read -r -a pkg_array <<< "${arg#*=}"
            PKGS+=("${pkg_array[@]}")
            ;;
        Prsnl=*)
            IFS=',' read -r -a prsnl_array <<< "${arg#*=}"
            PRSNL+=("${prsnl_array[@]}")
            ;;
        Other=*)
            IFS=',' read -r -a other_array <<< "${arg#*=}"
            OTHER+=("${other_array[@]}")
            ;;
        *)
            echo "[ ERROR ] Undefined Argument: $arg"
            ;;
    esac
done

# Run scriptlets for codecs and browsers
scriptlet_runner "/Codecs/Codecs-$CODECS_TYPE"
scriptlet_runner "/Browsers/Browser-$BROWSER_TYPE"

# Run all Fix scriptlets
for fixes in "${FIXES[@]}"
do
    scriptlet_runner "/Fixes-and-Tweaks/Fix-$fixes"
done

# Run all Tweak scriptlets
for tweaks in "${TWEAKS[@]}"
do
    scriptlet_runner "/Fixes-and-Tweaks/Tweak-$tweaks"
done

# Run all Package Installation scriptlets
for pkgs in "${PKGS[@]}"
do
    scriptlet_runner "/Package-Installation/Tweak-$pkgs"
done

# Run all Personalization scriptlets
for prsnl in "${PRSNL[@]}"
do
    scriptlet_runner "/Personalization/Personalization-$prsnl"
done

# Perform cleanup
cleanup
exit 0