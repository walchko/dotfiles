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
chpasswd << 'END'
${USER}:${PASSWD}
END
