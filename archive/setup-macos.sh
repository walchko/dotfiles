#!/bin/bash

set -e

# check if we are root
if [ "$EUID" -eq 0 ]
  then echo "Please run as user ... no sudo"
  exit 1
fi

# if no username given, default to me
if [[ $# -eq 0 ]] ; then
	NAME=walchko
else
	NAME=$1
fi
#
#
# echo ""
# echo "fix git"
# echo ""
#
# NAME=$1

echo "update git"

git config --global user.name ${NAME}
git config --global user.email ${NAME}@users.noreply.github.com
git config --global push.default simple

# twine doesn't like ln -s, just do a cp
FILE=~/Dropbox/pypirc
if [[ -f ${FILE} ]] ; then
	echo "created .pypirc file"
	cp -f ~/Dropbox/pypirc ~/.pypirc
else
	echo "no dropbox found"
fi

echo ""
echo "update bash_profile"
echo ""

rm -f ~/.bashrc
ln -sf ~/github/dotfiles/bash_profile ~/.bash_profile

echo ""
echo "ok ... you should be ready to go!"
echo ""
