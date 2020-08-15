# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
# zstyle :compinstall filename '/Users/kevin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

function pip-upgrade-all() {
    pip3 list --outdated | cut -d' ' -f1 | awk 'NR > 2' | xargs pip3 install --upgrade
}

PROMPT="%F{green}%n@%F{magenta}%m %F{blue}%1~ %f%# "

#source ~/venv/bin/activate
#echo " ** to exit" `python --version` "venv type \"deactivate\" **"

# brew python
export LDFLAGS="-L/usr/local/opt/python@3.8/lib"
export PKG_CONFIG_PATH="/usr/local/opt/python@3.8/lib/pkgconfig"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

export PATH="$HOME/.poetry/bin":$PATH

#source ~/venv/bin/activate
#echo " ** to exit" `python --version` "venv type \"deactivate\" **"

alias df='df -h '
alias cd..='cd ..'  # fix typing error
alias sshraspberrypi="ssh -o UserKnownHostsFile=/dev/null pi@raspberrypi.local"

case `uname` in
  Darwin)
    alias ls='ls -pGh '
  ;;
  Linux)
    alias ls='ls -ph --color=auto '
  ;;
esac

# handle pasted urls
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

if [[ -d "/opt/ros" ]]; then
    . /opt/ros/foxy/setup.zsh
else
    source ~/venv/bin/activate
    echo " ** to exit" `python --version` "venv type \"deactivate\" **"
fi
