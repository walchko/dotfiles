#!/bin/bash
# Adds a user with no home

if [[ $# -ne 1 ]]; then
    echo "ERROR: incorrect parameters"
    echo "$0 [user]" >&2
    exit 2
fi

USER=$1

# remove user from groups
usermod -G "" ${USER}

deluser --remove-home ${USER}
# deluser ${USER}
# delgroup ${USER} # done automatically w/deluser?

# # Check the exit status of the chpasswd command
# if [ "$?" -eq 0 ]; then
#     echo "'${USER}' has been removed"
# else
#     echo "Failed to remove user '${USER}'."
# fi