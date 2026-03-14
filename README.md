# AVR Assembly HAL Framework

A lightweight Hardware Abstraction Layer (HAL) and mathematical library for modern AVR microcontrollers (AVR-Dx and AVR-Ex series), written entirely in assembly. This project provides a structured way to develop high-performance assembly applications for devices like the AVR16EB32, AVR128DB48, and AVR64DU32.

## Project Structure

- **`Hal/`**: Core library files.
  - `HAL_Macro.S`: Essential macros for function definitions (`DEFUN`/`ENDF`), ISRs, and register management.
  - `HAL_CORE.S`: CPU clock scaling and prescaler management.
  - `HAL_USART.S`: USART configuration and baud rate calculations.
  - `HAL_BYTE_BUFFER.S`: High-performance power-of-two Byte Ring Buffer.
  - `HAL_Delay.S`: Cycle-accurate software delays aware of dynamic CPU frequency.
  - `HAL_RTC.S`: Real-Time Counter (RTC) and Periodic Interrupt Timer (PIT) support.
  - `MATH_*.S`: Optimized 16-bit and 32-bit mathematical routines (MUL, DIV, SHIFTS).
- **`Boards/`**: Board-specific configurations and pin mappings for Curiosity Nano evaluation boards.
- **`Examples/`**: Demonstration projects.
  - `Hello_world`: Basic LED toggle and direct USART output.
  - `Clock_scaling`: Dynamic CPU frequency adjustment and peripheral re-calculation.
  - `Ring_buffer`: Buffered USART transmission using the circular buffer.
  - `RTC`: Timed events using the Real-Time Counter.
- **`curiosity.sh`**: Main build and flash script.

## Key Features

- **Structured Assembly**: Uses `DEFUN` and `ENDF` macros for clean, readable, and linkable function definitions.
- **Clock Awareness**: HAL routines automatically adjust to the current CPU frequency for accurate delays and baud rates even after scaling.
- **Optimized Math**: High-performance implementations of multiplication, division, and multi-byte shifts.
- **Efficient Buffering**: Power-of-two ring buffers using bitwise masking for ultra-fast wrapping.
- **Interrupt Support**: Streamlined ISR entry/exit macros (`ISR_START`, `ISR_END`) that preserve SREG.
- **Modern AVR Support**: Tailored for the latest AVR architectures with UPDI programming.

## Prerequisites

To build and flash this project, you need:
- **AVR-GCC**: The GNU compiler collection for AVR.
- **AVR-Libc**: Standard library for AVR.
- **AVRDude**: For flashing the compiled HEX files to the microcontroller.
- **Hardware**: A supported Curiosity Nano board (e.g., AVR16EB32 CNANO).
- **Ubuntu/Debian**: `sudo apt install gcc-avr avrdude avr-libc`

## Building and Flashing

Use the provided `curiosity.sh` script to compile and flash an example. The script takes three arguments: the target MCU, the board file, and the main program file.

```bash
./curiosity.sh <MCU> <BOARD_NAME> <PROGRAM_FILE>
```

### Example: Ring Buffer on AVR16EB32

```bash
./curiosity.sh avr16eb32 AVR16EB32_CNANO Examples/Ring_buffer/main.S
```

### Utility Scripts

- **`curiosity_fuses.sh`**: Reads and displays the fuse settings for the connected microcontroller.
  ```bash
  ./curiosity_fuses.sh avr16eb32
  ```

## Usage Example

Functions are defined using the `DEFUN` macro and called via `rcall`. The HAL handles hardware complexity behind simple interfaces.

```assembly
; Example of a main loop using HAL
DEFUN main
  main:
    rcall   HAL_BOARD_SETUP       ; Basic board initialization
    sei                           ; Global interrupt enable

  loop:
    ldi     r19, LED_PIN
    sts     _(LED_PORT, _OUTTGL), r19 ; Atomic pin toggle
    HAL_DELAY_MS 1000             ; Frequency-aware delay
    rjmp    loop
ENDF main
```

## HAL ABI (Social Contract)

To maintain high performance and consistency, this framework follows a specific register usage convention.

### Register Conventions

- **`__zero_reg__` (r2)**: Treated as a permanent zero. Used for efficient propagation of carries/borrows.
  - **Contract**: Initialized by the HAL. Never write to `r2`.
- **`r16` to `r21` (Volatile)**: Caller-saved registers. Used for temporary storage and additional function arguments.
- **`r22` to r25 (Primary Work)**: Standard registers for passing 8-bit, 16-bit, and 32-bit arguments and return values.
- **`X` (r27:r26)**: Primary pointer for RAM indexing (Buffers and Structures).
- **`Y` (r29:r28)**: Callee-saved register. Must be pushed/popped if used within a function.
- **`Z` (r31:r30)**: Primary pointer for Flash access (`lpm`) and code jumping (`ijmp`).

## License

This project is licensed under the **GNU General Public License v3.0**. See the `LICENSE` file for details.

## Author's Note

AVR was the family that started it all for me. Returning to it after years of development on other platforms has been a total joy.

The modern AVR-Dx and AVR-Ex series introduce a powerhouse of features: a Unified Memory Map, UPDI, the Event System (EVSYS), and Configurable Custom Logic (CCL). Combined with Multi-Voltage I/O (MVIO), Atomic Port manipulation, crystal-less USB, and revamped peripherals (USART, ADC, and Timers), this architecture is a massive leap forward.

This project was born from a desire to create a high-performance Assembly boilerplate that leverages these modern features while capturing the elegant simplicity of writing in Assembly.

This HAL was made with ❤️ for the AVR community.

