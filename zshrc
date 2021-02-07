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
    # pip3 list --outdated | cut -d' ' -f1 | awk 'NR > 2' | xargs pip3 install --upgrade
    for pkg in $(pip3 list --outdated | cut -d' ' -f1 | awk 'NR > 2')
    do
        # echo ">> ${pkg}"
        pip3 install --upgrade ${pkg}
    done
}



export PATH=$PATH:"$HOME/.poetry/bin"

alias df='df -h '
alias cd..='cd ..'  # fix typing error
alias sshraspberrypi="ssh -o UserKnownHostsFile=/dev/null pi@raspberrypi.local"

case `uname` in
  Darwin)
    PROMPT="%F{white} %F{green}%n@%F{magenta}%m %F{blue}%1~ %f%# "
    alias ls='ls -pGh '

    # brew python
    export LDFLAGS="-L/usr/local/opt/python@3.9/lib"
    export PKG_CONFIG_PATH="/usr/local/opt/python@3.9/lib/pkgconfig"
    export PATH="/usr/local/opt/python@3.9/bin:$PATH"
  ;;
  Linux)
    alias ls='ls -ph --color=auto '
    PROMPT='\U1f427 %F{green}%n@%F{magenta}%m %F{blue}%1~ %f%# '
  ;;
esac

# stop making zsh ask if I want to delete things
setopt rmstarsilent

# handle pasted urls
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

if [[ -d "/opt/ros" ]]; then
    . /opt/ros/foxy/setup.zsh
    . ${HOME}/venv/bin/activate
    echo " ** to exit" `python --version` "venv type \"deactivate\" **"
else
    . ${HOME}/venv/bin/activate
    echo " ** to exit" `python --version` "venv type \"deactivate\" **"
fi

export PATH="$HOME/.poetry/bin:$PATH"
