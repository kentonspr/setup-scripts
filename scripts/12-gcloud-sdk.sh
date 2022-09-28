#!/usr/bin/env bash
# Script to install gcloud sdk

if [ -n ${SKIP_GCLOUD} ]; then
    echo "SKIP_GCLOUD is set. Skipping 12-gcloud-sdk.sh"
    exit 0
fi

if [ "$OSNAME" = "Fedora Linux"]; then
    echo "Adding Repo to DNF"
    sudo cp ${FILESDIR}/gcloudsdk/google-cloud-sdk.repo /etc/yum.repos.d/

    sudo dnf install google-cloud-cli
    exit 0
fi

if [ "$OSNAME" = "Ubuntu"]; then
    GPG_KEY_URL="https://packages.cloud.google.com/apt/doc/apt-key.gpg"
    echo "Adding Repo to APT"
    sudo cp ${FILESDIR}/gcloudsdk/google-cloud-sdk.list /etc/apt/sources.list.d/

    echo "Adding Repo Key"
    curl ${GPG_KEY_URL} | sudo tee /usr/share/keyrings/cloud.google.gpg

    sudo apt install apt-transport-https ca-certificates gnupg google-cloud-cli
    exit 0
fi

echo "Logging into gcloud SDK"
gcloud init

exit 0
