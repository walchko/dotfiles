#!/bin/bash
# Adds a user with no home

if [[ $# -ne 2 ]]; then
    echo "ERROR: incorrect parameters"
    echo "$0 [user] [password]" >&2
    exit 2
fi

USER=$1
PASSWD=$2

echo "Adding user ${USER}"
# -b base directory (default /home) ... no need?
# -m create home directory
# -M don't create home (default?)
# -U add group with same name
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
rm -f /home/${USER}/.bashrc
su -c "ln -s ${PWD}/bashrc /home/${USER}/.bashrc" ${USER}

# add user to groups
echo " - groups"
usermod -a -G users ${USER}   # why not
usermod -a -G plugdev ${USER} # media files

groups ${USER}

id ${USER}