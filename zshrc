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

function changevenv () {
    if [ $# -eq 0 ]; then
        echo "\n!! Please select a new venv: changevenv py\n"
        return
    fi

    DIR="$HOME/venvs/$1"
    if [ -d "$DIR" ]; then
        if typeset -f deactivate > /dev/null ; then
            deactivate
        fi

        . "$DIR/bin/activate"

        echo "\n>> SUCCESS! Changed to venv $1\n"
    else
        echo "\n!! Sorry, $1 doesn't exist, choose a new venv\n"
    fi
}

alias df='df -h '
alias cd..='cd ..'  # fix typing error
alias sshraspberrypi="ssh -o UserKnownHostsFile=/dev/null pi@raspberrypi.local"

case `uname` in
  Darwin)
    PROMPT="%F{white} %F{green}%n@%F{magenta}%m %F{blue}%1~ %f%# "
    alias ls='ls -pGh '

    # brew python
    export LDFLAGS="-L/usr/local/opt/python@3.10/lib"
    export PKG_CONFIG_PATH="/usr/local/opt/python@3.10/lib/pkgconfig"
    export PATH="/usr/local/opt/python@3.10/bin:$PATH:/usr/local/sbin"
  ;;
  Linux)
    umask 0022 # fix permissions to 644
    alias ls='ls -ph --color=auto '
    PROMPT=$'\U1f427 %F{green}%n@%F{magenta}%m %F{blue}%1~ %f%# '
  ;;
esac

# stop making zsh ask if I want to delete things
setopt rmstarsilent

# handle pasted urls
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

if [[ -d "/opt/ros/humble" ]]; then
    . /opt/ros/humble/setup.zsh
fi

. ${HOME}/venvs/py/bin/activate
echo " ** to exit" `python --version` "venv type \"deactivate\" **"
echo " ** or do \"changevenv [new venv]\" to switch **"


export EDITOR=nano
