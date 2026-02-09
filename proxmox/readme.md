# Proxmox Manual Scripts

These help setup LXC on Proxmox

## Scripts

- `manual_install.sh`:
    - sets timezone
    - symbolic link from `bashrc` to `~/.bashrc`
    - sets up MOTD
    - copies SSH `authorized_keys` to `~/.ssh/authorized_keys`
- `samba_config.sh`:
    - installs software
    - creates `/etc/samba/smb.config`
- `samba_add_user.sh [user] [password]`:
    - adds a new user to samba
- `samba_del_user.sh [user]`
- `user_add.sh [user] [password]`:
    - adds a new user to system with home at `/home/USER`
    - creates a group with same name
- `user_del.sh [user]`