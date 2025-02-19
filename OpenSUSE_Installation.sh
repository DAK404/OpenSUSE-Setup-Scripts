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

SCRIPT_VERSION="2.0.1"
INTERNET_CONNECTION=true

LOG_FILE=/tmp/DAK404-OpenSUSE-Setup.log
SCRIPT_PATH="https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/"

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
    MICROSOFT_GPG_KEY_URL='https://packages.microsoft.com/keys/microsoft.asc'
    GITHUB_GPG_KEY_URL='https://rpm.packages.shiftkey.dev/gpg.key'
    # --------------------------------------------- #

    # ----------     REPOSITORY URLS     ---------- #
    MSEDGE_REPO_URL='https://packages.microsoft.com/yumrepos/edge'
    VSCODE_REPO_URL='https://packages.microsoft.com/yumrepos/vscode'
    GITHUB_REPO_URL='https://rpm.packages.shiftkey.dev/rpm/'
    VLC_REPO_URL='https://download.videolan.org/pub/vlc/SuSE/Tumbleweed/'
    GAMES_REPO_URL='https://download.opensuse.org/repositories/games/openSUSE_Tumbleweed/'
    PACKMAN_REPO_URL='https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/'
    # --------------------------------------------- #

    message_logger "[I] Started: Add Microsoft Repositories"
    echo "[ INFORMATION ] Adding Repositories: Microsoft"
    sudo rpm --import "$MICROSOFT_GPG_KEY_URL"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$MSEDGE_REPO_URL" 'microsoft-edge'
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$VSCODE_REPO_URL" 'Visual Studio Code'
    message_logger "[I] Finished: Add Microsoft Repositories"

    message_logger "[I] Started: Add GitHub Repository"
    echo "[ INFORMATION ] Adding Repository: GitHub Desktop"
    sudo rpm --import "$GITHUB_GPG_KEY_URL"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$GITHUB_REPO_URL" 'GitHub Desktop'
    message_logger "[I] Finished: Add GitHub Repository"

    message_logger "[I] Started: Add VLC Repository"
    echo "[ INFORMATION ] Adding Repository: VLC"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$VLC_REPO_URL" 'VLC'
    message_logger "[I] Finished: Add VLC Repository"

    message_logger "[I] Started: Add OpenSUSE Games Repository"
    echo "[ INFORMATION ] Adding Repository: OpenSUSE Games"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$GAMES_REPO_URL" 'Games'
    message_logger "[I] Finished: Add OpenSUSE Games Repository"

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
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$PACKMAN_REPO_URL" "Packman"
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

# Function to install Microsoft Edge and VS Code
sw_install_microsoft_pkgs()
{
    message_logger "[I] Started: Installing Microsoft Edge and VS Code"
    echo "[  ATTENTION  ] Installing: Microsoft Edge and VS Code"
    sudo zypper install -y microsoft-edge-stable code
    message_logger "[I] Finished: Installing Microsoft Edge and VS Code"
}

# Function to install GitHub Desktop and Git
sw_install_git_github_pkgs()
{
    message_logger "[I] Started: Installing GitHub Desktop and Git"
    echo "[  ATTENTION  ] Installing: GitHub Desktop & Git"
    sudo zypper install -y github-desktop git
    message_logger "[I] Finished: Installing GitHub Desktop and Git"
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
#                   SCRIPT INSTALLATION
# ********************************************************* #

# Function to install Discord using my script
sw_install_Discord_script()
{
    message_logger "[I] Started: Installing Discord [Script]"
    echo "[  ATTENTION  ] Installing: Discord"
    bash -c "$(curl -fsSL ${SCRIPT_PATH}Discord-Install.sh)"
    message_logger "[I] Finished: Installing Discord [Script]"
}

# Function to install OpenRGB using my script
sw_install_openRGB_script()
{
    message_logger "[I] Started: Installing OpenRGB [Script]"
    echo "[  ATTENTION  ] Installing: OpenRGB"
    bash -c "$(curl -fsSL ${SCRIPT_PATH}OpenRGB.sh)"
    message_logger "[I] Finished: Installing OpenRGB [Script]"
}

# Function to install Gigabyte Sleep Fix using my script
sw_install_Gigabyte_Sleep_Fix_script()
{
    message_logger "[I] Started: Installing Sleep Fix for Gigabyte Motherboards [Script]"
    echo "[  ATTENTION  ] Installing: Sleep Fix for Gigabyte Motherboards"
    bash -c "$(curl -fsSL ${SCRIPT_PATH}GigabyteDesktop_Sleep_Fix.sh)"
    message_logger "[I] Finished: Installing Sleep Fix for Gigabyte Motherboards [Script]"
}

# Function to install KDE Personalization using my script
sw_install_KDE_Personalization_script()
{
    message_logger "[I] Started: Installing KDE Personalization [Script]"
    echo "[  ATTENTION  ] Installing: Wallpaper, Kvantum and Sound Themes"
    bash -c "$(curl -fsSL ${SCRIPT_PATH}Personalize.sh)"
    message_logger "[I] Finished: Installing KDE Personalization [Script]"
}

# Function to remove Flatpak and Flatpak Applications using my script
sw_remove_flatpak_script()
{
    message_logger "[I] Started: Removing Flatpak and Flatpak Applications [Script]"
    echo "[  ATTENTION  ] Removing: Flatpak and Flatpak Applications"
    bash -c "$(curl -fsSL ${SCRIPT_PATH}Remove_Flatpak.sh)"
    message_logger "[I] Finished: Removing Flatpak and Flatpak Applications [Script]"
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
    sw_install_microsoft_pkgs
    sw_install_git_github_pkgs
    sw_install_sys_util_pkgs
    sw_install_gaming_pkgs
    sw_remove_VLC_Main_pkgs
    sw_install_VLC_pkgs

    # Process arguments and call corresponding functions
    for arg in "$@"
    do
        case "$arg" in
            discord)
                sw_install_Discord_script
                ;;
            openrgb)
                sw_install_openRGB_script
                ;;
            gigabyte-sleep-fix)
                sw_install_Gigabyte_Sleep_Fix_script
                ;;
            personalize)
                sw_install_KDE_Personalization_script
                ;;
            remove-flatpak)
                sw_remove_flatpak_script
                ;;
        esac
    done

else
    echo "[   WARNING   ] Internet Connection Unavailable! Skipping Repository Addition, Codecs and Package Installation."
fi

alias_install_autoremove
finish_cleanup
