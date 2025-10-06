#!/bin/bash

# Add Google's signing key
sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub

# Create the repo file
cat <<EOF | sudo tee /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=Google Chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

# Install Chrome
sudo dnf install google-chrome-stable -y
