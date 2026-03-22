#!/bin/bash

# Check if MCU and COMMAND are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <MCU> read [FUSE_NAME]"
    echo "Usage: $0 <MCU> write <FUSE_NAME> <VALUE>"
    echo "Example: $0 avr16eb32 read"
    echo "Example: $0 avr16eb32 read fuse2"
    echo "Example: $0 avr16eb32 write fuse2 0x02"
    exit 1
fi

MCU=$1
COMMAND=$2

if [ "$COMMAND" == "read" ]; then
    FUSE=$3
    if [ -n "$FUSE" ]; then
        # Read a specific fuse
        avrdude -c pkobn_updi -p "$MCU" -U "$FUSE:r:-:h"
    else
        # Read all common fuses
        avrdude -c pkobn_updi -p "$MCU" \
            -U fuse0:r:-:h \
            -U fuse1:r:-:h \
            -U fuse2:r:-:h \
            -U fuse5:r:-:h \
            -U fuse6:r:-:h \
            -U fuse7:r:-:h \
            -U fuse8:r:-:h \
            -U fusea:r:-:h
    fi
elif [ "$COMMAND" == "write" ]; then
    FUSE=$3
    VALUE=$4
    if [ -z "$FUSE" ] || [ -z "$VALUE" ]; then
        echo "Error: Write command requires <FUSE_NAME> and <VALUE>"
        exit 1
    fi
    # Write specific fuse
    avrdude -c pkobn_updi -p "$MCU" -U "$FUSE:w:$VALUE:m"
else
    echo "Unknown command: $COMMAND"
    echo "Available commands: read, write"
    exit 1
fi
