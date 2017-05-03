#!/bin/bash

# check if we are root
if [ "$EUID" -eq 0 ]
  then echo "Please run as pi"
  exit 1
fi

rm -f ~/.bashrc
ln -s ~/github/dotfiles/linux_bashrc ~/.bashrc

sudo rm -f /etc/motd
sudo touch /etc/motd

if [ -f "/etc/profile.d/sshpwd.sh" ]; then
  sudo rm -f /etc/profile.d/sshpwd.sh
else
  echo "already removed sshpwd.sh"
fi

if [ ! -f "/etc/profile.d/motd.sh" ]; then
  sudo ln -s /home/pi/github/dotfiles/motd /etc/profile.d/motd.sh
else
  echo "already setup motd.sh"
fi
