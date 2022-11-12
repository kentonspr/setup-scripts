#!/usr/bin/env bash
# Installs and sets up ghex

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_GHEX ]]; then
    echo "Neither INC_FLATPAK or INC_GHEX is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install ghex flatpak"
flatpak install -y --noninteractive org.gnome.GHex
