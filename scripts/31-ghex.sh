#!/usr/bin/env bash
# Installs and sets up ghex

if [[ $SKIP_FLATPAK ]] || [[ $SKIP_GHEX ]]; then
    echo "SKIP_GHEX is set. Skipping 31-ghex.sh"
    exit 0
fi

echo "Install ghex flatpak"
flatpak install -y --noninteractive com.gnome.GHex
