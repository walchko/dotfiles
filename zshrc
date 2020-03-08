# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/kevin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

function pip-upgrade-all() {
    pip3 list --outdated | cut -d' ' -f1 | awk 'NR > 2' | xargs pip3 install --upgrade
}

PROMPT="%F{green}%n@%F{magenta}%m %F{blue}%1~ %f%# "

source ~/venv/bin/activate
echo " ** to exit" `python --version` "venv type \"deactivate\" **"

# source $HOME/.poetry/env
export PATH="$HOME/.poetry/bin:$PATH"

alias df='df -h '
alias ls='ls -aGph'
alias cd..='cd ..'  # fix typing error
alias sshraspberrypi="ssh -o UserKnownHostsFile=/dev/null pi@raspberrypi.local"

# handle pasted urls
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
