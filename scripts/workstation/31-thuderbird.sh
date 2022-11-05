#!/usr/bin/env bash
# Installs and sets up thunderbird

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_THUNDERBIRD ]]; then
    echo "Neither INC_FLATPAK or INC_THUNDERBIRD is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install thunderbird flatpak"
flatpak install -y --noninteractive org.mozilla.Thunderbird
