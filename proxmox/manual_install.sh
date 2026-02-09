#!/bin/bash

echo "<<< Start >>>"

# Bashrc
echo " - bashrc"
rm -f ${HOME}/.bashrc
ln -s ${PWD}/bashrc ${HOME}/.bashrc

# debian - MOTD
echo " - motd"
apt update
apt install -y lsb-release figlet avahi-daemon
rm -f /etc/motd            # remove existing one
touch /etc/motd            # create empty file
rm -f /etc/update-motd.d/* # remove all motd
chmod 744 ./01-custom        # set permissions
chown root:root ./01-custom  # set ownership
ln -s ${PWD}/01-custom /etc/update-motd.d/01-custom

# setup ssh
echo " - ssh"
rm -f ${HOME}/.ssh/authorized_keys
ln -s ${PWD}/authorized_keys ${HOME}/.ssh/authorized_keys

echo "<<< Done >>>"
