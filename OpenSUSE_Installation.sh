#!/bin/bash

############################################################
# OpenSUSE Setup Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/n-shamsi/OpenSUSE-Setup-Scripts/refs/heads/n-shamsi-leap-1/OpenSUSE_Installation.sh)"
#
############################################################

TODO: add NVIDIA G06 drivers install

SCRIPT_VERSION="0.0.1"
INTERNET_CONNECTION=true

LOG_FILE=/tmp/nis-OpenSUSE-Setup.log
SCRIPT_PATH="https://raw.githubusercontent.com/n-shamsi/OpenSUSE-Setup-Scripts/refs/heads/n-shamsi-leap-1/OpenSUSE_Installation.sh"

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

    # ----------     REPOSITORY URLS     ---------- #
    VLC_REPO_URL='https://download.videolan.org/SuSE/$releasever/'
    PACKMAN_REPO_URL='https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_15.6'
    NVIDIA_REPO_URL='https://download.nvidia.com/opensuse/leap/$releasever'
    # --------------------------------------------- #

    message_logger "[I] Started: Add VLC Repository"
    echo "[ INFORMATION ] Adding Repository: VLC"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$VLC_REPO_URL" 'VLC'
    message_logger "[I] Finished: Add VLC Repository"

    message_logger "[I] Started: Add OpenSUSE NVIDIA Repository"
    echo "[ INFORMATION ] Adding Repository: OpenSUSE NVIDIA"
    sudo zypper --gpg-auto-import-keys addrepo --refresh "$NVIDIA_REPO_URL" 'NVIDIA'
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

mk_tools_dir()
{
    message_logger "[I] Started: Making tools directory"
    echo "[ ATTENTION ] Making: Tools directory"
    mkdir tools
    cd tools
}

# Function to install python
sw_install_py_pkgs()
{
    message_logger "[I] Started: Python3 Installation"
    echo "[  ATTENTION  ] Installing: Python3"
    sudo zypper install -y python311 python311-devel python311-pip python311-setuptools
    message_logger "[I] Finished: Python3 Installation"
}

# Function to install make + related dev tools
sw_install_make_pkgs()
{
    message_logger "[I] Started: Make Installation"
    echo "[  ATTENTION  ] Installing: Make + Related Tools"
    sudo zypper install -y -t pattern devel_basis
    message_logger "[I] Finished: Make Installation"
}


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
    sudo zypper install -y bleachbit libdbusmenu-glib4 # no official fde-tools for Leap 15.6
    message_logger "[I] Finished: Installing System Utilities"
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

# Function to install Science packages
sw_install_sci_pkgs()
{
    message_logger "[I] Started: Installing Science packages"
    echo "[  ATTENTION  ] Installing: Science packages"
    sudo zypper install -y blas-devel lapack-devel 
    message_logger "[I] Finished: Installing Science packages"
}

# Function to install Tabby
sw_download_tabby()
{
    message_logger "[I] Started: Installing Tabby"
    echo "[  ATTENTION  ] Installing: Tabby"
    git clone https://github.com/bertvandepoel/tabby.git
    cd ..
    message_logger "[I] Finished: Installing Science packages"
}

# Function to install ZSH and related tools
sw_install_zsh_pkgs()
{
    message_logger "[I] Started: Installing ZSH and Tools"
    echo "[  ATTENTION  ] Installing: ZSH and Tools"
    sudo zypper install -y git-core zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "PROMPT='%n@%m %~ %# '" >> ~/.zshrc
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> ~/.zshrc
    source ~/.zshrc
    message_logger "[I] Finished: Installing ZSH and Tools"
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
    mv /tmp/nis-OpenSUSE-Setup.log ~/
    echo "Setup Complete! Log file saved to ~/nis-OpenSSE-Setup.log"
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

    mk_tools_dir
    sw_install_py_pkgs
    sw_install_make_pkgs
    sw_install_kde_pkgs
    sw_install_sys_util_pkgs
    sw_install_gaming_pkgs
    sw_remove_VLC_Main_pkgs
    sw_install_VLC_pkgs
    sw_install_sci_pkgs
    sw_download_tabby
    sw_install_zsh_pkgs

else
    echo "[   WARNING   ] Internet Connection Unavailable! Skipping Repository Addition, Codecs and Package Installation."
fi

alias_install_autoremove
finish_cleanup
