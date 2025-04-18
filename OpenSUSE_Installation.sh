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

TODO: add functions
TODO: fix repos

SCRIPT_VERSION="0.0.1"
INTERNET_CONNECTION=true

LOG_FILE=/tmp/n-shamsi-OpenSUSE-Setup.log
SCRIPT_PATH="https://raw.githubusercontent.com/n-shamsi/OpenSUSE-Setup-Scripts/main/"

# ********************************************************* #
#                    REQUIREMENT CHECK
# ********************************************************* #

# Function to log messages to specified path
message_logger()
{
    local message="$1"
    local timestamp=$(date +%s)
    echo "[$timestamp]: $message" | tee -a "$LOG_FILE"
}

# Function to check if computer is able to ping GitHub servers
check_internet_connection()
{
    message_logger "[I] Started: Internet Connection Check"
    message_logger "[I] Pinging: github.com"
    if ping -c 1 github.com &> /dev/null
    then
        message_logger "[I] Ping Successful"
        echo "[ INFORMATION ] Ping to GitHub Successful."
    else
        message_logger "[W] Ping Unsuccessful"
        echo "[ WARNING ] Ping to GitHub Failed!"
        INTERNET_CONNECTION=false
        SCRIPT_PATH="./"
    fi

    message_logger "[I] FINISHED: Internet Connection Check"
    echo "[ INFORMATION ] Internet Connection Check Complete"
}

# ********************************************************* #
#                    REPOSITORY ADDITION
# ********************************************************* #

# Function to add necessary repositories
add_repositories()
{
    message_logger "[I] Started: Add Repositories"

    # ---------- REPOSITORY GPG KEY URLS ---------- #
    TODO: add
    # --------------------------------------------- #

    # ----------     REPOSITORY URLS     ---------- #
    VLC_REPO_URL='https://download.videolan.org/SuSE/$releasever/'
    GAMES_REPO_URL='https://download.opensuse.org/repositories/games:/tools/$releasever/'
    PACKMAN_REPO_URL='https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_$releasever/'
    SCIENCE_REPO_URL='https://download.opensuse.org/repositories/science/$releasever/' # linear algebra libraries
    DATABASE_URL='https://download.opensuse.org/repositories/server:/database/$releasever/'
    NVIDIA_URL='https://download.nvidia.com/opensuse/leap/$releasever'
    # --------------------------------------------- #

    message_logger "[I] Started: Add VLC Repository"
    echo "[ INFORMATION ] Adding Repository: VLC"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$VLC_REPO_URL" 'VLC'
    message_logger "[I] Finished: Add VLC Repository"

    message_logger "[I] Started: Add OpenSUSE Games Repository"
    echo "[ INFORMATION ] Adding Repository: OpenSUSE Games"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$GAMES_REPO_URL" 'Games'
    message_logger "[I] Finished: Add OpenSUSE Games Repository"

    message_logger "[I] Started: Add OpenSUSE NVIDIA Repository"
    echo "[ INFORMATION ] Adding Repository: OpenSUSE NVIDIA"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$NVIDIA_URL" 'NVIDIA'
    message_logger "[I] Finished: Add OpenSUSE NVIDIA Repository"

    message_logger "[I] Started: Refreshing Repositories; Importing GPG Keys"
    echo "[ INFORMATION ] Refreshing Repositories; Importing GPG Keys..."
    message_logger "$(sudo zypper --gpg-auto-import-keys refresh)"
    message_logger "[I] Finished: Refreshing Repositories; Importing GPG Keys"

    message_logger "[I] Finished: Add Repositories"
}

# ********************************************************* #
#                    CODECS INSTALLATION
# ********************************************************* #

# Function to install codecs from Packman repositories
codecs_install_packman()
{
    message_logger "[I] Started: Add Packman Repository"
    echo "[ INFORMATION ] Adding Repository: Packman"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$PACKMAN_REPO_URL" "packman"
    message_logger "[I] Finished: Add Packman Repository"

    sudo zypper --gpg-auto-import-keys refresh

    message_logger "[I] Started: Codecs Installation - Packman"
    echo "[  ATTENTION  ] Installing: Codecs from Packman Repositories"
    sudo zypper install -y --allow-vendor-change --from Packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs
    message_logger "[I] Finished: Codecs Installation - Packman"
}

# Function to install codecs from Main repositories
codecs_install_Main()
{
    message_logger "[I] Started: Codecs Installation - Main"
    echo "[  ATTENTION  ] Installing: Codecs from Main Repositories (OSS)"
    sudo zypper install -y ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec vlc-codecs
    message_logger "[I] Finished: Codecs Installation - Main"
}

# Function to install codecs from OPI
codecs_install_opi()
{
    message_logger "[I] Started: Codecs Installation - OPI"
    echo "[  ATTENTION  ] Installing: Codecs from OPI"
    sudo zypper install -y opi
    opi codecs -n
    message_logger "[I] Finished: Codecs Installation - OPI"
}

# Function to install codecs from VLC repositories
codecs_install_VLC()
{
    message_logger "[I] Started: Codecs Installation - VLC"
    echo "[  ATTENTION  ] Installing: Codecs from VLC Repositories"
    sudo zypper install -y ffmpeg gstreamer-plugins-{good,bad,ugly,libav}
    latest_version=$(zypper search -s libavcodec | grep -Eo 'libavcodec[0-9]+' | sort -V | tail -1)
    sudo zypper install -y --from VLC --allow-vendor-change vlc-codecs x264 x265 $latest_version
    message_logger "[I] Finished: Codecs Installation - VLC"
}

# ********************************************************* #
#                   SOFTWARE INSTALLATION
# ********************************************************* #

# Function to install KDE Utilities
sw_install_kde_pkgs()
{
    message_logger "[I] Started: KDE Utilities Installation"
    echo "[  ATTENTION  ] Installing: KDE Utilities"
    sudo zypper install -y kdeconnect-kde krita kdenlive partitionmanager
    message_logger "[I] Finished: KDE Utilities Installation"
}

# Function to install System Utilities
sw_install_sys_util_pkgs()
{
    message_logger "[I] Started: Installing System Utilities"
    echo "[  ATTENTION  ] Installing: System Utilities"
    sudo zypper install -y fde-tools bleachbit libdbusmenu-glib4 p11-kit-server
    message_logger "[I] Finished: Installing System Utilities"
}

# Function to install Gaming Components
sw_install_gaming_pkgs()
{
    message_logger "[I] Started: Installing WINE and Gaming Components"
    echo "[  ATTENTION  ] Installing: WINE and Gaming Components"
    sudo zypper install -y dxvk wine lutris steam gamemode
    message_logger "[I] Finished: Installing WINE and Gaming Components"
}

# Function to install VLC and Codecs
sw_remove_VLC_Main_pkgs()
{
    message_logger "[I] Started: Removing VLC and Codecs from Main Repository (OSS)"
    echo "[  ATTENTION  ] Removing: VLC and Codecs from Main Repository (OSS)"
    sudo zypper remove -y vlc vlc-codecs
    message_logger "[I] Finished: Removing VLC and Codecs from Main Repository (OSS)"
}

# Function to install VLC and Codecs
sw_install_VLC_pkgs()
{
    message_logger "[I] Started: Installing VLC"
    echo "[  ATTENTION  ] Installing: VLC"
    sudo zypper install -y --from VLC --allow-vendor-change vlc
    sudo zypper dup -y --from VLC --allow-vendor-change
    message_logger "[I] Finished: Installing VLC"
}

# ********************************************************* #
#                   ALIAS INSTALLATION
# ********************************************************* #

# Function to install 'autoremove' command
alias_install_autoremove()
{
    message_logger "[I] Started: Installing 'autoremove' command"
    printf "[ INFORMATION ] Installing: \'autoremove\' command\n"
    echo "alias autoremove=\"sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps >> ~/Cleanup.log\"" | sudo tee -a /etc/bash.bashrc.local
    message_logger "[I] Finished: Installing 'autoremove' command"
}

# ********************************************************* #
#                   CLEANUP FUNCTIONS
# ********************************************************* #

# Function to finish cleanup
finish_cleanup()
{
    message_logger "[I] Started: Cleaning Up"
    echo "[ INFORMATION ] Cleaning Up..."
    sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs zypper remove -y --clean-deps >> ~/Cleanup.log
    mv /tmp/DAK404-OpenSUSE-Setup.log ~/
    echo "Setup Complete! Log file saved to ~/DAK404-OpenSSE-Setup.log"
    echo "It is recommended to restart your system to apply changes."
}

# ********************************************************* #
#                     SCRIPT ENTRY POINT
# ********************************************************* #

message_logger "[I] OpenSUSE Setup Script - Version: $SCRIPT_VERSION"
message_logger "[I] Log File stored in: $LOG_FILE"

check_internet_connection

if $INTERNET_CONNECTION
then
    add_repositories
    
    for arg in "$@"
    do
        case "$arg" in
            codecs-packman)
                codecs_install_packman
                break
                ;;
            codecs-main)
                codecs_install_Main
                break
                ;;
            codecs-opi)
                codecs_install_opi
                break
                ;;
            codecs-vlc)
                codecs_install_VLC
                break
                ;;
        esac
    done

    sw_install_kde_pkgs
    sw_install_sys_util_pkgs
    sw_install_gaming_pkgs
    sw_remove_VLC_Main_pkgs
    sw_install_VLC_pkgs

else
    echo "[   WARNING   ] Internet Connection Unavailable! Skipping Repository Addition, Codecs and Package Installation."
fi

alias_install_autoremove
finish_cleanup
