#!/usr/bin/env bash
# Installs and sets up steam

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_STEAM ]]; then
    echo "Neither INC_FLATPAK or INC_STEAM is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install steam flatpak"
flatpak install -y --noninteractive com.valvesoftware.Steam
