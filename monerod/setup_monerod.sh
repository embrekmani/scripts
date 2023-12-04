#!/bin/bash

# script to fresh install and setup a monero node
# https://sethforprivacy.com/guides/run-a-monero-node-advanced/#download-and-install-monerod

# update system
apt update && apt-get upgrade -y

# necessary packages
apt install -y ufw gpg wget bzip2

# deny all non-explicitly allowed ports
ufw default deny incoming
ufw default allow outgoing

# allow SSH access
ufw allow ssh

# allow monerod p2p port
ufw allow 18080/tcp

# allow monerod restricted RPC port
ufw allow 18089/tcp

# enable UFW
ufw enable

# create system user and group to run monerod
addgroup --system monero
adduser --system --home /var/lib/monero --ingroup monero --disabled-login monero

# create necessary directories for monerod
mkdir /var/run/monero
mkdir /var/log/monero
mkdir /etc/monero

# create monerod config file
touch /etc/monero/monerod.conf

# set permissions for new directories
chown monero:monero /var/run/monero
chown monero:monero /var/log/monero
chown -R monero:monero /etc/monero

# download binaries
wget https://gist.githubusercontent.com/sethforprivacy/ad5848767d9319520a6905b7111dc021/raw/download_monero_binaries.sh
chmod +x download_monero_binaries.sh
./download_monero_binaries.sh

# install binaries
tar xvf monero-linux-*.tar.bz2
rm monero-linux-*.tar.bz2
cp -r monero-x86_64-linux-gnu-*/* /usr/local/bin/
chown -R monero:monero /usr/local/bin/monero*

# tbc...