#!/bin/bash
apt-get install ranger
apt-get install net-tools
apt-get update
apt-get install apt-transport-https
apt-get install curl
apt-get install ca-certificates
apt-get install gnupg
apt-get install lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=no -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
mkdir /opt/nginxproxymanager
cd /opt/nginxproxymanager
curl -L https://raw.githubusercontent.com/gorgdel/Vaultwarden-Automated/master/docker-compose.yml --output docker-compose.yml
docker-compose up -d
cd
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker pull vaultwarden/server:latest
systemctl stop apache2
echo "Complete - Proceed with other steps."
