#!/bin/bash

rpm --import https://releases.warp.dev/linux/keys/warp.asc
zypper addrepo https://releases.warp.dev/linux/rpm/stable warpdotdev
zypper install -y warp-terminal
