#!/bin/bash

source .env

# get logs from last 24 hours
echo "Getting logs..."
sudo logwatch --detail Low --range yesterday
echo "Log generated."

# copy log to server path
echo "Copying log to $SERVER_PATH..."
sudo cp /tmp/logwatch $SERVER_PATH/logwatch.html
echo "Copied successfully."

# make user the owner for permissions
echo "Granting ownership..."
sudo chown $USER $SERVER_PATH/logwatch.html
echo "logwatch.html belongs to $USER."