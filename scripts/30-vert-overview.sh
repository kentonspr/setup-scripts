#!/usr/bin/env bash

if [[ $SKIP_VERT_OVERVIEW ]]; then
    echo "SKIP_VERT_OVERVIEW is set. Skipping 30-vert-overview.sh"
    exit 0
fi

REPO="https://github.com/RensAlthuis/vertical-overview.git"
REPODIR=${HOME}/.local/share/gnome-shell/extensions/vertical-overeview

echo "Cloning repo"
git clone --depth 1 -- ${REPO} {REPODIR}

echo "Building and installing"
cd ${REPODIR}
make
make install

echo "Enabling extension"
gnome-extensions enable vertical-overview@RensAlthuis.github.com
