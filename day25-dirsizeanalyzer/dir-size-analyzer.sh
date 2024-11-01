#!/bin/bash

# Usage: ./dir-size-analyzer.sh [directory] [num]
# Example: ./dir-size-analyzer.sh /path/to/directory 10

if [ $# -lt 1 ]; then
    echo "Usage: $0 [directory] [num]"
    exit 1
fi

DIRECTORY=$1
NUM=${2:-10}  # Default to 10 if not provided
LOGFILE="dir_size_analysis.log"

echo -e "\n Directory Size Analysis - $(date)" >> "$LOGFILE"
echo "Analyzing directory: '$DIRECTORY'" >> "$LOGFILE"

{
    echo "Largest directories in '$DIRECTORY':"
    du -h --max-depth=1 "$DIRECTORY" 2>/dev/null | sort -hr | tail -n +2 | head -n "$NUM"
} | tee -a "$LOGFILE"

{
    echo -e "\nLargest files in '$DIRECTORY':"
    find "$DIRECTORY" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n "$NUM"
} | tee -a "$LOGFILE"

