#!/usr/bin/env bash
# Installs and sets up displaycal

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_DISPLAYCAL ]]; then
    echo "Neither INC_FLATPAK or INC_DISPLAYCAL is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install displaycal flatpak"
flatpak install -y --noninteractive net.displaycal.DisplayCAL
