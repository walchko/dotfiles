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
    HOST_COLOR='\[\033[1;96m\]'
    USER_COLOR='\[\033[0;34m\]'
fi

case `uname` in
    Darwin)
        # apple aliases
        alias df='df -h '
        # alias ls='ls -Gph' the -G is different between linux and apple
        alias ls='ls -hG --color=auto'
        export PATH="/usr/local/sbin:$PATH"
        export PATH=/opt/homebrew/bin::$PATH
        export PS1=" ${HOST_COLOR}\h@${USER_COLOR}\W\$${RESET_COLOR} "
    ;;
    Linux)
        # linux aliases
        alias systemctl='systemctl --no-pager'
        alias systemctl-running='systemctl list-units --type=service --state=running'
        alias df='df -Th'
        alias ls='ls -h --color=auto'

        umask 0022 # fix permissions to 644
        export PS1="🐧 ${HOST_COLOR}\h@${USER_COLOR}\W\$ ${RESET_COLOR}"
    ;;
esac


# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# aliases
alias cd..='cd ..'  # fix typing error
alias grep='grep --color=auto'
alias gitstatus='git remote update && git status'

function print_error() {
    RED="\e[31m"
    # BLUE="\e[35m"
    RESET="\e[0m"
    # LS=`ls $HOME/venvs/`
    echo -e "${RED}${1}${RESET}"
}

git-pull-all() {
    if ! [ -x "$(command -v git)" ]; then
        print_error "*** git not installed ***"
        return 1
    fi
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

pico-load() {
    if ! [ -x "$(command -v picotool)" ]; then
        print_error "*** picotool is not installed ***"
        return 1
    elif [ $# -ne 1 ]; then
        print_error "Usage: pico-load <filename>\n"
        return 1
    fi
    UF2=$1

    echo "Loading ${UF2} to pi pico"
    picotool load "${UF2}" -v -f
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
    function changevenv_error() {
        RED="\e[31m"
        BLUE="\e[35m"
        RESET="\e[0m"
        LS=`ls $HOME/venvs/`
        # echo -e "${RED}*** Invalid virtual environment (venv) ***${RESET}"
        print_error "*** Invalid virtual environment (venv) ***"
        echo -e "Usage: changevenv <new_venv>"
        echo -e "Valid venvs are:"
        echo -e "${BLUE}${LS}\n${RESET}"
    }
    if [ $# -eq 0 ]; then
        changevenv_error
        # bash will make the error func available, need to remove it
        unset changevenv_error
        return 1
    fi

    DIR="$HOME/venvs/$1"
    if [ -d "$DIR" ]; then
        if typeset -f deactivate > /dev/null ; then
            deactivate
        fi

        . "$DIR/bin/activate"

        echo -e "\n>> SUCCESS! Changed to venv $1\n"
    else
        changevenv_error
        # bash will make the error func available, need to remove it
        unset changevenv_error
        return 1
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
    alias refresh='. install/setup.bash'
    alias colcon-build='colcon build --executor sequential'
    alias colcon-build-pkg='colcon build --executor sequential --packages-select'
fi

# gecko
#export LD_LIBRARY_PATH=/opt/gecko/gecko/lib:/opt/gecko/lib:$LD_LIBRARY_PATH
#export PATH=/opt/gecko/bin:$PATH

export EDITOR=nano

# freaking macOS
if [[ "$SHELL" == "/bin/zsh" ]]; then
    export SHELL=/usr/local/bin/bash
fi
