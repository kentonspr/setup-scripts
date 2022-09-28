#!/usr/bin/env bash
# Installs and sets up meld

if [[ $SKIP_FLATPAK ]] || [[ $SKIP_MELD ]]; then
    echo "SKIP_MELD is set. Skipping 31-meld.sh"
    exit 0
fi

echo "Install meld flatpak"
flatpak install flathub com.gnome.meld
