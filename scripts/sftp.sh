#!/bin/bash

set -ex

# SETUP SFTP
useradd -m $PACKER_SFTP_USERNAME
usermod -aG www-data $PACKER_SFTP_USERNAME
echo $PACKER_SFTP_USERNAME:$PACKER_SFTP_PASSWORD | chpasswd
## ADD USER TO SSHD
echo | tee -a /etc/ssh/sshd_config
echo Match User $PACKER_SFTP_USERNAME |tee -a /etc/ssh/sshd_config
echo ForceCommand internal-sftp |tee -a /etc/ssh/sshd_config
echo PasswordAuthentication yes |tee -a /etc/ssh/sshd_config
echo ChrootDirectory $PACKER_SFTP_USER_ROOT_LOGIN_DIR |tee -a /etc/ssh/sshd_conecho PermitTunnel no |tee -a /etc/ssh/sshd_config
echo AllowAgentForwarding no |tee -a /etc/ssh/sshd_config
echo AllowTcpForwarding no |tee -a /etc/ssh/sshd_config
echo X11Forwarding no |tee -a /etc/ssh/sshd_config
systemctl restart sshd
