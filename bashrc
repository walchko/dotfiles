# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# setup prompt
USR="\[\033[32m\]"
HOST="\[\033[35m\]"
DIR="\[\033[34m\]"
END="\[\033[0m\]"

case `uname` in
    Darwin)
        export PS1=" $USR\u@$HOST\h $DIR\W$END \$ "
    ;;
    Linux)
        umask 0022 # fix permissions to 644
        export PS1="\U1f427 $USR\u@$HOST\h $DIR\W$END \$ "
    ;;
esac


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# aliases
alias df='df -h '
# alias ls='ls -Gph'
alias ls='ls -hG --color=auto'
alias cd..='cd ..'  # fix typing error
alias grep='grep --color=auto'
alias gitstatus='git remote update && git status'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

# fully update pip
# -----------------------------------------------
pip-upgrade-all() {
    # pip list --outdated | cut -d' ' -f1 | xargs pip install --upgrade
    # pip3 list --outdated | cut -d' ' -f1 | awk 'NR > 2' | xargs pip3 install --use-feature=2020-resolver --upgrade
    for pkg in $(pip3 list --outdated | cut -d' ' -f1 | awk 'NR > 2')
    do
        # echo ">> ${pkg}"
        pip3 install --upgrade ${pkg}
    done
}

# add my poetry
# export LD_LIBRARY_PATH=$HOME/.local/lib/:$LD_LIBRARY_PATH
# export PATH=$PATH:/home/$USER/.poetry/bin

# use python venv
# if [[ -d "/home/$USER/venvs" ]]; then
#     source /home/$USER/venvs/py/bin/activate
#     echo " ** to exit" `python3 --version` "venv type \"deactivate\" **"
#     echo " ** or do \"changevenv [new venv]\" to switch **"
# elif [[ -d "/Users/$USER/venvs" ]]; then
#     source /Users/$USER/venvs/py/bin/activate
#     echo " ** to exit" `python3 --version` "venv type \"deactivate\" **"
#     echo " ** or do \"changevenv [new venv]\" to switch **"
# fi

function changevenv () {
    if [ $# -eq 0 ]; then
        echo -e "\n!! Please select a new venv: changevenv py\n"
        return
    fi

    DIR="$HOME/venvs/$1"
    if [ -d "$DIR" ]; then
        if typeset -f deactivate > /dev/null ; then
            deactivate
        fi

        . "$DIR/bin/activate"

        echo -e "\n>> SUCCESS! Changed to venv $1\n"
    else
        echo -e "\n!! Sorry, $1 doesn't exist, choose a new venv\n"
    fi
}

. ${HOME}/venvs/py/bin/activate
echo " ** to exit" `python3 --version` "venv type \"deactivate\" **"
echo " ** or do \"changevenv [new venv]\" to switch **"

# ros
# if [[ -d "/opt/ros" ]]; then
#    source /opt/ros/foxy/setup.bash
#    export LANG=en_US.UTF-8
# fi

# gecko
#export LD_LIBRARY_PATH=/opt/gecko/gecko/lib:/opt/gecko/lib:$LD_LIBRARY_PATH
#export PATH=/opt/gecko/bin:$PATH

export EDITOR=nano
export SHELL=/usr/local/bin/bash