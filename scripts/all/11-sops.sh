#!/usr/bin/env bash
# Install sops to use with vaulted passwords

echo -e "\n### sops ###\n"

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_SOPS ]]; then
    echo "INC_SOPS is not set. Skipping 11-sops.sh"
    exit 0
fi

GITHUB_OUTPUT=$(curl -s https://api.github.com/repositories/40684033/releases/latest)

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Ensuring installed dependencies"
    sudo dnf install -y curl jq

    FILE=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .name' \
              <<< $GITHUB_OUTPUT)
    URL=$(jq -r '.assets[] | select(.name | endswith("86_64.rpm")) .browser_download_url' \
             <<< $GITHUB_OUTPUT)

    echo "Downloading SOPS from $URL"
    curl -LO --output-dir $TMPDIR $URL

    echo "Installing $FILE"
    sudo dnf install -y ./$FILE

    exit 0
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Ensuring installed dependencies"
    sudo apt install -y curl jq

    FILE=$(jq -r '.assets[] | select(.name | endswith("amd64.deb")) .name' \
              <<< $GITHUB_OUTPUT)
    URL=$(jq -r '.assets[] | select(.name | endswith("amd64.deb")) .browser_download_url' \
             <<< $GITHUB_OUTPUT)

    echo "Downloading SOPS from $URL"
    curl -LO --output-dir ${TMPDIR} ${URL}

    echo "Installing $FILE"
    sudo dpkg -i ${TMPDIR}/${FILE}

    exit 0
fi


