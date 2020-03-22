#!/bin/bash
# MIT Kevin Walchko 2016
# Update a bunch of git repos on command
#

set -e

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
    gitpath="git@github.com:"
    #if [[ $repo =~ $gitpath ]]; then
    if [[ "1" ]]; then
      echo "${repo}"
      git pull
      git submodule update --remote --recursive
      git status
  fi
  else
    echo " ${d%/} is not a Git repo"
  fi
  cd ..
  echo ""
  echo ""
done
