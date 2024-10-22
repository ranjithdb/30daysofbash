#!/bin/bash

LOGFILE="env-setup.log"
CONF_FILE="./requirements.conf"

log_message() {
    echo "$(date): $1" | tee -a "$LOGFILE"
}

if [ ! -f "$CONF_FILE" ]; then
    log_message "Configuration file not found: $CONF_FILE"
    exit 1
fi

source "$CONF_FILE"

if [ "$NODEJS" -eq 1 ]; then
    log_message "Checking for Node.js..."
    if ! command -v node &> /dev/null; then
        log_message "Node.js not found. Installing Node.js..."
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - >> "$LOGFILE" 2>&1
        sudo apt install -y nodejs >> "$LOGFILE" 2>&1
        log_message "Node.js installed successfully."
    else
        log_message "Node.js is already installed."
    fi
fi

if [ "$PYTHON" -eq 1 ]; then
    log_message "Checking for Python..."
    if ! command -v python3 &> /dev/null; then
        log_message "Python not found. Installing Python..."
        sudo apt update >> "$LOGFILE" 2>&1
        sudo apt install -y python3 python3-pip >> "$LOGFILE" 2>&1
        log_message "Python installed successfully."
    else
        log_message "Python is already installed."
    fi
fi

if [ "$JAVA" -eq 1 ]; then
    log_message "Checking for Java..."
    if ! command -v java &> /dev/null; then
        log_message "Java not found. Installing Java..."
        sudo apt update >> "$LOGFILE" 2>&1
        sudo apt install -y default-jdk >> "$LOGFILE" 2>&1
        log_message "Java installed successfully."
    else
        log_message "Java is already installed."
    fi
fi

log_message "Environment setup completed."

