#!/bin/bash
# ------------------------------------
# Setup a virtual environment with libraries
# I commonly use.
# ------------------------------------

LIBS="
pyserial
jupyter
matplotlib
numpy
imutils
opencv-contrib-python
scikit-learn
scikit-image
keras
pyzmq
msgpack
nose
psutil
pyyaml
simplejson
twine
squaternion
build_utils"

pip install -U ${LIBS}

# link in my folders
BASE="/Users/kevin/github/"
DIRS="
ins_nav
pygecko
pydar
sslam
the-collector
"

for f in ${DIRS}
do
    FULL="${BASE}${f}"
    if [ -d "${FULL}" ]; then
        cd ${FULL}
        echo ">> Link: ${FULL}"
        pip --quiet install -e .
    fi
done

echo " "

pip list
