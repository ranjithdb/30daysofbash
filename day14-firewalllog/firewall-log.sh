#!/bin/bash

LOGFILE="firewall_config.log"

# Function to check nftables rules
check_nftables() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Checking nftables rules" | tee -a "$LOGFILE"
    sudo nft list ruleset >> "$LOGFILE" 2>&1
    if [[ $? -ne 0 ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Failed to get nftables rules" | tee -a "$LOGFILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Successfully logged nftables rules" | tee -a "$LOGFILE"
    fi
}

check_iptables() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Checking iptables rules" | tee -a "$LOGFILE"
    sudo iptables -L -v -n >> "$LOGFILE" 2>&1
    if [[ $? -ne 0 ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Failed to get iptables rules" | tee -a "$LOGFILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Successfully logged iptables rules" | tee -a "$LOGFILE"
    fi
}

check_firewalld() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Checking firewalld rules" | tee -a "$LOGFILE"
    sudo firewall-cmd --list-all >> "$LOGFILE" 2>&1
    if [[ $? -ne 0 ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: Failed to get firewalld rules" | tee -a "$LOGFILE"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Successfully logged firewalld rules" | tee -a "$LOGFILE"
    fi
}

if systemctl is-active --quiet firewalld; then
    check_firewalld
elif command -v nft > /dev/null && sudo nft list ruleset > /dev/null 2>&1; then
    check_nftables
elif command -v iptables > /dev/null && sudo iptables -L > /dev/null 2>&1; then
    check_iptables
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - ERROR: No active firewall service detected (firewalld, nftables, or iptables)" | tee -a "$LOGFILE"
fi

