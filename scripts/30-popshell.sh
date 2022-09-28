#!/usr/bin/env bash
# Installs and configures pop-shell for gnome

if [[ $SKIP_POPSHELL ]]; then
    echo "SKIP_POPSHELL is set. Skipping 30-popshell.sh"
    exit 0
fi

REPO="https://github.com/pop-os/shell.git"
REPODIR=${CODEDIR}/public/pop-shell

echo "Installing pop-shell"
if [ "$OSNAME" = "Fedora Linux" ]; then
    sudo dnf install -y gnome-shell-extension-pop-shell
fi

if [ "$OSNAME" = "Ubuntu" ]; then
    sudo apt install -y git node-typescript make
    git clone --depth 1 -- ${REPO} ${REPODIR}

    cd ${REPODIR}
    make local-install
fi

echo "Configuring gnome settings for pop-shell"
gsettings set org.gnome.shell.extensions.pop-shell active-hint 'true'
gsettings set org.gnome.shell.extensions.pop-shell tile-by-default 'true'
gsettings set org.gnome.shell.extensions.pop-shell gap-inner '4'
gsettings set org.gnome.shell.extensions.pop-shell gap-outer '4'
