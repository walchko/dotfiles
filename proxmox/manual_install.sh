#!/bin/bash

echo "<<< Start >>>"

apt update
apt upgrade -y
apt autoremove -y

echo " - locales"
apt install -y locales
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# fix time
echo " - timezone"
timedatectl set-timezone America/New_York

# Bashrc
echo " - bashrc"
rm -f ${HOME}/.bashrc
ln -s ${PWD}/bashrc ${HOME}/.bashrc

# debian - MOTD
echo " - motd"
apt install -y lsb-release figlet avahi-daemon
rm -f /etc/motd            # remove existing one
touch /etc/motd            # create empty file
rm -f /etc/update-motd.d/* # remove all motd
chmod 744 ./01-custom        # set permissions
chown root:root ./01-custom  # set ownership
ln -s ${PWD}/01-custom /etc/update-motd.d/01-custom

# setup ssh
echo " - ssh"
mkdir -p ${HOME}/.ssh 
rm -f ${HOME}/.ssh/authorized_keys
# cp ${PWD}/authorized_keys ${HOME}/.ssh/authorized_keys
cat << EOF > ${HOME}/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCJuBFkift9eHbOTgDDcT66DmMcCoSeOQXdw4xcSdbw kevin@Logan.local
EOF

echo "<<< Done >>>"
