#!/usr/bin/env bash
# Install sops to use with vaulted passwords

: ${OSNAME:=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")}
: ${TMPDIR:="${HOME}/.tmp/setup"}

if [[ $SKIP_SOPS ]]; then
    echo "SKIP_SOPS is set. Skipping 11-sops.sh"
    exit 0
fi

SOPS_OUTPUT=$(curl -s https://api.github.com/repos/mozilla/sops/releases/latest) 
cd $TMPDIR

if [[ "$OSNAME" = "Fedora Linux" ]]; then
    echo "Ensuring installed dependencies"
    sudo dnf install -y curl jq

    FILE=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .name' \
              <<< $SOPS_OUTPUT)
    URL=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .browser_download_url' \
             <<< $SOPS_OUTPUT)

    echo "Downloading SOPS from $URL"
    curl -LO $URL

    echo "Installing $FILE"
    sudo dnf install -y ./$FILE

    exit 0
fi

if [[ "$OSNAME" = "Ubuntu" ]] || [[ "$OSNAME" = "Pop!_OS" ]]; then
    echo "Ensuring installed dependencies"
    sudo apt install -y curl jq

    FILE=$(jq -r '.assets[] | select(.name | endswith("amd64.deb")) .name' \
              <<< $SOPS_OUTPUT)
    URL=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .browser_download_url' \
             <<< $SOPS_OUTPUT)

    echo "Downloading SOPS from $URL"
    curl -LO $URL

    echo "Installing $FILE"
    sudo apt install -y ./$FILE

    exit 0
fi


