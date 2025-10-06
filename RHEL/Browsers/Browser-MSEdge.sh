#!/bin/bash

# Import Microsoft’s GPG key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Add Edge repo
cat <<EOF | sudo tee /etc/yum.repos.d/microsoft-edge.repo
[microsoft-edge]
name=Microsoft Edge
baseurl=https://packages.microsoft.com/yumrepos/edge
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Install Edge Stable
sudo dnf install microsoft-edge-stable -y
