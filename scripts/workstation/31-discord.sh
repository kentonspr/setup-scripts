#!/usr/bin/env bash
# Installs and sets up discord

if [[ ! $INC_FLATPAK ]] || [[ ! $INC_DISCORD ]]; then
    echo "Neither INC_FLATPAK or INC_DISCORD is set. Skipping 31-bitwarden.sh"
    exit 0
fi

echo "Install discord flatpak"
flatpak install -y --noninteractive com.discordapp.Discord
