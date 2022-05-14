#!/bin/bash
# MIT License, Kevin Walchko, 20 Dec 2020

set -e

# deactivate
foundEnv=false
envs=("eng" "py" "docker")
for s in ${envs[@]}; do
    if [ "$s" == "$1" ]; then
        echo "found $s"
        source ~/venvs/${1}/bin/activate
        pip install -U -r ~/github/dotfiles/${1}_requirements.txt
        break
    fi
done

if [ foundEnv == false ]; then
    echo ">> Couldn't update environment ${1}"
fi

# handle my libraries
# setup_mine ()
# {
#     echo "------------------------------------"
#     if pip list | grep ${1}; then
#         echo ">> ${1} is already installed"
#         return
#     fi
#     if [ -d ~/github/${1} ]; then
#         cd ~/github/${1}
#         if [ -f "poetry.lock" ]; then
#             echo ">> found lock, rm ${1}/poetry.lock"
#             rm -f poetry.lock
#         fi
#         echo ">> installing ${1}"
#         poetry install
#         cd ..
#     else
#         echo "*** ${1} is NOT found ***"
#     fi
# }

# setup_mine slurm
# setup_mine squaternion
# setup_mine numpy_camera
# setup_mine opencv_camera
# setup_mine ins_nav
# setup_mine pycreate2
# setup_mine pyrk
# setup_mine the-collector
