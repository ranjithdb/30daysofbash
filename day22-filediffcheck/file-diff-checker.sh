#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file1> <file2>"
    exit 1
fi

FILE1="$1"
FILE2="$2"

if [[ ! -f "$FILE1" ]] || [[ ! -f "$FILE2" ]]; then
    echo "One or both files do not exist."
    exit 1
fi

echo "Comparing $FILE1 and $FILE2 for differences..."
diff --color=auto -u "$FILE1" "$FILE2"

