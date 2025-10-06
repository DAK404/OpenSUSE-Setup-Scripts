#!/bin/bash
set -euo pipefail

add_mdns_firewalld()
{
    sudo systemctl start firewalld
    sudo firewall-cmd --permanent --zone=public --add-service=mdns
    sudo firewall-cmd --permanent --zone=external --add-service=mdns
    sudo firewall-cmd --reload
    echo "[ INFORMATION ] mDNS Firewall Rules Added (firewalld)"
}

add_mdns_ufw()
{
    # Avahi (mDNS) uses UDP 5353
    sudo ufw allow 5353/udp comment 'mDNS'
    echo "[ INFORMATION ] mDNS Firewall Rules Added (ufw)"
}

if command -v firewall-cmd &>/dev/null && systemctl is-active --quiet firewalld; then
    add_mdns_firewalld
elif command -v ufw &>/dev/null; then
    add_mdns_ufw
else
    echo "[ ERROR ] No supported firewall (firewalld or ufw) detected." >&2
    exit 1
fi
