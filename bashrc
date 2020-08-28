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

USR="\[\033[01;32m\]"
HOST="\[\033[01;35m\]"
DIR="\[\033[01;34m\]"
END="\[\033[0m\]"

export PS1="$USR\u@$HOST\h $DIR\W$END \$ "

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# aliases
alias df='df -h '
alias ls='ls -Gph'
alias cd..='cd ..'  # fix typing error
alias ls='ls -h --color=auto'
alias grep='grep --color=auto'
alias gitstatus='git remote update && git status'
# alias pip3='pip3 --use-feature=2020-resolver'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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

# add my .local
# export LD_LIBRARY_PATH=$HOME/.local/lib/:$LD_LIBRARY_PATH
export PATH=/home/$USER/.local/bin:$PATH

# use python venv
source /home/$USER/venv/bin/activate
echo " ** to exit" `python3 --version` "venv type \"deactivate\" **"

# ros
if [[ -d "/opt/ros" ]]; then
   source /opt/ros/foxy/setup.bash
   export LANG=en_US.UTF-8
fi

# gecko
#export LD_LIBRARY_PATH=/opt/gecko/gecko/lib:/opt/gecko/lib:$LD_LIBRARY_PATH
#export PATH=/opt/gecko/bin:$PATH
