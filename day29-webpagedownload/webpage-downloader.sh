#!/bin/bash

SAVE_DIR="downloaded_webpage"

read -p "Enter the URL of the webpage to download: " URL

if [ -z "$URL" ]; then
  echo "No URL provided. Exiting."
  exit 1
fi

mkdir -p "$SAVE_DIR"

wget -E -H -k -K -p -P "$SAVE_DIR" "$URL"

echo "Download completed. Files are saved in the '$SAVE_DIR' directory."

