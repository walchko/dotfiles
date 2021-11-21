#!/bin/bash
# MIT License, Kevin Walchko, 20 Dec 2020

set -e

# python
pip install -U pip setuptools wheel

pip install -U poetry pytest psutil colorama attrs twine

# basic science stuff
pip install -U jupyter matplotlib numpy simplejson pyyaml

# image stuff
pip install -U opencv-python imageio pillow pyheif-pillow-opener

# machine learning
pip install -U scikit-learn scipy pandas

# robotics
pip install -U pyserial pyzmq sympy

# web page
pip install -U Jinja2

# docker
pip install -U docker-compose

# handle my libraries
setup_mine ()
{
    echo "------------------------------------"
    if pip list | grep ${1}; then
        echo ">> ${1} is already installed"
        return
    fi
    if [ -d ~/github/${1} ]; then
        cd ~/github/${1}
        if [ -f "poetry.lock" ]; then
            echo ">> found lock, rm ${1}/poetry.lock"
            rm -f poetry.lock
        fi
        echo ">> installing ${1}"
        poetry install
        cd ..
    else
        echo "*** ${1} is NOT found ***"
    fi
}

setup_mine slurm
setup_mine squaternion
setup_mine numpy_camera
setup_mine opencv_camera
setup_mine ins_nav
setup_mine pycreate2
setup_mine pyrk
setup_mine the-collector
