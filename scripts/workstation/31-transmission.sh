#!/usr/bin/env bash
# Installs and sets up transmissionbt

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_TRANSMISSION ]]; then
    echo "Neither INC_FLATPAK or INC_TRANSMISSION is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install transmissionsbt flatpak"
flatpak install -y --noninteractive com.transmissionbt.Transmission
