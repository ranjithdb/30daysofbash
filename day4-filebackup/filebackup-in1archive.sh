#!/bin/bash

FILES_TO_BACKUP="/home/ran/Desktop/file1.txt /home/ran/Desktop/file2.txt /home/ran/Desktop/lol/file2.txt /home/ran/Desktop/file3here/lol/file3.txt"

BACKUP_LOCATION="/home/ran/Desktop/backups"

TIMESTAMPFORFOLDERS=$(date +"%d-%m-%Y")
TIMESTAMPFORFILES=$(date +"%d-%m-%Y_%H-%M-%S")

BACKUP_FOLDER="$BACKUP_LOCATION/backup_$TIMESTAMPFORFOLDERS"
mkdir -p "$BACKUP_FOLDER"

BACKUP_FILE="$BACKUP_FOLDER/backup_files_$TIMESTAMPFORFILES.tar"

tar -cf "$BACKUP_FILE" --files-from=/dev/null

for FILE in $FILES_TO_BACKUP; do
    ABSOLUTE_PATH=$(realpath "$FILE")
    SAFE_PATH=$(echo "$ABSOLUTE_PATH" | tr '/' '_')
    tar --transform "s|^/|_|" -rf "$BACKUP_FILE" -C "$(dirname "$FILE")" "$(basename "$FILE")"
    echo "Backup of $FILE completed! Stored at: $BACKUP_FILE.gz"
done

gzip "$BACKUP_FILE"


echo "All backups completed successfully"
