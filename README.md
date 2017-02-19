# My Dot Files

This is my setup on various operating systems, you will need to adjust the paths for your
system setups. In all cases, you will need `ssh` keys, so do:

	ssh-keygen

When it asks what to call the file, I name them after the service like `github_rsa` or `bitbucket_rsa`
but you can call them anything. Then go to your service and copy/paste the public (ex. `github_rsa.pub`)
into your list of approved `ssh` keys.

Now test the key setup by:

	kevin@Logan ~ $ ssh -T git@ssh.bitbucket.com
	logged in as walchko.

	You can use git or hg to connect to Bitbucket. Shell access is disabled.

Now if you get the above, then success! Also you can use `git@bitbucket.org` and github has a 
similar thing of `git@github.com`. If you get an error or permission denied, try the verbose
option to see if you can see what is happening.

	kevin@Logan ~ $ ssh -vT git@ssh.bitbucket.com
	OpenSSH_7.3p1, LibreSSL 2.4.1
	debug1: Reading configuration data /Users/kevin/.ssh/config
	debug1: Reading configuration data /etc/ssh/ssh_config
	debug1: /etc/ssh/ssh_config line 20: Applying options for *
	debug1: Connecting to ssh.bitbucket.com [104.192.143.7] port 22.
	debug1: Connection established.
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_rsa type -1
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_rsa-cert type -1
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_dsa type -1
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_dsa-cert type -1
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_ecdsa type -1
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_ecdsa-cert type -1
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_ed25519 type -1
	debug1: key_load_public: No such file or directory
	debug1: identity file /Users/kevin/.ssh/id_ed25519-cert type -1
	debug1: Enabling compatibility mode for protocol 2.0
	debug1: Local version string SSH-2.0-OpenSSH_7.3
	debug1: Remote protocol version 2.0, remote software version conker_1.0.268-723a194 app-126
	debug1: no match: conker_1.0.268-723a194 app-126
	debug1: Authenticating to ssh.bitbucket.com:22 as 'git'
	debug1: SSH2_MSG_KEXINIT sent
	debug1: SSH2_MSG_KEXINIT received
	debug1: kex: algorithm: curve25519-sha256@libssh.org
	debug1: kex: host key algorithm: ssh-rsa
	debug1: kex: server->client cipher: aes128-ctr MAC: hmac-sha2-256 compression: none
	debug1: kex: client->server cipher: aes128-ctr MAC: hmac-sha2-256 compression: none
	debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
	debug1: Server host key: ssh-rsa SHA256:zzXQOXSRBEiUtuE8AikJYKwbHaxvSc0ojez9YXaGp1A
	debug1: Host 'ssh.bitbucket.com' is known and matches the RSA host key.
	debug1: Found key in /Users/kevin/.ssh/known_hosts:17
	debug1: rekey after 4294967296 blocks
	debug1: SSH2_MSG_NEWKEYS sent
	debug1: expecting SSH2_MSG_NEWKEYS
	debug1: rekey after 4294967296 blocks
	debug1: SSH2_MSG_NEWKEYS received
	debug1: SSH2_MSG_SERVICE_ACCEPT received
	debug1: Authentications that can continue: publickey
	debug1: Next authentication method: publickey
	debug1: Offering RSA public key: /Users/kevin/.ssh/github_rsa
	debug1: Authentications that can continue: publickey
	debug1: Offering RSA public key: /Users/kevin/.ssh/walchko_Bitbucket
	debug1: Server accepts key: pkalg ssh-rsa blen 279
	debug1: Authentication succeeded (publickey).
	Authenticated to ssh.bitbucket.com ([104.192.143.7]:22).
	debug1: channel 0: new [client-session]
	debug1: Entering interactive session.
	debug1: pledge: network
	debug1: Sending environment.
	debug1: Sending env LANG = en_US.UTF-8
	debug1: client_input_channel_req: channel 0 rtype exit-status reply 0
	logged in as walchko.

	You can use git or hg to connect to Bitbucket. Shell access is disabled.
	debug1: channel 0: free: client-session, nchannels 1
	Transferred: sent 3096, received 1760 bytes, in 0.1 seconds
	Bytes per second: sent 20919.5, received 11892.2
	debug1: Exit status 0

Next grab the files:

	git clone git@github.com:walchko/dotfiles.git

## macOS

Create links to the originals in my home directory:

	ln -s ~/github/dotfiles/bash_profile .bash_profile

## Rasbian linux

Similar to above:

	ln -s ~/github/dotfiles/linux_bashrc ~/.bashrc

## Windows

Setup git bash, note I make these **hard** links on windows:

	ln ~/Documents/Github/dotfiles/windows_bash_profile ~/.bash_profile

So this setups the command prompt, sets up `ssh-agent` to run for windows openned and loads my ssh keys.
Note I also renamed `My Documents` to just `Document` because spaces in a path name is *evil*.

Also to ensure your `ssh` keys were added properly try one of these:

	ssh-add -l 
	ssh-add -l -E md5

Usually the key fingerprints aren't displayed as md5, so in order to compare what `github` has for
a key and what the `ssh-agent` has, you need to do the second command.

So my work's firewall also prevents `ssh` on port `22`, so I have to setup `git` to use `ssh` 
over https on port `443`:

	ln ~/Documents/Github/dotfiles/ssh_config ~/.ssh/config


## Bash

A good tutorial is here from [Adafruit](https://learn.adafruit.com/an-illustrated-guide-to-shell-magic-typing-less-and-doing-more?view=all)
