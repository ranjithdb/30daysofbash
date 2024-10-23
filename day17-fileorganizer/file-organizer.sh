#!/bin/bash

TARGET_DIR="/home/ran/Desktop/test"

LOGFILE="organize.log"

echo "Organizing files in $TARGET_DIR" | tee -a "$LOGFILE"

organize_files() {
    local extension="$1"
    local ext_dir="$TARGET_DIR/${extension^^}"
    
    if [[ ! -d "$ext_dir" ]]; then
        mkdir -p "$ext_dir"
        echo "Created directory: $ext_dir" | tee -a "$LOGFILE"
    fi

    for file in "$TARGET_DIR"/*."$extension"; do
        if [[ -f "$file" ]]; then
            mv "$file" "$ext_dir"
            echo "Moved file: $file to $ext_dir" | tee -a "$LOGFILE"
        fi
    done
}

file_extensions=$(find "$TARGET_DIR" -type f | sed -n 's/.*\.//p' | sort -u)

for ext in $file_extensions; do
    organize_files "$ext"
done

echo "File organization completed!" | tee -a "$LOGFILE"

