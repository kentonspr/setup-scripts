#!/usr/bin/env bash
# Installs and configures the dash-to-dock extension

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_DASHTODOCK ]]; then
    echo "INC_DASHTODOCK is not set. Skipping 71-dashtodock.sh"
    exit 0
fi

export SASS=dart
REPO="https://github.com/micheleg/dash-to-dock.git"
REPODIR="${CODEDIR}/public/dash-to-dock@micxgx.gmail.com"

echo "Cloning repo"
git clone --depth 1 -- ${REPO} ${REPODIR}

echo "Building dash-to-dock"
cd ${REPODIR}
make
make install

echo "Changing default settings"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height 'false'
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size '32'

echo "Enabling dash-to-dock"
gnome-extensions enable dash-to-dock@micxgx.gmail.com

