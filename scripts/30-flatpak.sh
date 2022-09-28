#!/usr/bin/env bash
# Installs flatpak it not already installed
# Shouldn't be needed on fedora

if [[ $SKIP_FLATPAK ]]; then
    echo "SKIP_FLATPAK is set. Skipping 30-flatpak.sh"
    exit 0
fi

if [ "$OSNAME" = "Ubuntu" ]; then
    echo "Install flatpak"
    sudp apt install flatpak gnome-software-plugin-flatpak

    echo "Install flathub"
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    exit 0
fi
