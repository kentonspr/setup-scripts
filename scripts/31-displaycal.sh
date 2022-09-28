#!/usr/bin/env bash
# Installs and sets up displaycal

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_DCAL} ]; then
    echo "SKIP_DCAL is set. Skipping 31-displaycal.sh"
    exit 0
fi

echo "Install displaycal flatpak"
flatpak install flathub net.displaycal.DisplayCAL
