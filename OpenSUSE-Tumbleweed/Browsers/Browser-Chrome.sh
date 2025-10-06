#!/bin/bash

rpm --import https://dl.google.com/linux/linux_signing_key.pub
zypper addrepo --refresh https://dl.google.com/linux/chrome/rpm/stable/x86_64 google-chrome
zypper --gpg-auto-import-keys refresh 
zypper install -y google-chrome-stable