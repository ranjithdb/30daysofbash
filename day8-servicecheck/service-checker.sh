#!/bin/bash

LOGFILE="/home/ran/Desktop/service-checker.log"

check_service() {
    local service=$1

    echo "Checking $service status..." | tee -a "$LOGFILE"
    
    if systemctl is-active --quiet "$service"; then
        echo "$service is running." | tee -a "$LOGFILE"
    else
        echo "$service is not running. Attempting to restart..." | tee -a "$LOGFILE"
        sudo systemctl restart "$service"
        

        if systemctl is-active --quiet "$service"; then
            echo "$service has been restarted successfully." | tee -a "$LOGFILE"
        else
            echo "Failed to restart $service. Manual intervention may be required." | tee -a "$LOGFILE"
        fi
    fi
}

check_service "nginx"
check_service "docker"


