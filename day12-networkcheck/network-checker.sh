#!/bin/bash


SERVERS=("8.8.8.8" "1.1.1.1" "www.google.com" "www.example.com" "http://localhost:4040")

LOGFILE="network_connectivity.log"

check_connectivity() {
    for server in "${SERVERS[@]}"; do
        if ping -c 1 -W 1 "$server" > /dev/null 2>&1; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - $server is reachable." >> "$LOGFILE"
        else
            echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: $server is unreachable!" >> "$LOGFILE"
        fi
    done
}

check_connectivity

