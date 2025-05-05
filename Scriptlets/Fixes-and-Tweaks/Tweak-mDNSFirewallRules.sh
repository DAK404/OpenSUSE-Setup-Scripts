#!/bin/bash

############################################################
# mdns Firewall Rules
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Fixes-and-Tweaks/Tweak-mdnsFirewallRules.sh)"
#
############################################################

sudo systemctl start firewalld

firewall-cmd --permanent --zone=public --add-service=mdns
firewall-cmd --permanent --zone=external --add-service=mdns
firewall-cmd --reload

echo "[ INFORMATION ] mDNS Firewall Rules Added"