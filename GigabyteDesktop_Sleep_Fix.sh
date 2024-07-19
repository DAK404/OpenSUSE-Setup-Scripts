#!/bin/bash

############################################################
# Sleep/Wakeup Fix For Gigabyte Motherboards
# Version 1.0
# Date Modified: 19-July-2024
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
