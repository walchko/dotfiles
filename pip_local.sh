#!/bin/bash

ENV=$VIRTUAL_ENV_PROMPT
DIR=$PWD

poetry_install(){
    cd "$HOME/github/$1"
    if [[ -f "poetry.lock" ]]; then
        pip uninstall -y "$PKG"
        rm "poetry.lock"
        echo ">> Removing poetry.lock in $PWD"
    fi
    echo "poetry installed $PKG"
    poetry install
    cd "$DIR"
}



if [[ "$ENV" -eq "(eng)" ]]; then
    echo "You are currently in $ENV"
    for PKG in slurm jtb squaternion rotations doop
    do
        echo "==== $PKG =================="
        poetry_install $PKG
    done
fi
