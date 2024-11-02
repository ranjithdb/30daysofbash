#!/bin/bash

LOGFILE="diskcleaner.log"

echo "Disk Cleanup - $(date)" | tee -a "$LOGFILE"
echo "Disk Size before cleaning..." | tee -a "$LOGFILE"
df -h | tee -a "$LOGFILE"
echo "Starting disk cleanup..." | tee -a "$LOGFILE"

echo "Cleaning up APT cache..." | tee -a "$LOGFILE"
sudo apt-get clean >> "$LOGFILE" 2>&1

echo "Removing old kernels..." | tee -a "$LOGFILE"
sudo apt-get autoremove --purge -y >> "$LOGFILE" 2>&1

echo "Removing unused packages..." | tee -a "$LOGFILE"
sudo apt-get autoclean >> "$LOGFILE" 2>&1

echo "Clearing temporary files in /tmp..." | tee -a "$LOGFILE"
sudo rm -rf /tmp/* >> "$LOGFILE" 2>&1

echo "Clearing thumbnail cache..." | tee -a "$LOGFILE"
rm -rf "$HOME/.cache/thumbnails/*" >> "$LOGFILE" 2>&1

#optional clean up all the cache in user home directory
echo "Clearing cache files in ~/.cache..." | tee -a "$LOGFILE"
rm -rf "$HOME/.cache/*" >> "$LOGFILE" 2>&1

echo "Cleaning up systemd journal logs older than 7 days..." | tee -a "$LOGFILE"
sudo journalctl --vacuum-time=7d >> "$LOGFILE" 2>&1

echo "Disk cleanup completed!" | tee -a "$LOGFILE"
echo "Disk Size after cleaning..." | tee -a "$LOGFILE"
df -h | tee -a "$LOGFILE"

