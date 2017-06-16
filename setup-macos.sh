#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -eq 0 ]
  then echo "Please run as user ... no sudo"
  exit 1
fi

# if [[ $# -eq 0 ]] ; then
#   echo "-------------------------------------"
#   echo "Please supply a user name"
#   echo "-------------------------------------"
#   exit 1
# fi
#
#
# echo ""
# echo "fix git"
# echo ""
#
# NAME=$1
#
# git config --global user.name ${NAME}
# git config --global user.email ${NAME}@users.noreply.github.com
# git config --global push.default simple

echo ""
echo "update bash_profile"
echo ""

rm -f ~/.bashrc
ln -s ~/github/dotfiles/bash_profile ~/.bash_profile

echo ""
echo "ok ... you should be ready to go!"
echo ""
