# AVR Assembly HAL Framework

A lightweight Hardware Abstraction Layer (HAL) and mathematical library for modern AVR microcontrollers (AVR-Dx and AVR-Ex series), written entirely in assembly. This project provides a structured way to develop high-performance assembly applications for devices like the AVR16EB32, AVR128DB48, and AVR64DU32.

## Project Structure

- **`Hal/`**: Core library files.
  - `_HAL_Macro.S`: Essential macros for function definitions, ISRs, and register management.
  - `_HAL_AVR_2020.S`: Clock scaling, prescaler management, and USART baud rate calculations.
  - `_HAL_Delay.S`: Cycle-accurate software delays aware of CPU frequency.
  - `_HAL_Print.S`: String and number printing utilities for USART.
  - `_MATH_*.S`: Optimized 16-bit and 32-bit mathematical routines (MUL, DIV, SHIFTS).
- **`Boards/`**: Board-specific configurations and pin mappings for Curiosity Nano evaluation boards.
- **`Examples/`**: Demonstration projects.
  - `Hello_world`: Basic LED toggle and UART output.
  - `Cpu_Scaling`: Demonstration of dynamic clock frequency adjustment.
- **`curiosity.sh`**: Main build and flash script.

## Key Features

- **Structured Assembly**: Uses `DEFUN` and `ENDF` macros for clean, readable function definitions.
- **Clock Awareness**: HAL routines automatically adjust to the current CPU frequency for accurate delays and baud rates.
- **Optimized Math**: High-performance implementations of multiplication, division, and multi-byte shifts.
- **Interrupt Support**: Streamlined ISR entry/exit macros (`ISR_START`, `ISR_END`).
- **Modern AVR Support**: Tailored for the latest AVR architectures with UPDI programming.

## Prerequisites

To build and flash this project, you need:
- **AVR-GCC**: The GNU compiler collection for AVR.
- **AVR-Libc**: Standard library for AVR.
- **AVRDude**: For flashing the compiled HEX files to the microcontroller.
- **Hardware**: A supported Curiosity Nano board (e.g., AVR16EB32 CNANO).

## Building and Flashing

Use the provided `curiosity.sh` script to compile and flash an example. The script takes three arguments: the target MCU, the board file, and the main program file.

```bash
./curiosity.sh <MCU> <BOARD_FILE> <PROGRAM_FILE>
```

### Example: Hello World on AVR16EB32

```bash
./curiosity.sh avr16eb32 Boards/AVR16EB32_CNANO.S Examples/Hello_world/main.S
```

### Utility Scripts

- **`curiosity_fuses.sh`**: Reads and displays the fuse settings for the connected microcontroller.
  ```bash
  ./curiosity_fuses.sh avr16eb32
  ```

## Usage Example

Functions are defined using the `DEFUN` macro and can be called using `rcall`.

```assembly
#include "Boards/AVR16EB32_CNANO.S"

DEFUN main
  main:
    rcall   HAL_BOARD_SETUP
    sei

  loop:
    ; Toggle LED and delay for 1 second
    rcall toggle_led
    HAL_DELAY_MS 1000
    rjmp loop
ENDF main
```

## Programming "Social Contract" (ABI)

To maintain high performance and consistency, this framework follows a "Social Contract" regarding register usage. Adhering to these conventions ensures that HAL modules and mathematical routines work together seamlessly.

### Register Conventions

- **`r15` (Zero Register)**: By convention, `r15` is treated as a permanent zero. It is used for efficient carry and borrow propagation (e.g., `adc rd, r15` or `sbc rd, r15`).
  - **Contract**: Never write to `r15`. Could be initialized to zero at the start of the program (`clr r15`).
- **`r1` (Scratch)**: Unlike the standard AVR GCC ABI, `r1` is *not* a permanent zero. It is used as a scratch register, especially since it is modified by `mul` instructions.
- **`r10` (Persistent State)**: Often used as a dedicated register for global application state, such as the `TOGGLE_REG` in example projects.
- **`r22` to `r25` (Primary Work)**: Standard registers for passing 8-bit, 16-bit and 32-bit arguments and return values.
- **`r16-r23` (Volatile)**: Caller-saved registers used for temporary storage and additional function arguments.
- **`X` (r27:r26), `Z` (r31:r30)**: Pointer registers. `Z` is the primary pointer for flash access (`lpm`), and `X` is used for RAM indexing.
- **`Y` (r29:r28)**: Callee-saved register. Must be pushed and popped if used within a function.

## License

This project is licensed under the **GNU General Public License v3.0**. See the `LICENSE` file for details.
