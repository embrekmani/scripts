#!/bin/bash

# stores the script directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "$SCRIPT_DIR"

cp "$SCRIPT_DIR"/.bash_aliases ~/.bash_aliases

# create backup
if [ -f ~/.bash_aliases ]; then
    cp -nv ~/.bash_aliases{,.backup}
    echo "backup of old ~/.bash_aliases created at ~/.bash_aliases.backup"
fi

# load aliases
source ~/.bashrc