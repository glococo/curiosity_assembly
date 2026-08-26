#!/bin/bash
DEBUG=false

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -debug) DEBUG=true ;;
        -*) echo "Unknown option: $1"; exit 1 ;;
        *) break ;;
    esac
    shift
done

# Check if BOARD and PROGRAM are provided as command-line arguments
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 [-debug] <BOARD_NAME> <PROGRAM_FILE>"
    echo "Example: $0 AVR16EB32_CNANO Examples/02_Hello_world/main.S"
    exit 1
fi

BOARD=$1
PROGRAM=$2

# Extract MCU from the first line of the board file
# Expects: ; Core: <MCU>
BOARD_LOWER=$(echo "$BOARD" | tr "[:upper:]" "[:lower:]")
if [ -f "boards/$BOARD.S" ]; then
    BOARD_FILE="boards/$BOARD.S"
elif [ -f "boards/$BOARD_LOWER.S" ]; then
    BOARD_FILE="boards/$BOARD_LOWER.S"
else
    echo "Error: Board file boards/$BOARD.S or boards/$BOARD_LOWER.S not found."
    exit 1
fi

MCU=$(head -n 1 "$BOARD_FILE" | sed -n 's/^; Core: //p' | tr -d '\r' | xargs)

if [ -z "$MCU" ]; then
    echo "Error: Could not extract MCU from first line of $BOARD_FILE"
    echo "Expected format: ; Core: <MCU>"
    exit 1
fi

# Identify all C source files in the same directory as the main program
PROGRAM_DIR=$(dirname "$PROGRAM")
C_SOURCES=$(ls "$PROGRAM_DIR"/*.c 2>/dev/null)

# Compile C files to temporary objects
OBJS=""
for f in $C_SOURCES; do
    obj="${f%.c}.o"
    avr-gcc -mmcu=$MCU -Wall -Os -I"$PROGRAM_DIR" -c "$f" -o "$obj" || exit 1
    OBJS="$OBJS $obj"
done

# Compile S files and Link
avr-gcc -mmcu=$MCU -Wl,--gc-sections -Wl,--relax -Wa,-gstabs -Wall -I"$PROGRAM_DIR" -o main.elf -include "$BOARD_FILE" $PROGRAM $OBJS || exit 1

# Cleanup temporary objects
[ -n "$OBJS" ] && rm $OBJS

# Create HEX file
avr-objcopy -O ihex main.elf main.hex || exit 1

if [ $DEBUG == true ]; then
    # Disassemble HEX file for inspection
    avr-objdump -d -m avr6 main.elf
fi

# Flash to device using avrdude
avrdude -v -c pkobn_updi -p $MCU -U flash:w:main.hex

# Cleanup temporary build files
rm main.elf main.hex

# DUMP: avrdude -v -c pkobn_updi -p $MCU -U flash:r:board.hex:i
