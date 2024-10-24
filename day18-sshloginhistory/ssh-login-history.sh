#!/bin/bash

LOGFILE="ssh_login_tracker.log"

echo "SSH Login Tracker - $(date)" >> "$LOGFILE"

echo "Checking for failed login attempts..." >> "$LOGFILE"
sudo journalctl _COMM=sshd | grep "Failed password" >> "$LOGFILE"

echo "Checking for successful login attempts..." >> "$LOGFILE"
sudo journalctl _COMM=sshd | grep "Accepted password" >> "$LOGFILE"

echo "SSH login tracking completed." >> "$LOGFILE"

