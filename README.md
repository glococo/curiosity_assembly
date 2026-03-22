# ⚡ AVR Assembly HAL Framework

A professional-grade, lightweight **Hardware Abstraction Layer (HAL)** and **Mathematical Library** for modern AVR microcontrollers (AVR-Dx and AVR-Ex series). Built entirely in optimized assembly, this framework provides a high-performance foundation for mission-critical embedded applications.

---

## 🚀 Key Features

- **🎯 Zero-Overhead Abstraction**: Clean, linkable function definitions using `DEFUN` and `ENDF` macros.
- **🕒 Clock-Aware Timing**: Automatic frequency adjustment for cycle-accurate delays and peripheral baud rates.
- **🧮 High-Performance Math**: Optimized 16-bit and 32-bit routines for multiplication, division, and multi-byte shifts.
- **📊 Efficient Data Structures**: 
  - **Power-of-Two Ring Buffers**: Ultra-fast bitwise wrapping for low-latency I/O.
  - **Zero-Copy Double-Buffering**: Ping-pong architecture for high-speed peripheral data transfer.
- **📠 Professional Printing**: Robust string and numeric formatting (UINT8, UINT16, UINT32) for diagnostic output.
- **⚡ Modern AVR Support**: Tailored for the latest AVR architectures (AVR-Dx, AVR-Ex) with UPDI programming and Unified Memory Map.

---

## 📂 Project Structure

### 🛠️ Core HAL (`Hal/`)
- **`ALL.S`**: Master include file—your one-stop shop for the entire framework.
- **`HAL_MACRO.S`**: Essential primitives for function definitions, ISR management, and atomic register access.
- **`HAL_CORE.S`**: CPU clock scaling, prescaler management, and system initialization.
- **`HAL_DELAY.S`**: Frequency-aware, cycle-accurate software delays.
- **`HAL_PRINT.S`**: Formatted printing engine (Strings, Hex, Dec, Newline).
- **`HAL_RTC.S`**: Real-Time Counter (RTC) and Periodic Interrupt Timer (PIT) helpers with sync-safe operations.
- **`HAL_USART.S`**: High-level USART configuration and baud rate calculations.

### 📦 Data Structures & Math
- **`HAL_DEVICEBUFFER.S`**: High-performance Ring Buffer with device-address binding.
- **`HAL_DOUBLEBUFFER.S`**: High-speed Ping-Pong buffer descriptor and management.
- **`MATH_MUL.S`**: Optimized multiplication (8-bit, 16-bit).
- **`MATH_DIV.S`**: Fast integer division and modulo (8-bit, 16-bit, 32-bit).
- **`MATH_SHIFTS.S`**: Multi-byte logical and arithmetic shifts.

### 📟 Board Support (`Boards/`)
Configuration files for standard Curiosity Nano (CNANO) boards:
- `AVR16EB32_CNANO.S`
- `AVR128DB48_CNANO.S`
- `AVR64DU32_CNANO.S`

---

## 🧪 Demonstration Examples

Explore the `Examples/` directory for ready-to-flash implementations:

- **`Hello_world`**: The basics—LED toggling and formatted USART printing.
- **`Double_buffer`**: Zero-copy RX/TX echo using the Ping-Pong architecture.
- **`Ring_buffer`**: Asynchronous, buffered USART communication.
- **`Clock_scaling`**: Dynamic CPU frequency adjustment and peripheral recalibration.
- **`RTC`**: Timed events and periodic interrupts.
- **`Math_tests`**: Validation suite for the mathematical library.

---

## 🛠️ Getting Started

### Prerequisites
Ensure you have the AVR toolchain installed:
```bash
sudo apt install gcc-avr avrdude avr-libc
```

### Building and Flashing
Use the `curiosity.sh` automation script. It automatically detects the MCU from the board configuration and handles compilation, linking, and UPDI flashing.

```bash
./curiosity.sh <BOARD_NAME> <PROGRAM_FILE>
```

**Example:**
```bash
./curiosity.sh AVR16EB32_CNANO Examples/Double_buffer/main.S
```

### Fuse Management
Manage device configuration using `avr_fuses.sh`:
```bash
# Read all fuses
./avr_fuses.sh avr16eb32 read

# Write a specific fuse
./avr_fuses.sh avr16eb32 write fuse2 0x02
```

---

## 📜 HAL ABI (The Social Contract)

To ensure high performance and seamless integration, this framework follows a strict **Social Contract**. All functions (CALLEES) must preserve any registers they modify, except for those explicitly designated for return values.

| Register | Usage | Contract |
| :--- | :--- | :--- |
| **`r2`** | `__zero_reg__` | **Permanent Zero.** Initialized at startup. **Never** write to `r2`. |
| **`r0, r1`** | Scratch | Volatile. Used by `mul` instructions. Do not persist across calls. |
| **`r22-r25`** | Args/Return | Primary registers for 8, 16, and 32-bit arguments and results. |
| **`X (r27:r26)`** | Pointer | Primary for streaming (strings, arrays). Consumed if used as input. |
| **`Y (r29:r28)`** | Pointer | Primary for Device Addresses and Local variables (Stack Frame). |
| **`Z (r31:r30)`** | Pointer | Primary for Structures, Ring Buffers, and Double Buffers. |
| **`r3-r31`** | Callee-Saved | **Strictly preserved.** Any function using these must PUSH/POP them. |

### Namespace & Naming
- **Prefixes**: All HAL macros and functions use standard prefixes: `HAL_`, `MATH_`.
- **Atomicity**: Leverage modern AVR features like `_OUTTGL`, `_DIRSET`, and `_DIRCLR` for atomic I/O operations without disabling interrupts.

---

## 📖 Usage Example

```assembly
#include "Hal/ALL.S"

DEFUN main
  main:
    rcall   HAL_BOARD_SETUP       ; Board-specific I/O init
    sei                           ; Enable interrupts

  loop:
    ldi     r19, LED_PIN
    sts     _(LED_PORT, _OUTTGL), r19 ; Atomic pin toggle
    HAL_DELAY_MS 500              ; Frequency-aware delay
    
    PRINT_STR "Heartbeat...\r\n"
    rjmp    loop
ENDF main
```

---

## ⚖️ License

Distributed under the **GNU General Public License v3.0**. See `LICENSE` for details.

---

## ❤️ Credits
Developed for the modern AVR enthusiast. Capturing the power of the **AVR-Dx/Ex** series through the elegance of pure Assembly.
