#!/bin/bash
#
# pdbedit -L -v
# ---------------
# Unix username:        kevin
# NT username:          
# Account Flags:        [U          ]
# User SID:             S-1-5-21-4171441626-3444520916-2469032474-1000
# Primary Group SID:    S-1-5-21-4171441626-3444520916-2469032474-513
# Full Name:            
# Home Directory:       \\FILESERVER\kevin
# HomeDir Drive:        
# Logon Script:         
# Profile Path:         \\FILESERVER\kevin\profile
# Domain:               FILESERVER
# Account desc:         
# Workstations:         
# Munged dial:          
# Logon time:           0
# Logoff time:          Wed, 06 Feb 2036 15:06:39 UTC
# Kickoff time:         Wed, 06 Feb 2036 15:06:39 UTC
# Password last set:    Tue, 31 Dec 2024 02:30:31 UTC
# Password can change:  Tue, 31 Dec 2024 02:30:31 UTC
# Password must change: never
# Last bad password   : 0
# Bad password count  : 0
# Logon hours         : FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

if [[ $# -ne 2 ]]; then
    echo "ERROR: incorrect parameters"
    echo "$0 [user] [password]" >&2
    exit 2
fi

USER=$1
PASSWD=$2

smbpasswd -s -a ${USER} << 'END'
${PASSWD}
${PASSWD}
END

pdbedit -L -v
