#!/bin/bash
# Redirecting to new script location

echo "[  WARNING  ] THIS SCRIPT HAS BEEN MOVED! CHECK THE 'SCRIPTLETS/FIXES-AND-TWEAKS' DIRECTORY FOR THE NEW LOCATION!"
echo "This script will work. But it is recommended to use the new location."
exec bash <(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Fix-GigabyteDesktopSleepFix.sh)
