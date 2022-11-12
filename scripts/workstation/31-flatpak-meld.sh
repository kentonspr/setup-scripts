#!/usr/bin/env bash
# Installs and sets up meld

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_MELD ]]; then
    echo "Neither INC_FLATPAK or INC_MELD is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install meld flatpak"
flatpak install -y --noninteractive org.gnome.meld
