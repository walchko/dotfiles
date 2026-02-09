#!/bin/bash
# removes a user from smbpasswd

if [[ $# -ne 1 ]]; then
    echo "ERROR: incorrect parameters"
    echo "$0 [user]" >&2
    exit 2
fi

USER=$1

pdbedit -x -u ${USER}

# # Check if the command was successful
# if [ $? -eq 0 ]; then
#     echo "Samba password set successfully for user: $USER"
#     # Ensure the account is enabled (optional, but good practice)
#     smbpasswd -e "$USER"
# else
#     echo "Failed to set Samba password for user: $USER"
# fi

echo "Double check ${USER} is removed"
pdbedit -L -v ${USER}
