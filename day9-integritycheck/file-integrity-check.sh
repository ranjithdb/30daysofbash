#!/bin/bash

# Log file path
LOGFILE="/home/ran/Desktop/file-integrity.log"
CHECKSUM_FILE="/home/ran/Desktop/file-checksums.txt"

generate_checksums() {
    local files=("$@")
    
    echo "Generating checksums for critical files..." | tee -a "$LOGFILE"
    > "$CHECKSUM_FILE" 

    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            sha256sum "$file" >> "$CHECKSUM_FILE"
            echo "Checksum generated for $file" | tee -a "$LOGFILE"
        else
            echo "File not found: $file" | tee -a "$LOGFILE"
        fi
    done
}

verify_checksums() {
    echo "Verifying checksums..." | tee -a "$LOGFILE"
    
    if sha256sum -c "$CHECKSUM_FILE" > /dev/null 2>&1; then
        echo "All files match their checksums." | tee -a "$LOGFILE"
    else
        echo "One or more files have been modified!" | tee -a "$LOGFILE"
    fi
}

critical_files=(
    "/etc/ssh/ssh_config"
)

if [[ ! -f "$CHECKSUM_FILE" ]]; then
    echo "Checksum file not found. Generating new checksums..." | tee -a "$LOGFILE"
    generate_checksums "${critical_files[@]}"
else
    verify_checksums
fi

