#!/usr/bin/env bash
# Installs awscli

if [[ ! $INC_AWSCLI ]]; then
    echo "INC_AWSCLI is not set. Skipping 12-awscli.sh"
    exit 0
fi

echo -e "\n--- installing awscli ---\n"
cd ${TMPDIR}
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
