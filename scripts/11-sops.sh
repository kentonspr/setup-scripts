#!/usr/bin/env bash
# Install sops to use with vaulted passwords

if [ -n ${SKIP_SOPS} ]; then
    echo "SKIP_SOPS is set. Skipping 11-sops.sh"
    exit 0
fi

$SOPS_OUTPUT=$(curl -s https://api.github.com/repos/mozilla/sops/releases/latest) 
mkdir $TMPDIR/sops && cd $TMPDIR/sops

if [ "$OSNAME" = "Fedora Linux"]; then
    echo "Ensuring installed dependencies"
    sudo dnf install curl jq

    FILE=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .name' \
              <<< $SOPS_OUTPUT)
    URL=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .browser_download_url' \
             <<< $SOPS_OUTPUT)

    echo "Downloading SOPS from $URL"
    curl -LO $URL

    echo "Installing $FILE"
    sudo dnf install ./$FILE

    exit 0
fi

if [ "$OSNAME" = "Ubuntu"]; then
    echo "Ensuring installed dependencies"
    sudo apt install curl jq

    FILE=$(jq -r '.assets[] | select(.name | endswith("amd64.deb")) .name' \
              <<< $SOPS_OUTPUT)
    URL=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .browser_download_url' \
             <<< $SOPS_OUTPUT)

    echo "Downloading SOPS from $URL"
    curl -LO $URL

    echo "Installing $FILE"
    sudo apt install ./$FILE

    exit 0
fi


