#!/bin/bash

# Define the cron schedule to run every minute
CRON_SCHEDULE="* * * * *"
SCRIPT_PATH="/home/ran/Desktop/demo.sh"

# Add the cron job to the crontab
(crontab -l 2>/dev/null; echo "$CRON_SCHEDULE $SCRIPT_PATH") | crontab -

# List current cron jobs to verify
echo "Cron job added. Current cron jobs:"
crontab -l

echo "crontab -l    to list crontabs"
echo "crontab -r    to remove all crontabs"
echo "crontab -e    to edit crontabs"

