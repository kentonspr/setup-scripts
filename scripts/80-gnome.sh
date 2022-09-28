#!/usr/bin/env bash
# Sets gnome settings and extensions for user

if [ -n ${SKIP_GNOME} ]; then
    echo "SKIP_GNOME is set. Skipping 80-gnome.sh"
    exit 0
fi

echo "Configuring gnome settings"
echo "Fonts -"
gsettings set org.gnome.desktop.interface font-name 'Source Sans Pro Regular 11'
gsettings set org.gnome.desktop.interface document-font-name 'Source Sans Pro Regular 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11'

echo "Desktop -"
# TODO - Wallpaper maybe?
# gsettings set org.gnome.desktop.background picture-uri ''
# Options below - none, wallpaper, centered, scaled, stretched, zoomed, spanned
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.background show-desktop-icons 'false'

