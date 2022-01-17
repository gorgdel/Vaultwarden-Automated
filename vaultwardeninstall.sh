#!/bin/bash

# Check if root
user=$(whoami)
if [[ "$user" != "root" ]];
then
	echo "Error: Must be run as root or run with SUDO"
	exit
fi

# Disable Apache2
systemctl stop apache2

# Docker install
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

# Portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=no -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

# Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Nginx Proxy Manager
mkdir /opt/nginxproxymanager
cd /opt/nginxproxymanager
curl -L "https://raw.githubusercontent.com/gorgdel/Vaultwarden-Automated/master/docker-compose.yml" --output docker-compose.yml
docker-compose up -d
cd

# Vaultwarden
docker pull vaultwarden/server:latest
systemctl stop apache2
docker run -d --name vaultwarden --restart=always -v /vw-data/:/data/ vaultwarden/server:latest
clear

    

