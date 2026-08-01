#!/bin/bash

############################################################
# System Auto Updates Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
#
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Tweak-SysAutoUpdate.sh)"
#
############################################################

set -euo pipefail

# ------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------

SCRIPT_NAME="Timely-Update.sh"
SERVICE_NAME="TW-Update"

SCRIPT_DIR="/usr/local/bin"
SYSTEMD_DIR="/etc/systemd/system"

SERVICE_FILENAME="${SERVICE_NAME}.service"
TIMER_FILENAME="${SERVICE_NAME}.timer"

SERVICE_DESCRIPTION="OpenSUSE Tumbleweed Distribution Update"

# ------------------------------------------------------------------
# Update Script
# ------------------------------------------------------------------

SCRIPT_CONTENT='#!/bin/bash
set -euo pipefail

echo "[$(date)] Starting monthly update..."

zypper refresh
zypper dup --non-interactive
flatpak update -y

echo "[$(date)] Monthly update completed."
'

# ------------------------------------------------------------------
# Service Unit
# ------------------------------------------------------------------

SERVICE_CONTENT="[Unit]
Description=$SERVICE_DESCRIPTION
After=network-online.target graphical.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=$SCRIPT_DIR/$SCRIPT_NAME"

# ------------------------------------------------------------------
# Timer Unit
# ------------------------------------------------------------------

TIMER_CONTENT="[Unit]
Description=Run $SERVICE_DESCRIPTION Every 1st Day Of The Month

[Timer]
OnCalendar=*-*-01 03:00:00
RandomizedDelaySec=30m
Persistent=true
Unit=$SERVICE_FILENAME

[Install]
WantedBy=timers.target"

# ------------------------------------------------------------------
# Installation
# ------------------------------------------------------------------

setup_automation() {

    echo "Installing monthly update automation..."

    sudo mkdir -p "$SCRIPT_DIR"

    sudo tee "$SCRIPT_DIR/$SCRIPT_NAME" >/dev/null <<EOF
$SCRIPT_CONTENT
EOF

    sudo chmod +x "$SCRIPT_DIR/$SCRIPT_NAME"

    sudo tee "$SYSTEMD_DIR/$SERVICE_FILENAME" >/dev/null <<EOF
$SERVICE_CONTENT
EOF

    sudo tee "$SYSTEMD_DIR/$TIMER_FILENAME" >/dev/null <<EOF
$TIMER_CONTENT
EOF

    sudo systemctl disable --now "$TIMER_FILENAME" 2>/dev/null || true

    sudo systemctl daemon-reload

    sudo systemd-analyze verify \
        "$SYSTEMD_DIR/$SERVICE_FILENAME" \
        "$SYSTEMD_DIR/$TIMER_FILENAME"

    sudo systemctl enable --now "$TIMER_FILENAME"

    echo
    echo "Timer Status"
    echo "============"

    sudo systemctl status "$TIMER_FILENAME" --no-pager

    echo
    echo "Next Scheduled Run"
    echo "=================="

    systemctl list-timers "$TIMER_FILENAME"

    echo
    echo "Recent Timer Logs"
    echo "================="

    sudo journalctl -u "$TIMER_FILENAME" -n 20 --no-pager

    echo
    echo "[ INFORMATION ] System Auto Update Script Setup Complete"
}

setup_automation
