#!/bin/bash
DEBUG=true

# Check if BOARD and PROGRAM are provided as command-line arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <BOARD_NAME> <PROGRAM_FILE>"
    echo "Example: $0 AVR16EB32_CNANO Examples/Hello_world/main.S"
    exit 1
fi

BOARD=$1
PROGRAM=$2

# Extract MCU from the first line of the board file
# Expects: ; Core: <MCU>
BOARD_FILE="Boards/$BOARD.S"
if [ ! -f "$BOARD_FILE" ]; then
    echo "Error: Board file $BOARD_FILE not found."
    exit 1
fi

MCU=$(head -n 1 "$BOARD_FILE" | sed -n 's/^; Core: //p' | tr -d '\r' | xargs)

if [ -z "$MCU" ]; then
    echo "Error: Could not extract MCU from first line of $BOARD_FILE"
    echo "Expected format: ; Core: <MCU>"
    exit 1
fi

# Compile and link
avr-gcc -mmcu=$MCU -Wl,--gc-sections -Wa,-gstabs -Wall -o main.elf -include "$BOARD_FILE" "$PROGRAM"

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
