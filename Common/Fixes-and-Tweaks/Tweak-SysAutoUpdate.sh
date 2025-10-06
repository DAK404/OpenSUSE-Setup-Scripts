#!/bin/bash
set -euo pipefail

SCRIPT_NAME="SystemAutoUpdate.sh"
SERVICE_NAME="System-Auto-Update"
SERVICE_DESCRIPTION="Automatic System Distribution Update"

SCRIPT_DIR="/usr/local/bin"
SYSTEMD_DIR="/etc/systemd/system"

SERVICE_FILE="$SYSTEMD_DIR/$SERVICE_NAME.service"
TIMER_FILE="$SYSTEMD_DIR/$SERVICE_NAME.timer"

# Service definition
SERVICE_CONTENT="[Unit]
Description=$SERVICE_DESCRIPTION
After=network.target

[Service]
Type=oneshot
User=root
ExecStart=$SCRIPT_DIR/$SCRIPT_NAME
NoNewPrivileges=no"

# Timer definition
TIMER_CONTENT="[Unit]
Description=Run $SERVICE_DESCRIPTION Every 1st Day Of The Month

[Timer]
OnCalendar=*-*-01 03:00:00
Persistent=true

[Install]
WantedBy=timers.target"

setup_service_timer()
{
  if [[ ! -x "$SCRIPT_DIR/$SCRIPT_NAME" ]]; then
    echo "[ ERROR ] $SCRIPT_DIR/$SCRIPT_NAME not found or not executable."
    exit 1
  fi

  # Write service
  echo "$SERVICE_CONTENT" | sudo tee "$SERVICE_FILE" > /dev/null
  echo "Created service: $SERVICE_FILE"

  # Write timer
  echo "$TIMER_CONTENT" | sudo tee "$TIMER_FILE" > /dev/null
  echo "Created timer: $TIMER_FILE"

  # Reload, enable, start timer
  sudo systemctl daemon-reload
  sudo systemctl enable --now "$SERVICE_NAME.timer"

  echo "[ INFORMATION ] System auto update service + timer set up"
}

setup_service_timer
