#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "ERROR: incorrect parameters"
    echo "$0 [user] [password]" >&2
    exit 2
fi

apt install -y \
    samba samba-common samba-common-bin \
    cifs-utils python3-pexpect \
    avahi-daemon

smbpasswd -s -a $1 << 'END'
$2
$2
END


if [ -f /etc/samba/smb.conf ]; then
    mv -f /etc/samba/smb.conf /etc/samba/smb.conf.bak
fi

cat << EOF > /etc/samba/smb.conf
[global]
    workgroup = WORKGROUP
    wins support = no
    dns proxy = no

#### Debugging/Accounting ####
    log file = /var/log/samba/log.%m
    max log size = 1000
    syslog = 0
    panic action = /usr/share/samba/panic-action %d

####### Authentication #######
    server role = standalone server
    server string = %h server (Samba, Debian)
    security = user
    # passdb backend = tdbsam
    # obey pam restrictions = yes
    # unix password sync = yes
    # passwd program = /usr/bin/passwd %u
    # passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
    # pam password change = yes
    # map to guest = bad user

####### Optimize for Unix-like clients #######
   unix charset = UTF-8
   server min protocol = SMB2
   server max protocol = SMB3

############ Misc ############
# Allow users who have been granted usershare privileges to create
# public shares, not just authenticated ones
    usershare allow guests = no

#======================= Share Definitions =======================
[homes]
    comment = Home Directory
    read only = no
    writable = yes
    browsable = no
    guest ok = no
    create mask = 0664
    directory mask = 0775
    veto files = /._*/.DS_Store/
    delete veto files = yes
EOF

chown root:root /etc/samba/smb.conf
chmod 600 /etc/samba/smb.conf
service smb restart
service nmb restart
