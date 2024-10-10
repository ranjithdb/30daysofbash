#!/bin/bash

FILES_TO_BACKUP="/home/ran/Desktop/file1.txt /home/ran/Desktop/file2.txt /home/ran/Desktop/lol/file2.txt /home/ran/Desktop/file3here/lol/file3.txt"

BACKUP_LOCATION="/home/ran/Desktop/backups"

TIMESTAMPFORFOLDERS=$(date +"%d-%m-%Y")
TIMESTAMPFORFILES=$(date +"%d-%m-%Y_%H-%M-%S")

BACKUP_FOLDER="$BACKUP_LOCATION/backup_$TIMESTAMPFORFOLDERS"
mkdir -p "$BACKUP_FOLDER"

for FILE in $FILES_TO_BACKUP; do
    ABSOLUTE_PATH=$(realpath "$FILE")
    SAFE_PATH=$(echo "$ABSOLUTE_PATH" | tr '/' '_')
    BACKUP_FILE="$BACKUP_FOLDER/backup_${SAFE_PATH}_$TIMESTAMPFORFILES.tar.gz"
    tar -czf "$BACKUP_FILE" -C "$(dirname "$FILE")" "$(basename "$FILE")"
    echo "Backup of $FILE completed! Stored at: $BACKUP_FILE"
done

echo "All backups completed successfully"
