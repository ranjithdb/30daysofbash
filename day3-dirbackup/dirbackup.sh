#!/bin/bash

DIRS_TO_BACKUP="/home/ran/Desktop/important"

BACKUP_LOCATION="/home/ran/Desktop/backups"

TIMESTAMPFORFOLDERS=$(date +"%d-%m-%Y")
TIMESTAMPFORFILES=$(date +"%d-%m-%Y_%H-%M-%S")

BACKUP_FOLDER="$BACKUP_LOCATION/backup_$TIMESTAMPFORFOLDERS"
mkdir -p "$BACKUP_FOLDER"


for DIR in $DIRS_TO_BACKUP; do
    ABSOLUTE_PATH=$(realpath "$DIR")
    SAFE_PATH=$(echo "$ABSOLUTE_PATH" | tr '/' '_')
    BACKUP_FILE="$BACKUP_FOLDER/backup${SAFE_PATH}_$TIMESTAMPFORFILES.tar.gz"
    tar -czvf "$BACKUP_FILE" -C "$(dirname "$DIR")" "$(basename "$DIR")"
    echo "Backup of $DIR completed! Stored at: $BACKUP_FILE"

done

echo "All backups completed"
