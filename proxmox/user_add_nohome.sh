#!/bin/bash
# Adds a user with no home

if [[ $# -ne 2 ]]; then
    echo "ERROR: incorrect parameters"
    echo "$0 [user] [password]" >&2
    exit 2
fi

USER=$1
PASSWD=$2

# -M don't create home
# -U add group with same name
useradd ${USER} -s /bin/bash -M -U
# chpasswd << 'END'
# ${USER}:${PASSWD}
# END
echo "${USER}:${PASSWD}" | chpasswd

# Check the exit status of the chpasswd command
if [ "$?" -eq 0 ]; then
    echo "Password for user '${USER}' has been updated."
else
    echo "Failed to update password for user '${USER}'."
fi

# add user to groups
usermod -a -G users ${USER}   # why not
usermod -a -G plugdev ${USER} # media files

groups ${USER}

id ${USER}