#!/usr/bin/env bash
# Installs and sets up thunderbird

if [[ $SKIP_FLATPAK ]] || [[ $SKIP_TBIRD ]]; then
    echo "SKIP_TBIRD is set. Skipping 31-thunderbird.sh"
    exit 0
fi

echo "Install thunderbird flatpak"
flatpak install flathub org.mozilla.Thunderbird
