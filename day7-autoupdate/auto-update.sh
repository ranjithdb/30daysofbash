#!/bin/bash


DATE=$(date +%d-%m-%Y)
#LOGFILE=updatelog_$DATE.log

#use absolute path for cronjob to work properly
LOGFILE=/home/ran/Desktop/auto-updatelog_$DATE.log

PASSWORD="yourpassword"

echo "updating package list..." | tee -a "$LOGFILE"
echo "$PASSWORD" | sudo -S apt update >> "$LOGFILE" 2>&1

UPGRADE_LIST=$(apt list --upgradable)
echo "Updates found for these packages...$UPGRADE_LIST" | tee -a "$LOGFILE"

echo "Upgrading installed packages..." | tee -a "$LOGFILE"
echo "$PASSWORD" | sudo -S apt upgrade -y >> "$LOGFILE" 2>&1

echo "Removing unnecessary packages..." | tee -a "$LOGFILE"
echo "$PASSWORD" | sudo -S apt autoremove  -y >> "$LOGFILE" 2>&1

echo "Cleaning up package cache..." | tee -a "$LOGFILE"
echo "$PASSWORD" | sudo -S apt clean >> "$LOGFILE" 2>&1


echo "System updates and cleanup completed." | tee -a "$LOGFILE"
