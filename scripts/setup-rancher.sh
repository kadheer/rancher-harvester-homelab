#!/bin/bash
# Rancher Server Setup (auf der Rancher-VM ausführen)

set -e

# Docker installieren
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Rancher Container starten
sudo docker run -d --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --name rancher \
  rancher/rancher:latest

# Warte auf Bootstrap
sleep 30

# Initiales Admin-Passwort abrufen
sudo docker logs rancher 2>&1 | grep "Bootstrap Password"
