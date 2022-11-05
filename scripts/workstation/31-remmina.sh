#!/usr/bin/env bash
# Installs and sets up remmina

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_REMMINA ]]; then
    echo "Neither INC_FLATPAK or INC_REMMINA is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install remmina flatpak"
flatpak install -y --noninteractive org.remmina.Remmina
