# ~/.bashrc: executed by bash(1) for non-login shells.
# https://dev.to/ifenna__/adding-colors-to-bash-scripts-48g4

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

ID=`id -u`
# YELLOW_COLOR='\[\033[0;33m\]'
RESET_COLOR='\[\033[0m\]'
# if [ `uname` == "Darwin" ]; then
#     # echo `uname`
#     HOST_COLOR="\[\033[${LIGHT_PURPLE_COLOR}\]"
#     USER_COLOR="\[\033[${PURPLE_COLOR}\]"
# root
if [[ "$ID" == "0" ]]; then
    HOST_COLOR='\[\033[1;91m\]'
    USER_COLOR='\[\033[0;31m\]'
# local login - size of ssh_client == 0
elif [[ -z "${SSH_CLIENT}" ]]; then
    HOST_COLOR='\[\033[1;94m\]'
    USER_COLOR='\[\033[0;34m\]'
# ssh login
else
    HOST_COLOR='\[\033[1;94m\]'
    USER_COLOR='\[\033[0;34m\]'
fi

case `uname` in
    Darwin)
        # apple aliases
        alias df='df -h '

        export PS1=" ${HOST_COLOR}\h@${USER_COLOR}\W\$${RESET_COLOR} "
    ;;
    Linux)
        # linux aliases
        alias systemctl='systemctl --no-pager'
        alias systemctl-running='systemctl list-units --type=service --state=running'
        alias df='df -Th'

        umask 0022 # fix permissions to 644
        export PS1="🐧 ${HOST_COLOR}\h@${USER_COLOR}\W\$ ${RESET_COLOR}"
    ;;
esac


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# aliases
# alias ls='ls -Gph' the -G is different between linux and apple
alias ls='ls -h --color=auto'
alias cd..='cd ..'  # fix typing error
alias grep='grep --color=auto'
alias gitstatus='git remote update && git status'

git-pull-all() {
    # get a list of non-hidden directories
    shopt -u dotglob

    # iterate through list
    for d in */; do
    echo "========================"
    echo " ${d%/}"
    echo "========================"
    cd ${d%/}
    if [[ -d ".git" ]]; then
        repo=`git config --get remote.origin.url`
        # gitpath="git@github.com:"
        #if [[ $repo =~ $gitpath ]]; then
        if [[ "1" ]]; then
        echo "${repo}"
        git pull
        #   git submodule update --remote --recursive
        git status
    fi
    else
        echo " ${d%/} is not a Git repo"
    fi
    cd ..
    echo ""
    echo ""
    done
}

# fully update pip
pip-upgrade-all() {
    for pkg in $(pip3 list --outdated | cut -d' ' -f1 | awk 'NR > 2')
    do
        # echo ">> ${pkg}"
        pip3 install --upgrade ${pkg}
    done
}

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

# the \[ and \] do not work here like they do in PS1 ????
YELLOW_COLOR='\033[0;33m'
RESET_COLOR='\033[0m'
. ${HOME}/venvs/py/bin/activate
# echo -e "${YELLOW_COLOR}"
echo -e "${YELLOW_COLOR} ** to exit" `python3 --version` "venv type \"deactivate\" **"
echo -e " ** or do \"changevenv [new venv]\" to switch **${RESET_COLOR}"
# echo -e "${RESET_COLOR}"

# ros
if [[ -d "/opt/ros" ]]; then
   . /opt/ros/jazzy/setup.bash
#    export LANG=en_US.UTF-8
fi

# gecko
#export LD_LIBRARY_PATH=/opt/gecko/gecko/lib:/opt/gecko/lib:$LD_LIBRARY_PATH
#export PATH=/opt/gecko/bin:$PATH

export EDITOR=nano

# freaking macOS
if [[ "$SHELL" == "/bin/zsh" ]]; then
    export SHELL=/usr/local/bin/bash
fi
