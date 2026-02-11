#!/bin/bash
# Adds a user with home

if [[ $# -ne 2 ]]; then
    echo "ERROR: incorrect parameters"
    echo "$0 [user] [password]" >&2
    exit 2
fi

USER=$1
PASSWD=$2
USERHOME=/home/${USER}

echo "Adding user ${USER}"
# -b base directory (default /home) ... no need?
# -m create home directory
# -M don't create home (default?)
# -U add group with same name (default?)
useradd -s /bin/bash -m ${USER}
echo "${USER}:${PASSWD}" | chpasswd

# Check the exit status of the chpasswd command
if [ "$?" -eq 0 ]; then
    echo "Password for user '${USER}' has been updated."
else
    echo "Failed to update password for user '${USER}'."
fi

# Bashrc
echo " - bashrc"
rm -f ${USERHOME}/.bashrc
su -c "ln -s ${PWD}/bashrc ${USERHOME}/.bashrc" ${USER}

# setup sudo
FILE="/etc/sudoers.d/nopasswd"
if [[ ! -f ${FILE} ]]; then
    echo " - sudo"
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

# setup ssh
echo " - ssh"
mkdir -p ${USERHOME}/.ssh 
rm -f ${USERHOME}/.ssh/authorized_keys
cat << EOF > ${USERHOME}/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCJuBFkift9eHbOTgDDcT66DmMcCoSeOQXdw4xcSdbw kevin@Logan.local
EOF
chown ${USER}:${USER} ${USERHOME}/.ssh/authorized_keys

# add user to groups
echo " - groups"
usermod -aG users ${USER}   # why not
usermod -aG plugdev ${USER} # media files
usermod -aG sudo ${USER}

groups ${USER}

id ${USER}