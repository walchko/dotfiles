#/bin/bash

if [[ $# -ne 1 ]] ; then
  echo "Please supply a virtual env name"
  echo "$0 <name>"
  exit 1
fi

mkdir -p $HOME/pyvenv/$1


# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
# source /usr/local/bin/virtualenvwrapper.sh
#
# # delete existing
# rmvirtualenv $1
#
# # create new one
# mkvirtualenv $1
# workon $1
# ./setup-python-virtenv.sh
# deactivate
