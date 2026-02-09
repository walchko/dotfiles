# Proxmox Manual Scripts

## Scripts

- `manual_install.sh`:
    - sets timezone
    - symbolic link from `bashrc` to `~/.bashrc`
    - sets up MOTD
    - copies SSH `authorized_keys` to `~/.ssh/authorized_keys`
- `samba_add_user [name] [password]`:
    - adds a new user to samba
- `user_add_nohome.sh [name] [password]`:
    - adds a new user to system without a home