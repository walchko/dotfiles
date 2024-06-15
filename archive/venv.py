#!/usr/bin/env python3
# -*- coding: utf-8 -*-
##############################################
# The MIT License (MIT)
# Copyright (c) 2016 Kevin Walchko
# see LICENSE for full details
##############################################

"""
build env ... look here to use venv api:
https://docs.python.org/3/library/venv.html
"""

import subprocess     # Popen
# import os             # make directories, change current dir, etc
import pathlib        # folder finding
import argparse       # handle command line args
from sys import exit  # exit on error
from colorama import Fore # colorization of output

def run(cmd):
    """Runs a command string and returns the output"""
    p = subprocess.Popen(
        cmd,
        shell=True,
        # stderr=subprocess.STDOUT,
        stdout=subprocess.PIPE,
        encoding='utf-8',
    )
    return p


# def mkdir(path):
#     """Makes a directory"""
#     try:
#         os.mkdir(path)
#     except FileExistsError:
#         # folder was already created ... it's ok
#         pass

def printE(s):
    print(f"{Fore.RED}*** {s} ***{Fore.RESET}")

def update(env):
    venv = pathlib.Path.home() / f"venvs/{env}/bin/activate"
    req = pathlib.Path.home() / f"github/dotfiles/requirements/{env}_requirements.txt"

    p = run(
        f"source {venv} && pip install -U -r {req}"
    )

    # blank = ' '*os.get_terminal_size().columns + '\r'

    while True:
        line = p.stdout.readline()
        if not line: break
        if "Requirement already satisfied:" in line:
            pkg = line.split(':')[1].split()[0].strip()
            line = f"{Fore.MAGENTA}Requirement already satisfied: {Fore.YELLOW}{pkg}{Fore.RESET}"
        elif "Successfully installed" in line:
            l = line.split()
            l[0] = f"{Fore.GREEN}{l[0]}"
            l[1] = f"{l[1]}{Fore.YELLOW}"
            l[-1] = f"{l[-1]}{Fore.RESET}"
            line = ' '.join(l)
        else:
            print(f".", end='',flush=True)
            continue

        print(f"\r{line}")
    print(f"{Fore.BLUE}Updated virtual environment {Fore.CYAN}{env}{Fore.RESET}")

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("-r", "--root", help="root path to venv in home folder", default="venvs")
    parser.add_argument('venv', help='which virtual environment, ex: py')
    args = vars(parser.parse_args())
    venv = args["venv"]

    root = pathlib.Path.home() / args["root"]
    venvs = []
    try:
        for path in pathlib.Path(root).iterdir():
            if path.is_dir():
                venvs.append(path.stem)
    except FileNotFoundError as e:
        printE(e)
        exit(1)

    if venv in venvs:
        update(venv)
    else:
        printE(f"{Fore.CYAN}{venv}{Fore.RED} is not a valid venv in {root}")
        printE(f"Valid venv: {Fore.CYAN}{' '.join(venvs)}{Fore.RED}")
        exit(1)
