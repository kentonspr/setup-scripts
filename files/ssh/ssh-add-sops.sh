#!/usr/bin/env bash

echo $(sops -d --extract '["github_rsa_priv_key_passphrase"]' ${FILESDIR}/all/vault.sops.yml)
