#!/usr/bin/env bash

if [[ ! $INC_NITRO ]]; then
    echo "INC_NITRO is not set. Skipping 13-nitrokey-luks.sh"
    exit 0
fi

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")
SCRIPT=${TMPDIR}/smarcard_key_luks
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
echo "Found LUKS device ${LUKS}"

echo "Retrieving smartcard LUKS script"
curl -O --output-dir ${TMPDIR} ${SCRIPT_URL}
chmod +x ${SCRIPT}


GPG_PIN=$(sops -d --extract '["nk_user_pin"]' ${FILESDIR}/all/vault.sops.yml)

echo "Modifying script to accept programmatic PIN"
SEARCH="  gpg2 --homedir ${GNUPGHOME} --trust-model=always -o ${CRYPTHOME}/cryptkey.gpg $GPG_RECIPIENT --yes --encrypt ${TMPKEY}"
REPLACE="  gpg2 --homedir ${GNUPGHOME} --trust-model=always --pinentry-mode=loopback --passphrase=${GPG_PIN} -o ${CRYPTHOME}/cryptkey.gpg $GPG_RECIPIENT --yes --encrypt ${TMPKEY}"
SEARCH_ESCAPED=$(sed 's/[^^]/[&]/g; s/\^/\\^/g' <<<"$SEARCH")
REPLACE_ESCAPED=$(sed 's/[^^]/[&]/g; s/\^/\\^/g' <<<"$REPLACE")

sed -n "s/$SEARCH_ESCAPED/$REPLACE_ESCAPED/g" ${SCRIPT}

sudo -E ${SCRIPT} ${LUKS} ${FILESDIR}/pgp_keys/${PGP_PUBKEY_FILE}
