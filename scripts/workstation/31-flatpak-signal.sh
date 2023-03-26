#!/usr/bin/env bash
# Installs and sets up signal

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_SIGNAL ]]; then
    echo "Neither INC_FLATPAK or INC_SIGNAL is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install signal flatpak"
flatpak install -y --noninteractive org.signal.Signal
