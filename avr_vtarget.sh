#!/bin/bash

# Check if MCU and COMMAND are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <MCU> read_vtg"
    echo "Usage: $0 <MCU> write_vtg <TARGET>"
    echo "Example: $0 avr16eb32 read_vtg"
    echo "Example: $0 avr16eb32 write_vtg 5.0"
    exit 1
fi

MCU=$1
COMMAND=$2
TARGET=$3

if [ "$COMMAND" == "read_vtg" ]; then
    # Read vtarget
    avrdude -c pkobn_updi -p "$MCU" -P usb -x vtarg
elif [ "$COMMAND" == "write_vtg" ]; then
    # Write specific vtarget
    avrdude -c pkobn_updi -p "$MCU" -P usb -x vtarg=$TARGET
else
    echo "Unknown command: $COMMAND"
    echo "Available commands: read_vtg, write_vtg"
    exit 1
fi
