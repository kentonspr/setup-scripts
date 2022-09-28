#!/usr/bin/env bash
# Installs and sets up displaycal

if [[ $SKIP_FLATPAK ]] || [[ $SKIP_DCAL ]]; then
    echo "SKIP_DCAL is set. Skipping 31-displaycal.sh"
    exit 0
fi

echo "Install displaycal flatpak"
flatpak install -y --noninteractive net.displaycal.DisplayCAL
