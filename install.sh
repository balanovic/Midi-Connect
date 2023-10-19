#!/bin/bash

# Define the source files
RULES_FILE="99-midi-autoconnect.rules"
SCRIPT_FILE="midi-autoconnect.sh"

# Define the destination directories
RULES_DEST="/etc/udev/rules.d/"
SCRIPT_DEST="/usr/local/bin/"

# Check if script is run as root, which is necessary for copying files to /etc and /usr/local/bin
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Copy the files to the respective directories
echo "Copying $RULES_FILE to $RULES_DEST..."
cp $RULES_FILE $RULES_DEST

echo "Copying $SCRIPT_FILE to $SCRIPT_DEST..."
cp $SCRIPT_FILE $SCRIPT_DEST

# Make the script executable
chmod +x $SCRIPT_DEST$SCRIPT_FILE

# Reload udev rules
echo "Reloading udev rules..."
udevadm control --reload-rules
udevadm trigger

echo "Installation completed successfully."

