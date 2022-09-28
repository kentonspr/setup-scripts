#!/usr/bin/env bash
# Installs and sets up transmissionbt

if [[ $SKIP_FLATPAK ]] || [[ $SKIP_TBT ]]; then
    echo "SKIP_TBT is set. Skipping 31-transmission.sh"
    exit 0
fi

echo "Install transmissionsbt flatpak"
flatpak install flathub com.transmissionbt.Transmission
