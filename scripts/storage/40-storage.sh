#!/usr/bin/env bash

OSNAME=$(cat /etc/os-release | sed -En "s/^NAME=\"(.*)\"/\1/p")

# Netplan
sudo rm --interactive=never /etc/netplan/*
sudo cp ${FILESDIR}/storage/etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml
sudo netplan apply
