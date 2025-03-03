#!/bin/bash

# Remove service
sudo cloudflared service uninstall
sudo rm /etc/cloudflared/config.yml

# Copy config
sudo mkdir /etc/cloudflared
sudo cp ~/.cloudflared/*.json /etc/cloudflared
sudo cp ~/.cloudflared/cert.pem /etc/cloudflared
sudo cp ~/.cloudflared/config.yml /etc/cloudflared
sudo sed -i.bak 's/\/Users\/'${USER}'\/\./\/etc\//g' /etc/cloudflared/config.yml

# Install
sudo cloudflared service install

# Launchd
sudo launchctl stop com.cloudflare.cloudflared
sudo launchctl unload /Library/LaunchDaemons/com.cloudflare.cloudflared.plist
sudo cp -f ./com.cloudflare.cloudflared.plist /Library/LaunchDaemons/
sudo launchctl load -w /Library/LaunchDaemons/com.cloudflare.cloudflared.plist

