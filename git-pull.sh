#!/bin/bash
#
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
    git pull
    git status
  fi
  cd ..
  echo ""
  echo ""
done