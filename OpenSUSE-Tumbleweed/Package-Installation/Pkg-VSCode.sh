#!/bin/bash

VSCODE_REPO_URL='https://packages.microsoft.com/yumrepos/vscode'
zypper --gpg-auto-import-keys addrepo --refresh "$VSCODE_REPO_URL" 'vscode'
zypper --gpg-auto-import-keys refresh
zypper install -y code