#!/usr/bin/env bash

echo -e "\n### NitroKey PGP ###\n"

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Ensuring installed dependencies"
    sudo dnf install opensc gnupg2 gnupg2-smime
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Ensuring installed dependencies"
    sudo apt install -y scdaemon opensc gnupg2
fi

echo -e "\n--- Importing GPG Pub Key ---\n"
gpg --import ${FILESDIR}/pgp_keys/kenton_digaida_com_pub.asc
gpg --card-status
gpg --list-secret-keys

echo -e "\n--- Run verify command then quit to trigger pineentry ---\n"
gpg --card-edit
