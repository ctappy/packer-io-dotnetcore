#!/bin/bash

set -ex

# SETUP DOT NET AND APACHE REVERSE PROXY
echo deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main > /etc/apt/sources.list.d/dotnetdev.list
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
apt-get update
apt-get install apache2 $PACKER_DOTNET_INSTALL_PACKAGE -y
a2enmod proxy proxy_http proxy_html
## SETUP ASPNETCORE
mv /tmp/aspnetcore.conf /etc/apache2/conf-available/aspnetcore.conf
ln -s /etc/apache2/conf-available/aspnetcore.conf /etc/apache2/conf-enabled/
systemctl restart apache2
systemctl enable apache2
mkdir ~/aspnetcore
cd ~/aspnetcore && dotnet new mvc
cd ~/aspnetcore && dotnet publish
cp -a ~/aspnetcore/bin/Debug/netcoreapp2.0/publish/ /var/www/aspnetcore
chown -R $PACKER_SFTP_USERNAME:$PACKER_SFTP_USERNAME /var/www/aspnetcore/
mv /tmp/kestrel-aspnetcore.service /etc/systemd/system/kestrel-aspnetcore.service
systemctl daemon-reload
systemctl enable kestrel-aspnetcore
systemctl start kestrel-aspnetcore
