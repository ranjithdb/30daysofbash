#!/bin/bash

# Log file path
LOGFILE="/home/ran/Desktop/service-checker.log"


check_service() {
    local service=$1

    # Log the check
    echo "Checking $service status..." | tee -a "$LOGFILE"
    
    # Check if the service is active
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


