#!/usr/bin/env bash

if [[ ! $INC_NITRO ]]; then
    echo "INC_NITRO is not set. Skipping 13-nitrokey-luks.sh"
    exit 0
fi

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
SCRIPT_URL="https://raw.githubusercontent.com/daringer/smartcard-key-luks/main/smartcard-key-luks"
# GPG_PIN=$(sops -d --extract '["nk_user_pin"]' ${FILESDIR}/all/vault.sops.yml)

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Ensuring installed dependencies"
    sudo dnf install opensc gnupg2 gnupg2-smime
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Ensuring installed dependencies"
    sudo apt install -y scdaemon opensc gnupg2
fi

LUKS=$(sudo cat /etc/crypttab | grep luks | awk -F' ' '{print $1}')
echo "Found LUKS device ${LUKS}"

echo "Retrieving smartcard LUKS script"
curl -O --output-dir ${TMPDIR} ${SCRIPT_URL}

# echo "Modifying script to accept programmatic PIN"

# sed -i '/for pb in $PUBKEYS/i eval $(gpg-agent --homedir ${GNUPGHOME} --daemon --allow-loopback-pinentry)' ${TMPDIR}/smartcard-key-luks

# sed -i 's#  gpg2 --homedir ${GNUPGHOME} --trust-model=always -o ${CRYPTHOME}/cryptkey.gpg $GPG_RECIPIENT --yes --encrypt ${TMPKEY}#  gpg2 --homedir ${GNUPGHOME} --trust-model=always --pinentry-mode=loopback --passphrase=${GPG_PIN} -o ${CRYPTHOME}/cryptkey.gpg $GPG_RECIPIENT --yes --encrypt ${TMPKEY}#g' ${TMPDIR}/smartcard-key-luks

chmod +x ${TMPDIR}/smartcard-key-luks
sudo -E ${TMPDIR}/smartcard-key-luks ${LUKS} ${FILESDIR}/pgp_keys/${PGP_PUBKEY_FILE}
