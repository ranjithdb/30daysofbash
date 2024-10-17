#!/bin/bash

# Set the threshold (e.g., 80 for 80%)
THRESHOLD=80


LOGFILE="/var/log/disk_usage_monitor.log"


check_disk_usage() {
    df -h --output=pcent,target | tail -n +2 | while read -r line; do
        usage=$(echo "$line" | awk '{print $1}' | sed 's/%//')
        partition=$(echo "$line" | awk '{print $2}')
        
        if [ "$usage" -gt "$THRESHOLD" ]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Warning: Disk usage on $partition is at $usage%." >> "$LOGFILE"
        fi
    done
}

check_disk_usage

