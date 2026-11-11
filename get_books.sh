#!/bin/bash

set -euo pipefail

BUCKET_NAME="$1"
DIRECTORY="$2"

if [ ! -d "$DIRECTORY" ]; then
    mkdir -p "$DIRECTORY"
fi

aws s3 cp "s3://$BUCKET_NAME/" "$DIRECTORY" --recursive --exclude "*"  --include "*.txt"

echo "File path" > book_list.txt
find "$(realpath "$DIRECTORY")" -name "*.txt" | sort >> book_list.txt

echo "Wrote $(( $(wc -l < book_list.txt) - 1 )) book files to book_list.txt"

