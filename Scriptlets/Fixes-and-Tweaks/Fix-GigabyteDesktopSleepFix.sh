#!/bin/bash

############################################################
# Sleep/Wakeup Fix For Gigabyte Motherboards
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Fix-GigabyteDesktopSleepFix.sh)"
#
############################################################

cat > /etc/systemd/system/biosWakeupWorkaround.service << EOL
[Unit]
Description=Workaround for Gigabyte BIOS sleep/wakeup bug

[Service]
Type=oneshot
ExecStart = /bin/sh -c 'if grep 'GPP0' /proc/acpi/wakeup | grep -q 'enabled'; then echo 'GPP0' > /proc/acpi/wakeup; fi'

[Install]
WantedBy = multi-user.target
EOL

systemctl daemon-reload && systemctl enable biosWakeupWorkaround.service
