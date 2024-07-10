#!/bin/bash

# Just following the steps outlined in OpenRGB GitLab repository
# https://gitlab.com/CalcProgrammer1/OpenRGB
sudo modprobe i2c-dev
sudo groupadd --system i2c
sudo usermod $USER -aG i2c
sudo touch /etc/modules-load.d/i2c.conf && sudo sh -c 'echo "i2c-dev" >> /etc/modules-load.d/i2c.conf'

# --- AMD CHIPSETS --- #
# WARNING! This will configure the system to load the i2c driver for AMD configurations only!
sudo modprobe i2c-piix4

# !ATTENTION! #
# In case RAM RGB or other LED controllers are not loading the profile on startup, you need to add the entries manually.
# This is out of scope due to the numerous configurations and boards that are out there.

# --- INTEL CHIPSETS --- #

# UNTESTED! Here is the configuration required for Intel motherboards/chipsets. Use at your own risk.
# sudo modprobe i2c-i801
# sudo modprobe i2c-nct6775
