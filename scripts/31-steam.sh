#!/usr/bin/env bash
# Installs and sets up steam

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_STEAM} ]; then
    echo "SKIP_STEAM is set. Skipping 31-steam.sh"
    exit 0
fi

echo "Install steam flatpak"
flatpak install flathub com.valvesoftware.Steam
