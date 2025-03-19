#!/bin/bash

############################################################
# OpenRGB Configuration Script
#
# --- CHANGELOG ---
#
# 1.1 (28-July-2024):
#    * Move OpenRGB tools into OpenRGB.sh
#
# 1.0 (19-July-2024):
#    * Improve comments
#    * Segregated each step of installation
#    * echo each stage of script
############################################################

echo "[  ATTENTION  ] Installing: OpenRGB & Utilities"
# --- Install OpenRGB Tools --- #
zypper install -y OpenRGB i2c-tools

# Just following the steps outlined in OpenRGB Source Code
# https://gitlab.com/CalcProgrammer1/OpenRGB/-/tree/master/Documentation?ref_type=heads

# --- Load the i2c-dev kernel module --- #
echo "[ INFORMATION ] Loading i2c-dev Kernel Module"
modprobe i2c-dev

# --- Create a new system group called "i2c" ---"
echo "[ INFORMATION ] Creating new system group i2c"
groupadd --system i2c

# --- Add user to group to access the i2c devices --- #
echo "[ INFORMATION ] Adding user to group \'i2c\'"
usermod $USER -aG i2c

# --- Create config file to load the i2c module at boot --- #
echo "[ INFORMATION ] Configuring i2c-dev modules to load up at boot"
touch /etc/modules-load.d/i2c.conf && sh -c 'echo "i2c-dev" >> /etc/modules-load.d/i2c.conf'

# --- AMD CHIPSETS --- #
# WARNING! This will configure the system to load the i2c driver for AMD configurations only!
echo "[  ATTENTION  ] Loading i2c-piix4 for SMBus Access (AMD SPECIFIC)"
modprobe i2c-piix4

# --!ATTENTION!-- #
# In case RAM RGB or other LED controllers are not loading the profile on startup, you need to add the entries manually.
# This is out of scope due to the numerous configurations and boards that are out there.

# --- INTEL CHIPSETS --- #

# UNTESTED! Here is the configuration required for Intel motherboards/chipsets. Use at your own risk.
# echo "[  ATTENTION  ] Loading i2c-i801 & i2c-nct6775 for SMBus Access (INTEL SPECIFIC)"
# modprobe i2c-i801
# modprobe i2c-nct6775
