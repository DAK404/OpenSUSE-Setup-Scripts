#!/bin/bash

############################################################
# System Auto Updates Script
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Tweak-SysAutoUpdate.sh)"
#
############################################################

# Set the script name
SCRIPT_NAME="Timely-Update.sh"

# Script content
SCRIPT_CONTENT='#!/bin/bash
zypper refresh
zypper dup -y'

# Service name (without .service suffix)
SERVICE_NAME="TW-Update"

# Systemd-compatible service filename
SERVICE_FILENAME="$SERVICE_NAME.service"

# Systemd-compatible timer filename
TIMER_FILENAME="$SERVICE_NAME.timer"

# Display-friendly service description
SERVICE_DESCRIPTION="OpenSUSE Tumbleweed Distribution Update"

# Service file content
SERVICE_CONTENT="[Unit]
Description=$SERVICE_DESCRIPTION
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
User=root
ExecStart=/usr/local/bin/$SCRIPT_NAME"
NoNewPrivileges=no

# Timer file content
TIMER_CONTENT="[Unit]
Description=Run $SERVICE_DESCRIPTION Every 1st Day Of The Month

[Timer]
OnCalendar=*-*-01 03:00:00
Persistent=true

[Install]
WantedBy=timers.target"

# Script directory
SCRIPT_DIR="/usr/local/bin"

# Service and Timer directory
SYSTEMD_DIR="/etc/systemd/system"

# Function to create and configure files
setup_automation() {
  # Create the script file
  sudo tee "$SCRIPT_DIR/$SCRIPT_NAME" > /dev/null <<EOF
$SCRIPT_CONTENT
EOF
  echo "Created script file: $SCRIPT_DIR/$SCRIPT_NAME"

  # Make the script executable
  sudo chmod +x "$SCRIPT_DIR/$SCRIPT_NAME"
  echo "Made script executable"

  # Create the service file
  sudo tee "$SYSTEMD_DIR/$SERVICE_FILENAME" > /dev/null <<EOF
$SERVICE_CONTENT
EOF
  echo "Created service file: $SYSTEMD_DIR/$SERVICE_FILENAME"

  # Create the timer file
  sudo tee "$SYSTEMD_DIR/$TIMER_FILENAME" > /dev/null <<EOF
$TIMER_CONTENT
EOF
  echo "Created timer file: $SYSTEMD_DIR/$TIMER_FILENAME"

  # Enable the timer
  sudo systemctl enable "$TIMER_FILENAME"
  echo "Enabled timer: $TIMER_FILENAME"

  # Start the timer
  sudo systemctl start "$TIMER_FILENAME"
  echo "Started timer: $TIMER_FILENAME"

  # Reload systemd daemon
  sudo systemctl daemon-reload
  echo "Reloaded systemd daemon"

  # Display timer status
  echo "Timer Status:"
  sudo systemctl status "$TIMER_FILENAME"

  # Display timer logs
  echo "Timer Logs:"
  sudo journalctl -u "$TIMER_FILENAME"
}

# Run the setup
setup_automation

echo "Automated setup complete."
