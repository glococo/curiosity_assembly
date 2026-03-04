#!/bin/bash

# Check if MCU is provided as command-line arguments
if [ -z "$1" ]; then
    echo "Usage: $0 <MCU>"
    echo "Example: $0 avr16eb32"
    exit 1
fi

MCU=$1

avrdude -c pkobn_updi -p $MCU -U fuse0:r:-:h -U fuse1:r:-:h -U fuse2:r:-:h -U fuse5:r:-:h -U fuse6:r:-:h -U fuse7:r:-:h -U fuse8:r:-:h -U fusea:r:-:h
