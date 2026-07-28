#!/bin/bash

# Enable the pipewire user services to allow the startup sound to play on KDE plasma 6 
systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
