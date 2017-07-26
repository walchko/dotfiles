# My Dot Files

# bash

Just some dotfiles to help setup bash on macOS and Windows.

## macOS

Just run:

    ./setup-macos.sh

## Windows

Setup git bash, note I make these **hard** links on windows:

	ln ~/Documents/Github/dotfiles/windows_bash_profile ~/.bash_profile

So this setups the command prompt, sets up `ssh-agent` to run for windows openned and loads my ssh keys.
Note I also renamed `My Documents` to just `Document` because spaces in a path name is *evil*.

Fix editor:

	git config core.editor notepad

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
