#!/usr/bin/env bash
# Sets gnome settings and extensions for user

if [[ ! $INC_GNOME ]]; then
    echo "INC_GNOME is not set. Skipping 80-gnome.sh"
    exit 0
fi

echo "Configuring gnome settings"
# Fonts -
gsettings set org.gnome.desktop.interface font-name 'Source Sans Pro Regular 11'
gsettings set org.gnome.desktop.interface document-font-name 'Source Sans Pro Regular 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11'

# Desktop - 
# TODO - Wallpaper maybe?
# gsettings set org.gnome.desktop.background picture-uri ''
# Options below - none, wallpaper, centered, scaled, stretched, zoomed, spanned
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.background show-desktop-icons 'false'

