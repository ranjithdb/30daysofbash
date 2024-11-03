#!/bin/bash

SITES=("facebook.com" "instagram.com" "youtube.com")

HOSTS_FILE="/etc/hosts"
BACKUP_FILE="/etc/hosts.backup"
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Creating backup of the hosts file."
    sudo cp "$HOSTS_FILE" "$BACKUP_FILE"
fi

block_site() {
    local site=$1
    if ! grep -q "$site" "$HOSTS_FILE"; then
        echo "Blocking $site"
        echo "127.0.0.1 $site www.$site" | sudo tee -a "$HOSTS_FILE" > /dev/null
    else
        echo "$site is already blocked."
    fi
}


for site in "${SITES[@]}"; do
    block_site "$site"
done

echo "Specified websites have been blocked."


