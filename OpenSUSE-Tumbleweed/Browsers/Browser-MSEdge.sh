#!/bin/bash

MSEDGE_REPO_URL='https://packages.microsoft.com/yumrepos/edge'
zypper --gpg-auto-import-keys addrepo --refresh "$MSEDGE_REPO_URL" 'microsoft-edge'
zypper --gpg-auto-import-keys refresh
zypper install -y microsoft-edge-stable