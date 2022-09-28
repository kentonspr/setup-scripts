#!/usr/bin/env bash

if [ -n ${SKIP_NITRO} ]; then
    echo "SKIP_NITRO is set. Skipping 13-nitrokey-luks.sh"
    exit 0
fi

SCRIPT_URL="https://raw.githubusercontent.com/daringer/smartcard-key-luks/main/smartcard-key-luks"

if [ "$OSNAME" = "Fedora Linux"]; then
    echo "Ensuring installed dependencies"
    sudo dnf install opensc gnupg2 gnupg2-smime
    exit 0
fi

if [ "$OSNAME" = "Ubuntu"]; then
    echo "Ensuring installed dependencies"
    sudo apt install scdaemon opensc gnupg2
    exit 0
fi

LUKS_DEVICE=$(cat /etc/crypttab | awk -F' ' '{print $1}')
echo "Found LUKS device ${LUKS}_DEVICE"

echo "Retrieving smartcard LUKS script"
curl -O --output-dir ${TMPDIR} ${SCRIPT_URL}
sudo chmod +x ${TMPDIR}/smartcard-key-luks

${TMPDIR}/smartcard-key-luks ${LUKS} ${FILESDIR}/pgp_keys/${PGP_PUBKEY_FILE}
