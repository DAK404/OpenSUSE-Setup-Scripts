#!/bin/bash

set -euo pipefail

# # Check if the script is run as root
# if [ "$EUID" -ne 0 ]; then
#   echo "Please run as root"
#   exit 1
# fi

selection_menu_common()
{
    echo "--- COMMON TWEAKS FOR ALL DISTROS ---"
    echo ""
    echo "A. Browsers"
    echo ""
    echo "  1. Zen Browser"
    echo "  2. WaterFox Browser"
    echo ""
    echo "---------------------"
    echo ""
    echo "B. Fixes"
    echo ""
    echo "  4. Gigabyte Desktop Sleep Fix"
    echo "  5. Install ICM Profiles"
    echo "  6. Enable NumLock in SDDM"
    echo ""
    echo "---------------------"
    echo ""
    echo "C. Tweaks"
    echo ""
    echo "  7. mDNS/Avahi Firewall Rules"
    echo "  8. Configure OpenRGB \[AMD DESKTOPS ONLY\]"
    echo "  9. Remove Flatpak"
    echo ""
    echo "---------------------"
    echo ""
    echo "D. Personalization"
    echo ""
    echo "  10. Breeze Transparent Theme"
    echo "  11. MacTahoe Global Theme \(Plasma, GTK, Icons\)"
    echo "  12. Posy's Cursor for Linux"
    echo "  13. Plasma Shader Wallpaper"
    echo ""
}

selection_menu_distro_openSUSE()
{
    echo "--- OPENSUSE TUMBLEWEED SPECIFIC ---"
    echo ""
    echo "E. Browsers"
    echo ""
    echo "  14. Brave Browser"
    echo "  15. Chrome Browser"
    echo "  16. Microsoft Edge Browser"
    echo ""
    echo "---------------------"
    echo "F. Codecs Installation"
    echo ""
    echo "  17. Packman Codecs"
    echo "  18. Packman Essential Codecs"
    echo "  19. Main Repository Codecs"
    echo ""
    echo "---------------------"
    echo ""
    echo "G. Fixes And Tweaks"
    echo ""
    echo "  20. Fix Missing Fonts"
    echo "  21. Configure OpenRGB"
    echo "  22. Configure systemd service for Automatic System Updates"
    echo ""
    echo "---------------------"
    echo ""
    echo "H. Package Installation"
    echo ""
    echo "  23. Cockpit"
    echo "  24. Gaming Packages"
    echo "  25. GitHub Desktop"
    echo "  26. JetBrains Toolbox"
    echo "  27. System Utilities"
    echo "  28. Visual Studio Code"
    echo "  29. Warp Terminal"
    echo ""
    echo "---------------------"

}

echo "Linux Setup Scripts"
echo "Version 3.0.0"
echo "Documentation: https://github.com/DAK404/Linux-Setup-Scripts"
echo ""
selection_menu_common
selection_menu_distro_openSUSE