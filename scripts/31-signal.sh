#!/usr/bin/env bash
# Installs and sets up signal

if [ -n ${SKIP_FLATPAK} ] || [ -n ${SKIP_SIGNAL} ]; then
    echo "SKIP_SIGNAL is set. Skipping 31-signal.sh"
    exit 0
fi

echo "Install signal flatpak"
flatpak install flathub org.signal.Signal
