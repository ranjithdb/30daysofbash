#!/bin/bash

# Display the OS version
echo "===== Operating System Information ====="
cat /etc/os-release | grep -v -E "http|https"

# Display CPU information
echo -e "\n===== CPU Information ====="
lscpu | grep -E 'Architecture|CPU op-mode|CPU\(s\)|Vendor ID|Model name' | grep -v -E 'On-line|NUMA'


# Display memory information
echo -e "\n===== Memory Information ====="
free -h

# Display disk usage
echo -e "\n===== Disk Usage ====="
df -h

# Display uptime
echo -e "\n===== System Uptime ====="
uptime -p
echo -e "\n===== System up since ====="
uptime -s

# Display the current date and time
echo -e "\n===== Current Date and Time ====="
date
