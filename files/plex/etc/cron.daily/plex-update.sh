#!/bin/sh -e
# Update container to latest
podman pull lscr.io/linuxserver/plex:latest

# Restart pod to use latest container
systemctl restart pod-plex.service
