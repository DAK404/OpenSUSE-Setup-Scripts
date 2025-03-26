#!/bin/bash

############################################################
# Codecs Installation from Packman Repositories
#
# ATTENTION!
# This script can be run in a single line from your shell!
# Simply run the following in the Terminal:
#
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/DAK404/OpenSUSE-Setup-Scripts/main/Scriptlets/Codecs/Codecs-opi.sh)"
#
############################################################

zypper in -y opi
opi -n codecs