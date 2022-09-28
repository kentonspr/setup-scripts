#!/usr/bin/env bash
# Installs and sets up meld

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_MELD} ]; then
    echo "SKIP_MELD is set. Skipping 31-meld.sh"
    exit 0
fi

echo "Install meld flatpak"
flatpak install flathub com.gnome.meld
