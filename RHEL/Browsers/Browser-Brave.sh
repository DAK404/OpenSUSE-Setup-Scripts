#!/bin/bash

# Import Brave’s GPG key
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

# Add Brave repo
cat <<EOF | sudo tee /etc/yum.repos.d/brave-browser.repo
[brave-browser]
name=Brave Browser
baseurl=https://brave-browser-rpm-release.s3.brave.com/\$basearch/
enabled=1
gpgcheck=1
gpgkey=https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
EOF

# Install Brave
sudo dnf install brave-browser -y
