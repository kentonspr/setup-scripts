#!/usr/bin/env bash
# Installs and sets up remmina

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_REMMINA} ]; then
    echo "SKIP_REMMINA is set. Skipping 31-remmina.sh"
    exit 0
fi

echo "Install remmina flatpak"
flatpak install flathub org.remmina.Remmina
