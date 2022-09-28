#!/usr/bin/env bash
# Installs and sets up signal

if [[ $SKIP_FLATPAK ]] || [[ $SKIP_SIGNAL ]]; then
    echo "SKIP_SIGNAL is set. Skipping 31-signal.sh"
    exit 0
fi

echo "Install signal flatpak"
flatpak install flathub org.signal.Signal
