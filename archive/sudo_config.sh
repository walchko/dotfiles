#!/bin/bash

apt install -y sudo

FILE="/etc/sudoers.d/nopasswd"
if [[ ! -f ${FILE} ]]; then
apt install -y sudo
# all members of sudo group don't need password
# usermod -a -G sudo ${USER}
cat << EOF > ${FILE}
%sudo ALL = (ALL) NOPASSWD: ALL
Defaults exempt_group = sudo
EOF
else
    echo " - sudo: already installed"
fi
