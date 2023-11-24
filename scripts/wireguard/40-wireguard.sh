#!/usr/bin/env bash
# Sets up wireguard on the host for multiple users
#
echo -e "\n--- Install wireguard ---\n"
if [[ $OSNAME = "Ubuntu" ]] || [[ $OSNAME = "Pop!_OS" ]]; then
    sudo apt install wireguard
fi

# Netplan
sudo rm --interactive=never /etc/netplan/*
sudo cp ${FILESDIR}/wireguard/etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
sudo chmod 600 /etc/netplay/01-netcfg.yaml
sudo netplan apply

# iptables
sudo mkdir /etc/iptables
sudo cp ${FILESDIR}/wireguard/etc/iptables/iptables.rules /etc/iptables/iptables.rules
sudo cp ${FILESDIR}/wireguard/systemd/system/iptables-rules.service /etc/systemd/system/iptables-rules.service
sudo systemctl enable iptables-rules.service

# Enable IP routing
sudo cp ${FILESDIR}/wireguard/etc/sysctl.d/50-wireguard.conf /etc/sysctl.d/50-wireguard.conf

# Wireguard
sudo cp ${FILESDIR}/wireguard/etc/wireguard/* /etc/wireguard

# Kenton Config
WG0_PRIV_KEY=$(sops -d --extract '["wg0_priv_key"]' ${FILESDIR}/wireguard/vault.sops.yaml)
LAPTOP_PUB_KEY=$(sops -d --extract '["laptop_pub_key"]' ${FILESDIR}/wireguard/vault.sops.yaml)
CELLY_PUB_KEY=$(sops -d --extract '["celly_pub_key"]' ${FIlESDIR}/Wireguard/vault.sops.yaml)

# Ian Config
WG1_PRIV_KEY=$(sops -d --extract '["wg1_priv_key"]' ${FILESDIR}/wireguard/vault.sops.yaml)
IAN_PUB_KEY1=$(sops -d --extract '["ian_pub_key1"]' ${FILESDIR}/wireguard/vault.sops.yaml)

# Matt Config
WG2_PRIV_KEY=$(sops -d --extract '["wg2_priv_key"]' ${FILESDIR}/wireguard/vault.sops.yaml)
MATT_PUB_KEY1=$(sops -d --extract '["matt_pub_key1"]' ${FILESDIR}/wireguard/vault.sops.yaml)

sudo sed -i -e "s/WG0_PRIV_KEY/${WG0_PRIV_KEY}/" /etc/wireguard/wg0.conf
sudo sed -i -e "s/LAPTOP_PUB_KEY/${LAPTOP_PUB_KEY}/" /etc/wireguard/wg0.conf
sudo sed -i -e "s/CELLY_PUB_KEY/${CELLY_PUB_KEY}/" /etc/wireguard/wg0.conf
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0

sudo sed -i -e "s/WG1_PRIV_KEY/${WG1_PRIV_KEY}/" /etc/wireguard/wg1.conf
sudo sed -i -e "s/IAN_PUB_KEY1/${IAN_PUB_KEY1}/" /etc/wireguard/wg1.conf
sudo systemctl enable wg-quick@wg1
sudo systemctl start wg-quick@wg1

sudo sed -i -e "s/WG2_PRIV_KEY/${WG2_PRIV_KEY}/" /etc/wireguard/wg2.conf
sudo sed -i -e "s/MATT_PUB_KEY1/${MATT_PUB_KEY1}/" /etc/wireguard/wg2.conf
sudo systemctl enable wg-quick@wg2
sudo systemctl start wg-quick@wg2
