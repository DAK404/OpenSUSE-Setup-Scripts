#!/bin/bash

# Install Cockpit and Myrlyn packages
zypper in patterns-cockpit myrlyn

# Enable cockpit
systemctl enable --now cockpit.socket

# Add Cockpit to the firewall to be able to access the tool
sudo firewall-cmd --permanent --zone=public --add-service=cockpit
sudo firewall-cmd --reload

echo "Now, go to https://localhost:9090 to access Cockpit."
