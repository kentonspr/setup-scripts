#!/usr/bin/env bash
# Installs and sets up bitwarden

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_BITWARDEN} ]; then
    echo "SKIP_FLATPAK is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install bitwarden flatpak"
flatpak install flathub com.bitwarden.desktop
