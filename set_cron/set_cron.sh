#!/bin/bash

# make a script run on cron
# sudo sh -c 'cd /path/to/script; ./set_cron.sh $NAME $TIME'

NAME="$1"
TIME="$2"
SCRIPT="$1.sh"

# copy to root user
echo "Copying script to root..."
sudo cp ./"$SCRIPT" /root/"$SCRIPT"

cat /root/"$SCRIPT"

# set permissions to executable
sudo chmod 755 /root/"$SCRIPT"

echo "$TIME"

if [ "$TIME" = "hourly" ]; then
    echo "Setting cron job to perform hourly..."
    echo "/bin/bash /root/$SCRIPT" > /etc/cron.hourly/"$NAME"
elif [ "$TIME" = "daily" ]; then
    echo "Setting cron job to perform daily..."
    echo "/bin/bash /root/$SCRIPT" > /etc/cron.daily/"$NAME"
elif [ "$TIME" = "weekly" ]; then
    echo "Setting cron job to perform weekly..."
    echo "/bin/bash /root/$SCRIPT" > /etc/cron.weekly/"$NAME"
elif [ "$TIME" = "monthly" ]; then
    echo "Setting cron job to perform daily..."
    echo "/bin/bash /root/$SCRIPT" > /etc/cron.monthly/"$NAME"
else 
    echo "Setting cron job..."
    echo "$TIME /bin/bash /root/$SCRIPT" > /etc/cron.d/"$NAME"
fi