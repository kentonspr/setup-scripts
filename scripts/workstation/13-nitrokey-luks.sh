#!/usr/bin/env bash

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_NITRO ]]; then
    echo "INC_NITRO is not set. Skipping 13-nitrokey-luks.sh"
    exit 0
fi

SCRIPT_URL="https://raw.githubusercontent.com/daringer/smartcard-key-luks/main/smartcard-key-luks"

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Ensuring installed dependencies"
    sudo dnf install opensc gnupg2 gnupg2-smime
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Ensuring installed dependencies"
    sudo apt install -y scdaemon opensc gnupg2
fi

LUKS=$(sudo cat /etc/crypttab | grep luks | awk -F' ' '{print $1}')
echo "Found LUKS device ${LUKS}_DEVICE"

echo "Retrieving smartcard LUKS script"
curl -O --output-dir ${TMPDIR} ${SCRIPT_URL}
sudo chmod +x ${TMPDIR}/smartcard-key-luks

sudo ${TMPDIR}/smartcard-key-luks ${LUKS} ${FILESDIR}/pgp_keys/${PGP_PUBKEY_FILE}
