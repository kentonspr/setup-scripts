#!/usr/bin/env bash
# Installs and sets up bitwarden

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_BITWARDEN ]]; then
    echo "Neither INC_FLATPAK or INC_BITWARDED is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install bitwarden flatpak"
flatpak install -y --noninteractive com.bitwarden.desktop
