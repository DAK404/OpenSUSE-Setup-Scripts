#!/bin/bash

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
