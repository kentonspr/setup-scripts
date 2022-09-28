#!/usr/bin/env bash
# Installs and sets up transmissionbt

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_TBT} ]; then
    echo "SKIP_TBT is set. Skipping 31-transmission.sh"
    exit 0
fi

echo "Install transmissionsbt flatpak"
flatpak install flathub com.transmissionbt.Transmission
