#!/bin/bash

# stores the script directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "$SCRIPT_DIR"

# create backup
if [ -f ~/.profile ]; then
    cp -nv ~/.profile{,.backup}
    echo "backup of old ~/.profile created at ~/.profile.backup"
fi

# copy file
cp "$SCRIPT_DIR"/.profile ~/.profile


# load profile
source ~/.bashrc