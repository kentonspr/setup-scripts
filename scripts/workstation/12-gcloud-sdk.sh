#!/usr/bin/env bash
# Script to install gcloud sdk

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

if [[ ! $INC_GCLOUD ]]; then
    echo "INC_GCLOUD is not set. Skipping 12-gcloud-sdk.sh"
    exit 0
fi

if [[ $OSNAME = "Fedora Linux" ]]; then
    echo "Adding Repo to DNF"
    sudo cp ${FILESDIR}/gcloudsdk/google-cloud-sdk.repo /etc/yum.repos.d/

    sudo dnf install -y google-cloud-cli
fi

if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    GPG_KEY_URL="https://packages.cloud.google.com/apt/doc/apt-key.gpg"
    echo "Adding Repo to APT"
    sudo cp ${FILESDIR}/gcloudsdk/google-cloud-sdk.list /etc/apt/sources.list.d/

    echo "Adding Repo Key"
    curl ${GPG_KEY_URL} | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

    sudo apt update

    sudo apt install -y apt-transport-https ca-certificates gnupg google-cloud-cli
fi

echo "Logging into gcloud SDK"
gcloud init
gcloud auth application-default login

exit 0
