#!/bin/bash

THRESHOLD_CPU=80         # CPU usage threshold in percentage
THRESHOLD_DISK=20        # Disk usage threshold in percentage
EMAIL=""  # Recipient email address
SUBJECT="System Alert Notification"
LOG_FILE="system_alert.log"

send_email() {
    local message="$1"
    echo "$message" | mail -s "$SUBJECT" "$EMAIL"
}

log_and_email() {
    local message="$1"
    echo "$(date): $message" | tee -a "$LOG_FILE"
    send_email "$message"
}

check_cpu_usage() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    CPU_USAGE_INT=${CPU_USAGE%.*}  # Remove decimal

    if (( CPU_USAGE_INT > THRESHOLD_CPU )); then
        log_and_email "High CPU usage detected: ${CPU_USAGE}%"
    fi
}

check_disk_usage() {
    DISK_USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')
    
    if (( DISK_USAGE > THRESHOLD_DISK )); then
        log_and_email "Low disk space detected: ${DISK_USAGE}% used on root partition"
    fi
}

echo "Running System Alert Check..."

check_cpu_usage
check_disk_usage

echo "System Alert Check completed."

