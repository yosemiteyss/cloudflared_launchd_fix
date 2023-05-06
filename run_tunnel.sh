#!/bin/bash

# setup
sudo mkdir /etc/cloudflared
sudo cp ~/.cloudflared/*.json /etc/cloudflared
sudo cp ~/.cloudflared/cert.pem /etc/cloudflared
sudo cp ~/.cloudflared/config.yml /etc/cloudflared
sudo sed -i.bak 's/\/Users\/'${USER}'\/\./\/etc\//g' /etc/cloudflared/config.yml

# check
sudo ls -la /etc/cloudflared

# install
sudo cloudflared service install

# check
sudo ls -la /Library/LaunchDaemons | grep cloudflared
sudo ls -la /Library/Logs | grep cloudflared
sudo tail /Library/Logs/com.cloudflare.cloudflared.err.log

# update
sudo launchctl unload /Library/LaunchDaemons/com.cloudflare.cloudflared.plist
sudo patch -p 1 /Library/LaunchDaemons/com.cloudflare.cloudflared.plist < cloudflared.plist.patch
sudo launchctl load -w /Library/LaunchDaemons/com.cloudflare.cloudflared.plist

# check
ps aux | grep cloudflared
sudo tail /Library/Logs/com.cloudflare.cloudflared.err.log

