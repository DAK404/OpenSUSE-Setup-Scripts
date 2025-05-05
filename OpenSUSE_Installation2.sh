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

SCRIPT_VERSION="2.1.0"
INTERNET_CONNECTION=true
LOG_FILE=/tmp/DAK404-OpenSUSE-Setup.log
SCRIPT_PATH="https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main"

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

# Function to install browser packages
sw_install_browers()
{
    scriptlet_runner "/Browsers/$BROWSER_TYPE"
}

sw_install_codecs()
{
    scriptlet_runner "/Codecs/$CODECS_TYPE"
}

sw_install_fixes()
{
    scriptlet_runner "/Fixes-and-Tweaks/Fix-$fixes"
}

sw_install_tweaks()
{
    scriptlet_runner "/Fixes-and-Tweaks/Tweak-$tweaks"
}

sw_install_personalization()
{
    scriptlet_runner "/Personalization/Personalize-$personalization"
}

script_helpfile()
{
    less ./Documentation/HelpMe.help
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
    echo "2. Install Firefox Browser"
    echo "3. Install Chrome Browser"
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
    echo
    echo "---- PACKAGE INSTALLATION ----"
    echo
    echo "16. Gaming Packages"
    echo "17. Git and GitHub Desktop"
    echo "18. Essential System Utilities"
    echo "19. Visual Studio Code"
    echo "20. Warp Terminal (warp.dev)"
    echo
    echo "------- PERSONALIZATION ------"
    echo
    echo "21. Install Global Theme (Plasma and GTK)"
    echo "22. Install Posy's Cursors"
    echo "23. Install Breeze Transparent Plasma Style"
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
            sw_install_browers 'Browser-Brave'
            ;;
        2)
            sw_install_browers 'Browser-Chrome'
            ;;
        3)
            sw_install_browers 'Browser-MSEdge'
            ;;
        4)
            sw_install_browers 'Browser-Zen'
            ;;
        5)
            sw_install_codecs 'Codecs-Packman'
            ;;
        6)  
            sw_install_codecs 'Codecs-Packman-Essentials'
            ;;
        7)
            sw_install_codecs 'Codecs-Main'
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
            sw_install_fixes 'SDDMNumberLockFix'
            ;;
        12)
            sw_install_tweaks 'Aliases'
            ;;
        13)
            sw_install_tweaks 'mDNSFirewallRules'
            ;;
        14)
            sw_install_fixes 'OpenRGB'
            ;;
        15)
            sw_install_fixes 'SysAutoUpdate'
            ;;
        16)
            sw_install_personalization 'Gaming'
            ;;
        17)
            sw_install_personalization 'GitHubDesktop'
            ;;
        18)
            sw_install_personalization 'SysUtilities'
            ;;
        19)
            sw_install_personalization 'VSCode'
            ;;
        20)
            sw_install_personalization 'WarpTerminal'
            ;;
        21)
            sw_install_personalization 'GlobalTheme'
            ;;
        22)
            sw_install_personalization 'PosysCursor'
            ;;
        23)
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

# Main loop
while true; do
    display_menu
    read -p "Enter your choice (1-23): " choice
    handle_input $choice
    read -p "Press Enter to continue..."
done
