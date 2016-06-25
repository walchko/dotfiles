export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
export EDITOR=`which pico`

# https://github.com/magicmonty/bash-git-prompt/tree/master/themes
if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
    source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi

TOKEN_FILE="/Users/${USER}/Dropbox/Share/kevin/tokens.sh"
if [ -r ${TOKEN_FILE} ]; then
    source ${TOKEN_FILE}
fi

alias ls='ls -Gph'
alias cd..='cd ..'  # fix typing error

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
