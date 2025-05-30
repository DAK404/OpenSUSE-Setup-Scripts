#!/bin/bash

# Define the output directory
OUTPUT_DIR="$HOME/.boot/bootgraph"

# Create the directory only if it doesn't exist
if [ ! -d "$OUTPUT_DIR" ]; then
    mkdir -p "$OUTPUT_DIR"
fi

# Generate the filename with date-time
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
FILENAME="boot-$TIMESTAMP.svg"

# Generate the boot graph
systemd-analyze plot > "$OUTPUT_DIR/$FILENAME"