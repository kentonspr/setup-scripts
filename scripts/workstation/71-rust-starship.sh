#!/usr/bin/env bash
# Installs and configures starship prompt

if [[ ! $INC_RUST ]] || [[ ! $INC_ALACRITTY ]]; then
    echo "INC_ALACRITTY is not set. Skipping 71-alacritty.sh"
    exit 0
fi

cargo install starship --locked
