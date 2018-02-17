#!/bin/bash

set -ex

# SETUP PHPPGADMIN
apt-get install -y phppgadmin
sed -i -e 's/Require\\ local/Allow\\ From\\ all/g' /etc/apache2/conf-available/phppgadmin.csed -i -e '1 a\\<VirtualHost *:82>' /etc/apache2/conf-available/phppgadmin.conf
sed -i -e '1 a\\Listen 82' /etc/apache2/conf-available/phppgadmin.conf
echo '</VirtualHost>' | tee -a /etc/apache2/conf-available/phppgadmin.conf
# SETUP POSTGRES
wget https://bootstrap.pypa.io/get-pip.py
python3 ./get-pip.py
pip install paramiko ansible psycoansible-galaxy install geerlingguy.postgresql
ansible-playbook /tmp/postgres-install.yml -e \"{'postgresql_databases':[{'name': $PACKER_DB_NAME}], 'postgresql_users':[{ 'name': $PACKER_DB_USERNAME, 'password': $PACKER_DB_PASSWORD}]}\"
# OPEN POSTGRES PORT 5432
sed -i -e \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/g\" /etc/postgresql/9.5/main/postgresql.conf
sed -i -e 's|127.0.0.1/32|0.0.0.0/0|g' /etc/postgresql/9.5/main/pg_hba.conf
su - -c \"psql -c 'ALTER USER $PACKER_DB_USERNAME WITH SUPERUSER'\" postgres
