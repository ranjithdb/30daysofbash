#!/bin/bash


DATE=$(date +%d-%m-%Y)
LOGFILE=updatelog_$DATE.log

#use absolute path for cronjob to work properly
#LOGFILE=/home/ran/Desktop/updatelog_$DATE.log

echo "updating package list..." | tee -a "$LOGFILE"
sudo apt update >> "$LOGFILE" 2>&1

UPGRADE_LIST=$(apt list --upgradable)
echo "Updates found for these packages...$UPGRADE_LIST" | tee -a "$LOGFILE"

echo "Upgrading installed packages..." | tee -a "$LOGFILE"
sudo apt upgrade -y >> "$LOGFILE" 2>&1

echo "Removing unnecessary packages..." | tee -a "$LOGFILE"
sudo apt autoremove  -y >> "$LOGFILE" 2>&1

echo "Cleaning up package cache..." | tee -a "$LOGFILE"
sudo apt clean >> "$LOGFILE" 2>&1


echo "System updates and cleanup completed." | tee -a "$LOGFILE"
