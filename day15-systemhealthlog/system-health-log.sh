#!/bin/bash

LOGFILE="system_health_log.log"

get_cpu_usage() {
    echo "CPU Usage:" >> "$LOGFILE"
    top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{print 100 - $1"%"}' >> "$LOGFILE"
    echo "" >> "$LOGFILE"
}

get_memory_usage() {
    echo "Memory Usage:" >> "$LOGFILE"
    free -h | awk '/Mem:/ {print "Total: "$2 " | Used: "$3 " | Free: "$4}' >> "$LOGFILE"
    echo "" >> "$LOGFILE"
}

get_disk_usage() {
    echo "Disk Usage:" >> "$LOGFILE"
    df -h --total | awk '/total/ {print "Total: "$2 " | Used: "$3 " | Available: "$4 " | Usage: "$5}' >> "$LOGFILE"
    echo "" >> "$LOGFILE"
}

get_network_usage() {
    echo "Network Usage:" >> "$LOGFILE"
    interface=$(ip route | grep default | awk '{print $5}')
    
    rx_bytes=$(ifconfig $interface | awk '/RX packets/ {print $5}')
    tx_bytes=$(ifconfig $interface | awk '/TX packets/ {print $5}')
    
    rx_mb=$(echo "scale=2; $rx_bytes / 1048576" | bc)
    tx_mb=$(echo "scale=2; $tx_bytes / 1048576" | bc)

    echo "Received: $rx_mb MB | Transmitted: $tx_mb MB" >> "$LOGFILE"
    echo "" >> "$LOGFILE"
}

get_system_uptime() {
    echo "System uptime: " >> "$LOGFILE"
    uptime -p >> "$LOGFILE"
    echo "" >> "$LOGFILE"
    echo "System uptime since: " >> "$LOGFILE"
    uptime -s >> "$LOGFILE"
    echo "" >> "$LOGFILE"
}

output_system_health() {
    echo "==== System Health Log ====" >> "$LOGFILE"
    echo "Time: $(date)" >> "$LOGFILE"
    echo "" >> "$LOGFILE"

    get_cpu_usage
    get_memory_usage
    get_disk_usage
    get_network_usage
    get_system_uptime

    echo "===============================" >> "$LOGFILE"
}

output_system_health

