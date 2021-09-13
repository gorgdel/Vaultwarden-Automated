# Vaultwarden-Automated
Automated Vaultwarden Install!

# What is this??
This will aid and install the free version of Bitwarden ([Vaultwarden](https://github.com/dani-garcia/vaultwarden))
This is for Debian based distros

# How do I use this?
```bash
$ curl -L "https://raw.githubusercontent.com/gorgdel/Vaultwarden-Automated/master/vaultwardeninstall.sh" --output "vaultwardeninstall.sh"
$ su -
$ sh vaultwardeninstall.sh
```
This will install Vaultwarden, NginxProxyManager, Docker and Portainer

# Applications installed & Uses
* [Portainer](https://www.portainer.io/) - An awesome GUI interface that allows you to manage your docker containers.
* [NginxProxyManger](https://nginxproxymanager.com/) - Another GUI interface, this time NGINX, which allows you to add certs, generate Let's Encrypt Certs and create the reverse proxy to allow Vaultwarden to work.
* [Docker](https://www.docker.com/)/[Docker-Compose](https://docs.docker.com/compose/) - The brains of the install, docker allows for all the containers to work.
* [Vaultwarden (free version of bitwarden)](https://bitwarden.com/) - The password repository.

# Install Guide
```
$ curl -L "https://raw.githubusercontent.com/gorgdel/Vaultwarden-Automated/master/vaultwardeninstall.sh" --output "vaultwardeninstall.sh"
$ su -
$ sh vaultwardeninstall.sh
```
Once install is complete:
```
$ Hostname -I
```
This will return your IP Address. Start by entering your IP into a browser with port 9000.
```
192.168.0.1:9000
```
##### Portainer
This will take you to the Portainer home-page. Create a user.
Within here, you can see your containers, vaultwarden and nginx should be enabled.

##### NginxProxyManager
Connect to NginxProxyManager
```
192.168.0.1:81
```
1. Select SSL Certificates

2. Add SSL Certificate > Custom

3. Set a name >
Upload the private key file (unencrypted)
Upload the certificate file (.cer or .crt)
Upload the Intermediate Certificate
OR
Create Let's Encrypt Cert.

4. Hosts > Proxy Hosts > Add Proxy Host

5. "Details" tab:
Domain Names - (set the domain name you want)
Scheme - http
Forward Hostname/IP - 192.168.0.xxx
Forward Port - 80

6. "SSL" tab:
Select the previously created SSL Certificate, Enable "Force SSL" and "HTTP/2 Support"

##### Enable Admin Panel for Vaultwarden
This will allow for you to change config data through a GUI.
Firstly generate a token and save it.
```
openssl rand -base64 48
```
Copy this "token"
Example: s6JsBPLYE7roF+jVaFYLY+SbAgQWI4qfUlVi/1QrOMlQ9yrFKMqH2UJ0kBmZ/dTS
```
$ nano /vw-data/config.json
```
Use arrow keys and go to last line

```
 "_enable_email_2fa": false,
  "email_token_size": 6,
  "email_expiration_time": 600,
  "email_attempts_limit": 3
}
```
We will generate a token using
Add a new variable "admin_token": (token)
(make sure to add a comma to last line)
```
 "_enable_email_2fa": false,
  "email_token_size": 6,
  "email_expiration_time": 600,
  "email_attempts_limit": 3,
  "admin_token": s6JsBPLYE7roF+jVaFYLY+SbAgQWI4qfUlVi/1QrOMlQ9yrFKMqH2UJ0kBmZ/dTS
}
```
```
$ Docker restart vaultwarden
```
Now go to yourdomain.com/admin
Paste your token in and you will get to the admin portal.
*To disable admin portal, remove "admin_token" and remove comma from "email_attempts_limit"*
