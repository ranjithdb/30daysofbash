#!/bin/bash

LOG_FILE="/var/log/apache2/access.log"
LOG_OUTPUT="log_analysis_output.txt"

if [[ ! -f "$LOG_FILE" ]]; then
    echo "Error: Log file not found: $LOG_FILE"
    exit 1
fi

{
    echo "Log File Analysis - $(date)"
    echo "----------------------------"

    total_requests=$(wc -l < "$LOG_FILE")
    echo "Total Requests: $total_requests"

    echo -e "\nHTTP Status Code Counts:"
    awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr

    echo -e "\nHTTP Request Method Counts:"
    awk '{print $6}' "$LOG_FILE" | cut -d'"' -f2 | sort | uniq -c | sort -nr

    error_requests=$(awk '{ if ($9 ~ /^[45]/) print $9 }' "$LOG_FILE" | wc -l)
    error_rate=$(awk "BEGIN {printf \"%.2f\", ($error_requests / $total_requests) * 100}")
    echo -e "\nError Rate: $error_rate% ($error_requests errors)"

    echo -e "\nTop 10 Most Common Requests:"
    awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10

    echo -e "\nTop 5 IPs by Request Count:"
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5

} > "$LOG_OUTPUT"

echo "Log analysis complete. See $LOG_OUTPUT for details."

