#!/bin/bash

set -euo pipefail

# Re-run via pkexec if not root
if [ "$(id -u)" -ne 0 ]; then
    if ! command -v pkexec >/dev/null 2>&1; then
        echo "pkexec not installed." >&2
        exit 1
    fi

    SCRIPT_PATH="$(readlink -f "$0")"
    exec pkexec bash "$SCRIPT_PATH" "$@"
fi

# # Check if the script is run as root
# if [ "$EUID" -ne 0 ]; then
#   echo "Please run as root"
#   exit 1
# fi

script_info_version()
{
    clear
    echo ">>> Linux Setup Scripts <<<"
    echo "       Version 3.0.0       "
    echo ""
}

selection_menu_common()
{
    echo "========== COMMON TWEAKS FOR ALL DISTROS =========="
    echo ""
    echo "A. Browsers"
    echo ""
    echo "  1. Zen Browser"
    echo "  2. WaterFox Browser"
    echo ""
    echo "B. Fixes"
    echo ""
    echo "  4. Gigabyte Desktop Sleep Fix"
    echo "  5. Install ICM Profiles"
    echo "  6. Enable NumLock in SDDM"
    echo ""
    echo "C. Tweaks"
    echo ""
    echo "  7. mDNS/Avahi Firewall Rules"
    echo "  8. Configure OpenRGB (AMD DESKTOPS ONLY)"
    echo "  9. Remove Flatpak"
    echo "  10. Configure Automatic System Updates"
    echo "  11. Configure OpenRGB"
    echo ""
    echo "D. Personalization"
    echo ""
    echo "  12. Breeze Transparent Theme"
    echo "  13. MacTahoe Global Theme (Plasma, GTK, Icons)"
    echo "  14. Posy's Cursor for Linux"
    echo "  15. Plasma Shader Wallpaper"
    echo ""
}

selection_menu_distro_openSUSE()
{
    echo "========== OPENSUSE TUMBLEWEED SPECIFIC =========="
    echo ""
    echo "E. Browsers"
    echo "  16. Brave Browser"
    echo "  17. Chrome Browser"
    echo "  18. Microsoft Edge Browser"
    echo ""
    echo "F. Codecs Installation"
    echo "  19. Packman Codecs"
    echo "  20. Packman Essential Codecs"
    echo "  21. Main Repository Codecs"
    echo ""
    echo "G. Fixes And Tweaks"
    echo "  22. Fix Missing Fonts"
    echo ""
    echo "H. Package Installation"
    echo "  23. Cockpit"
    echo "  24. Gaming Packages"
    echo "  25. GitHub Desktop"
    echo "  26. JetBrains Toolbox"
    echo "  27. System Utilities"
    echo "  28. Visual Studio Code"
    echo "  29. Warp Terminal"
    echo ""
}

selection_menu_footer()
{
    echo "0. Exit"
    echo "?. Help"
    echo ""
    echo "Choose an option: "
}

script_info_version
selection_menu_common
selection_menu_distro_openSUSE
selection_menu_footer