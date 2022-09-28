#!/usr/bin/env bash
# Installs and sets up ghex

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_GHEX} ]; then
    echo "SKIP_GHEX is set. Skipping 31-ghex.sh"
    exit 0
fi

echo "Install ghex flatpak"
flatpak install flathub com.gnome.GHex
