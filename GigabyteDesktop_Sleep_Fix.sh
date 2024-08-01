#!/bin/bash

############################################################
# Sleep/Wakeup Fix For Gigabyte Motherboards
#
# ----------------------------------------------------------
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/GigabyteDesktop_Sleep_Fix.sh)"
#
# ----------------------------------------------------------
#
# --- CHANGELOG ---
#
# 1.0 (19-July-2024):
#    * Bump version to 1.0
############################################################

sudo cat > /etc/systemd/system/biosWakeupWorkaround.service << EOL
[Unit]
Description=Workaround for Gigabyte BIOS sleep/wakeup bug

[Service]
Type=oneshot
ExecStart=/bin/sh -c "echo GPP0 > /proc/acpi/wakeup"

[Install]
WantedBy = multi-user.target
EOL

sudo systemctl daemon-reload && sudo systemctl enable biosWakeupWorkaround.service
