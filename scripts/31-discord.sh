#!/usr/bin/env bash
# Installs and sets up discord

if [[ $SKIP_FLATPAK ]] || [[ $SKIP_DISCORD ]]; then
    echo "SKIP_DISCORD is set. Skipping 31-discord.sh"
    exit 0
fi

echo "Install discord flatpak"
flatpak install -y --noninteractive com.discordapp.Discord
