#!/usr/bin/env bash

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Ensuring installed dependencies"
    sudo dnf install opensc gnupg2 gnupg2-smime
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    echo "Ensuring installed dependencies"
    sudo apt install -y scdaemon opensc gnupg2
fi

echo -e "\nImporting GPG Pub Key"
gpg --import ${FILESDIR}/pgp_keys/kenton_digaida_com_pub.asc
gpg --card-status
gpg --list-secret-keys
