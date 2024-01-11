#!/bin/bash

# stores the script directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")
echo "$SCRIPT_DIR"

# store list of aliases
JSON="$SCRIPT_DIR/aliases.json"

if [ ! -f "$JSON" ]; then
    echo "JSON file not found at $JSON"
    exit 1
fi

# check jq is installed
if ! command -v jq &> /dev/null; then
    read -p "jq is not installed. Do you want to install it now? (y/n): " install_jq
    if [ "$install_jq" == "y" ]; then
        sudo apt-get update
        sudo apt-get install jq
    else
        echo "jq is required to run this script. Please install it manually and run the script again."
        exit 1
    fi
fi

# create backup
if [ -f ~/.bash_aliases ]; then
    cp -nv ~/.bash_aliases{,.backup}
    echo "backup of old ~/.bash_aliases created at ~/.bash_aliases.backup"
fi

# add or update aliases in ~/.bash_aliases
update_aliases() {
    JSON=$1  # first argument to the function is the JSON file path
    echo -e "# custom aliases\n" > ~/.bash_aliases
    while IFS= read -r line; do
        ALIAS=$(echo "$line" | jq -r '.alias')
        ALIAS_COMMAND=$(echo "$line" | jq -r '.command')
        DESCRIPTION=$(echo "$line" | jq -r '.description')
        echo "$DESCRIPTION"
        echo "alias $ALIAS='$ALIAS_COMMAND'" >> ~/.bash_aliases
    done < "$JSON"
}

update_aliases "$JSON"

# load aliases
source ~/.bashrc
