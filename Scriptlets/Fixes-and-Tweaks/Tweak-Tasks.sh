#!/bin/bash

LOGIN_TASKS_CONTENT="#!/bin/bash

# Define the output directory
OUTPUT_DIR=\"\$HOME/.boot/bootgraph\"

# Create the directory only if it doesn't exist
if [ ! -d \"\$OUTPUT_DIR\" ]; then
    mkdir -p \"\$OUTPUT_DIR\"
fi

# Generate the filename with date-time
TIMESTAMP=\$(date '+%Y-%m-%d_%H-%M-%S')
FILENAME=\"boot-\$TIMESTAMP.svg\"

# Generate the boot graph
systemd-analyze plot > \"\$OUTPUT_DIR/\$FILENAME\""

# Ensure the target directory exists
mkdir -p ~/.tasks

# Write the content to a file
echo "$LOGIN_TASKS_CONTENT" > ~/.tasks/login.sh

# Make it executable
chmod +x ~/.tasks/login.sh
