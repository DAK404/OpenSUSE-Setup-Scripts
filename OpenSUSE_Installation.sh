#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

##########################################
# ----- GUIDED INSTALLATION SCRIPT ----- #
##########################################
#
# Guided installation for users who want a
# step by step approach to configuring and
# installing packages and software.
#
##########################################

SCRIPT_VERSION="2.1.2"
INTERNET_CONNECTION=false
SCRIPT_PATH="https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main"

BROWSER_TYPE="NONE"
CODECS_TYPE="NONE"

# Declare arrays to store scriptlet names
declare -a FIXES
declare -a TWEAKS
declare -a PKGS
declare -a PRSNL
declare -a OTHER

# Function to check if the computer is able to ping GitHub servers
check_internet_connection()
{
    if ping -c 1 github.com &> /dev/null
    then
        echo "[ INFORMATION ] Ping to GitHub Successful."
        INTERNET_CONNECTION=true
    else
        echo "[ WARNING ] Ping to GitHub Failed!"
        SCRIPT_PATH="."
    fi

    echo "[ INFORMATION ] Internet Connection Check Complete"
}

# Function to run scriptlets
scriptlet_runner()
{
    local scriptlet_name="$1"
    local scriptlet_path="$SCRIPT_PATH/Scriptlets/$scriptlet_name.sh"

    echo "[ INFO ] Running scriptlet: $scriptlet_name"

    if [ "$INTERNET_CONNECTION" = true ]; then
        echo "[ INFO ] Fetching from remote: $scriptlet_path"
        if curl -fsSL "$scriptlet_path" | bash; then
            echo "[ SUCCESS ] Remote scriptlet executed successfully."
            return 0
        else
            echo "[ WARNING ] Failed to fetch/execute remote script. Trying local fallback..."
        fi
    fi

    # Fallback: try to run from local path
    local fallback_path="./Scriptlets/$scriptlet_name.sh"
    if [ -f "$fallback_path" ]; then
        echo "[ INFO ] Running local scriptlet: $fallback_path"
        bash "$fallback_path"
    else
        echo "[ ERROR ] Scriptlet not found locally at $fallback_path"
        return 1
    fi
}


# Function to install browser packages
sw_install_browers()
{
    scriptlet_runner "Browsers/Browser-$BROWSER_TYPE"
}

sw_install_codecs()
{
    scriptlet_runner "Codecs/Codecs-$CODECS_TYPE"
}

sw_install_fixes()
{
    scriptlet_runner "Fixes-and-Tweaks/Fix-$1"
}

sw_install_tweaks()
{
    scriptlet_runner "Fixes-and-Tweaks/Tweak-$1"
}

sw_install_packages()
{
    scriptlet_runner "Package-Installation/Pkg-$1"
}

sw_install_personalization()
{
    scriptlet_runner "Personalization/Personalization-$1"
}

script_helpfile()
{
    curl -s https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Documentation/OpenSUSE-Setup-Scripts.help | less
}

# Function to perform clean up
cleanup()
{
    sudo zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}' | grep -v Name | sudo xargs -r zypper remove -y --clean-deps >> ~/Cleanup.log
    mv /tmp/DAK404-OpenSUSE-Setup.log ~/

    echo "Setup Complete! Log file saved to $HOME/DAK404-OpenSUSE-Setup.log"
    echo "It is recommended to restart your system to apply changes."
}

# Function to display the menu
display_menu()
{
    clear
    echo "---------------------------------------------"
    echo "OpenSUSE Setup Scripts - Guided Installation"
    echo "Version: $SCRIPT_VERSION"
    echo "---------------------------------------------"
    echo
    echo "Please choose an option:"
    echo
    echo "---------- BROWSERS ----------"
    echo
    echo "1. Install Brave Browser"
    echo "2. Install Chrome Browser"
    echo "3. Install MSEdge Browser"
    echo "4. Install Zen Browser"
    echo
    echo "----------- CODECS -----------"
    echo
    echo "5. Packman Codecs"
    echo "6. Packman Essentials Codecs"
    echo "7. Main Repository Codecs"
    echo
    echo "------- FIX AND TWEAKS -------"
    echo
    echo "8. Gigabyte Desktop Sleep Fix"
    echo "9. Install ICM Profiles"
    echo "10. Install Missing Fonts"
    echo "11. SDDM Number Lock Fix"
    echo "12. Tweak Aliases"
    echo "13. Tweak Firewall Rules for mDNS"
    echo "14. Install and Configure openRGB"
    echo "15. Install Monthly Automatic System Updates"
    echo "16. Install zsh and Oh-My-Zsh!"
    echo
    echo "---- PACKAGE INSTALLATION ----"
    echo
    echo "17. Gaming Packages"
    echo "18. Git and GitHub Desktop"
    echo "19. Essential System Utilities"
    echo "20. Visual Studio Code"
    echo "21. JetBrains Toolbox"
    echo "22. Warp Terminal (warp.dev)"
    echo
    echo "------- PERSONALIZATION ------"
    echo
    echo "23. Install Global Theme (Plasma and GTK)"
    echo "24. Install Posy's Cursors"
    echo "25. Install Breeze Transparent Plasma Style"
    echo
    echo "------------------------------"
    echo
    echo "0. Exit"
    echo "?. Help"
    echo
}

# Function to handle user input
handle_input() {
    case $1 in
        0)
            echo "Exiting..."
            exit 0
            ;;
        1)
            BROWSER_TYPE='Brave'
            sw_install_browers
            ;;
        2)
            BROWSER_TYPE='Chrome'
            sw_install_browers
            ;;
        3)
            BROWSER_TYPE='MSEdge'
            sw_install_browers
            ;;
        4)
            BROWSER_TYPE='Zen'
            sw_install_browers
            ;;
        5)
            CODECS_TYPE='opi'
            sw_install_codecs
            ;;
        6)
            CODECS_TYPE='packman-essentials'
            sw_install_codecs
            ;;
        7)
            CODECS_TYPE='main'
            sw_install_codecs
            ;;
        8)
            sw_install_fixes 'GigabyteDesktopSleepFix'
            ;;
        9)
            sw_install_fixes 'ICMProfiles'
            ;;
        10)
            sw_install_fixes 'MissingFonts'
            ;;
        11)
            sw_install_fixes 'SDDMNumLock'
            ;;
        12)
            sw_install_tweaks 'Aliases'
            ;;
        13)
            sw_install_tweaks 'mDNSFirewallRules'
            ;;
        14)
            sw_install_tweaks 'OpenRGB'
            ;;
        15)
            sw_install_tweaks 'SysAutoUpdate'
            ;;
        16)
            sw_install_tweaks 'zsh'
            ;;
        17)
            sw_install_packages 'Gaming'
            ;;
        18)
            sw_install_packages 'GitHubDesktop'
            ;;
        19)
            sw_install_packages 'SysUtilities'
            ;;
        20)
            sw_install_packages 'VSCode'
            ;;
        21)
            sw_install_packages 'JetBrainsToolbox'
            ;;
        22)
            sw_install_packages 'WarpTerminal'
            ;;
        23)
            sw_install_personalization 'GlobalTheme'
            ;;
        24)
            sw_install_personalization 'PosysCursors'
            ;;
        25)
            sw_install_personalization 'BreezeTransparent'
            ;;
        ?)
            script_helpfile
            ;;
        *)
            echo "Invalid option, please choose a valid option!"
            ;;
    esac
}

# Check internet connection
check_internet_connection

if [ $# -eq 0 ]; then
    # Main loop
    while true; do
        display_menu
        read -p "Enter your choice (1-25): " choice
        handle_input $choice
        read -p "Press Enter to continue..."
    done
else

    ##########################################
    # ---- UNGUIDED INSTALLATION SCRIPT ---- #
    ##########################################
    #
    # Scripts are run by parsing the arguments
    # passed to the script. This requires no
    # user interaction and is useful for
    # automation or unattended installations.
    #
    ##########################################

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
    sw_install_codecs "$CODECS_TYPE"
    sw_install_browers "$BROWSER_TYPE"

    # Run all selected  Fix scriptlets
    for fixes in "${FIXES[@]}"
    do
        sw_install_fixes "$fixes"
    done

    # Run all selected  Tweak scriptlets
    for tweaks in "${TWEAKS[@]}"
    do
        sw_install_tweaks "$tweaks"
    done

    # Run all selected  Package Installation scriptlets
    for pkgs in "${PKGS[@]}"
    do
        sw_install_packages "$pkgs"
    done

    # Run all selected Personalization scriptlets
    for prsnl in "${PRSNL[@]}"
    do
        sw_install_personalization "$prsnl"
    done
fi

# Perform cleanup
cleanup
exit 0
