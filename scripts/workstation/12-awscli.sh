#!/usr/bin/env bash
# Installs awscli

if [[ ! $INC_AWSCLI ]]; then
    echo "INC_AWSCLI is not set. Skipping 12-awscli.sh"
    exit 0
fi

echo -e "\n--- installing awscli ---\n"

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "${TMPDIR}/awscliv2.zip"
unzip ${TMPDIR}/awscliv2.zip -d ${TMPDIR}/aws
sudo ${TMPDIR}/aws/install

echo -e "\n--- clean up ---\n"
rm -rf ${TMPDIR}/aws*
