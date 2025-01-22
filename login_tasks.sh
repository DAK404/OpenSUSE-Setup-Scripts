#!/bin/bash

############################################################
# Login Tasks Script
#
# --- CHANGELOG ---
#
# 1.0 (19-July-2024):
#    * Bump version to 1.0
############################################################

#remove the edge gpucache directory first
rm -r ../.config/microsoft-edge/Default/GPUCache

#remove the VSCode GPUCache directory
rm -r ../.config/Code/GPUCache
