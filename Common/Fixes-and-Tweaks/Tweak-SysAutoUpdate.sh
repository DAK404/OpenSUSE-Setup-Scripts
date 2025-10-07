#!/usr/bin/env bash

set -euo pipefail

detect_os() {
    if grep -qi "opensuse" /etc/os-release; then
        # INSERT OPENSUSE SPECIFIC AUTO-UPDATE SCRIPT
    elif grep -qi "kubuntu" /etc/os-release; then
        # INSERT KUBUNTU SPECIFIC AUTO-UPDATE SCRIPT
    elif grep -qi "rocky" /etc/os-release; then
        # INSERT ROCKY SPECIFIC AUTO-UPDATE SCRIPT
    else
        echo "Unsupported or unknown OS"
        return 1
    fi
}

detect_os

# INSERT THE COMMON SYSTEMD AUTO-UPDATE SCRIPTS