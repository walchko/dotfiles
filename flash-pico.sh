#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: ${0} <path/to/serialport>"
    exit 1
fi

# grab 1st arg as the UF2 file to load
UF2=$1

# if [ ! -e "${UF2}" ]; then
#     echo "Error, invalid serial port: ${UF2}"
#     exit 1
# fi

echo "Loading ${UF2} to pi pico\n"

# -v: verify load
# -f: force device into BOOTSEL mode, reboot when done
picotool load "${UF2}" -v -f