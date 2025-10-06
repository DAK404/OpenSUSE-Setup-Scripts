#!/bin/bash

rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
zypper addrepo https://brave-browser-rpm-release.s3.brave.com/x86_64/ brave-browser
zypper --gpg-auto-import-keys refresh
zypper install -y brave-browser