#!/bin/bash

# Get the current date and timestamp
DATE=$(date +"%d-%m-%Y")
TIMESTAMP=$(date +"%d-%m-%Y_%H-%M-%S")

# Create a directory for the current date if it doesn't exist
BACKUP_DIR="terminallogs_${DATE}"
mkdir -p "$BACKUP_DIR"

# Define log file names with timestamp, stored in the daily folder
OUTPUT_LOG="${BACKUP_DIR}/output_${TIMESTAMP}.log"
INPUT_LOG="${BACKUP_DIR}/input_${TIMESTAMP}.log"
TIMING_LOG="${BACKUP_DIR}/timing_${TIMESTAMP}.log"
CLEAN_LOG="${BACKUP_DIR}/clean_output_${TIMESTAMP}.log"

# Start recording the terminal session
script --log-in="$INPUT_LOG" --log-out="$OUTPUT_LOG" --log-timing="$TIMING_LOG" --quiet

# Use perl to strip all escape sequences and control characters
perl -pe 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' "$OUTPUT_LOG" | sed -r 's/\x1b\[[0-9;]*[a-zA-Z]//g' | sed 's/\r//' > "$CLEAN_LOG"

echo "Cleaned log file stored at: $CLEAN_LOG"
echo "Session logging completed."

