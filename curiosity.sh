#!/bin/bash
DEBUG=false

# Check if MCU and BOARD are provided as command-line arguments
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: $0 <MCU> <BOARD_FILE> <PROGRAM_FILE>"
    echo "Example: $0 avr16eb32 Boards/AVR16EB32_CNANO.S Examples/Hello_world/main.S"
    exit 1
fi

MCU=$1
BOARD=$2
PROGRAM=$3

# Compile and link
avr-gcc -mmcu=$MCU -Wl,--gc-sections -Wa,-gstabs -Wall -o main.elf -include Boards/$BOARD.S $PROGRAM

# Create HEX file
avr-objcopy -O ihex main.elf main.hex

if [ $DEBUG == true ]; then
    # Disassemble HEX file for inspection
    avr-objdump -s -m avr6 -D main.hex
fi

# Flash to device using avrdude
avrdude -v -c pkobn_updi -p $MCU -U flash:w:main.hex

# Cleanup temporary build files
rm main.elf main.hex

# DUMP: avrdude -v -c pkobn_updi -p $MCU -U flash:r:board.hex:i
