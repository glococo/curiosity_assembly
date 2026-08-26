---
name: build-and-flash
description: >-
  Build, disassemble, inspect, configure fuses, and flash assembly programs to Microchip Curiosity Nano boards.
---

# Build, Flash & Hardware Configuration

This skill provides step-by-step instructions for assembling, inspecting, and flashing code onto Curiosity Nano kits.

## 1. Building and Flashing

Execute `curiosity.sh` with the target board name and the main entry file:

```bash
./curiosity.sh <BOARD_NAME> <PROGRAM_PATH>
```

### Examples:
```bash
# Build and flash LED blink for AVR16EB32 Curiosity Nano
./curiosity.sh avr16eb32_cnano examples/01_blink_led/main.S

# Build and flash Math verification suite on AVR128DA48
./curiosity.sh avr128da48_cnano examples/06_math_lib/main.S
```

## 2. Inspecting Disassembly

Use the `-debug` flag to generate and print the full disassembly (`avr-objdump -d -m avr6`):

```bash
./curiosity.sh -debug avr64du32_cnano examples/26_usb_hid/main.S
```

## 3. Fuse Management

Inspect and program UPDI fuses using `avr_fuses.sh`:

```bash
# Read all fuses
./avr_fuses.sh <mcu_name> read

# Example: Read fuses for avr16eb32
./avr_fuses.sh avr16eb32 read

# Write a specific fuse byte
./avr_fuses.sh <mcu_name> write <fuse_name> <hex_value>
# Example:
./avr_fuses.sh avr16eb32 write fuse2 0x02
```

## 4. Target Voltage Configuration

Adjust Curiosity Nano onboard power supply voltage using `avr_vtarget.sh`:

```bash
./avr_vtarget.sh 3.3
./avr_vtarget.sh 5.0
```
