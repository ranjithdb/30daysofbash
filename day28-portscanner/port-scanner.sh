#!/bin/bash

# Usage: ./port-scanner.sh <host> <start_port> <end_port>
HOST=$1
START_PORT=$2
END_PORT=$3
LOGFILE="portscan_log_$(date +'%Y-%m-%d_%H-%M-%S').log"

if [[ -z "$HOST" || -z "$START_PORT" || -z "$END_PORT" ]]; then
  echo "Usage: $0 <host> <start_port> <end_port>"
  exit 1
fi

echo "Port Scan Log for $HOST" | tee -a "$LOGFILE"
echo "Scan Date: $(date)" | tee -a "$LOGFILE"
echo "Scanning ports from $START_PORT to $END_PORT..." | tee -a "$LOGFILE"

for (( port=$START_PORT; port<=$END_PORT; port++ )); do
  nc -z -v -w 1 "$HOST" "$port" &> /dev/null
  
  if [ $? -eq 0 ]; then
    echo "Port $port is open" | tee -a "$LOGFILE"
  else
    echo "Port $port is closed" | tee -a "$LOGFILE"
  fi
done

echo "Port scan complete." | tee -a "$LOGFILE"
echo "Log saved to $LOGFILE"

