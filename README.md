# AVR Assembly HAL Framework

A professional-grade, lightweight **Hardware Abstraction Layer (HAL)** and **Mathematical Library** for modern AVR microcontrollers (AVR-Dx and AVR-Ex series). Built entirely in optimized assembly, this framework provides a high-performance foundation for mission-critical embedded applications.

![Curiosity Assembly](notes/curiosity_assembly.jpg)

---

## Key Features

- **🎯 Zero-Overhead Abstraction**: Clean, linkable function definitions using `FUNC` and `ENDF` macros.
- **🕒 Clock-Aware Timing**: Automatic frequency adjustment for cycle-accurate delays and peripheral baud rates.
- **🧮 High-Performance Math**: Optimized 16-bit, 32-bit, and 64-bit routines for multiplication, division, and multi-byte shifts.
- **📊 Efficient Data Structures**: 
  - **Power-of-Two Ring Buffers**: Ultra-fast bitwise wrapping for low-latency I/O.
  - **Zero-Copy Double-Buffering**: Ping-pong architecture for high-speed peripheral data transfer.
- **📠 Professional Printing**: Robust string and numeric formatting (UINT8, UINT16, UINT32, UINT64) for diagnostic output.
- **⚡ Modern AVR Support**: Tailored for the latest AVR architectures (AVR-Dx, AVR-Ex) with UPDI programming and Unified Memory Map.

---

## 📂 Project Structure

### 🛠️ Core HAL (`Hal/`)
- **`ALL.S`**: Master include file—your one-stop shop for the entire framework.
- **`HAL_MACRO.S`**: Essential primitives for function definitions (`FUNC`/`ENDF`), ISR management, and atomic register access.
- **`HAL_CLKCTRL.S`**: Full Clock Control (CLKCTRL) driver—source selection, OSCHF frequency, prescaling, and PLL configuration.
- **`HAL_DELAY.S`**: Frequency-aware, cycle-accurate software delays.
- **`HAL_PRINT.S`**: Formatted printing engine (Strings, Hex, Dec, Newline).
- **`HAL_RTC.S`**: Real-Time Counter (RTC) and Periodic Interrupt Timer (PIT) helpers with sync-safe operations.
- **`HAL_USART.S`**: High-level USART configuration and dynamic baud rate calculations.
- **`HAL_ADC.S`**: 10/12-bit ADC driver with polling and interrupt-driven modes.
- **`HAL_BOD.S`**: Brown-out Detector and Voltage Level Monitor (VLM) configuration.
- **`HAL_WDT.S`**: Watchdog Timer management—period selection and reset routines.

### 📦 Data Structures & Math
- **`HAL_DEVICEBUFFER.S`**: High-performance Ring Buffer with device-address binding.
- **`HAL_DOUBLEBUFFER.S`**: High-speed Ping-Pong buffer descriptor and management.
- **`MATH_MUL.S`**: Optimized multiplication (8, 16, 32, 64-bit).
- **`MATH_DIV.S`**: Fast integer division and modulo (8, 16, 32-bit).
- **`MATH_SHIFTS.S`**: Multi-byte logical and arithmetic shifts.

### 📟 Board Support (`Boards/`)
Configuration files for standard Curiosity Nano (CNANO) boards:
- `AVR16EB32_CNANO.S`
- `AVR128DB48_CNANO.S`
- `AVR64DU32_CNANO.S`

---

## 🧪 Demonstration Examples

Explore the `Examples/` directory for ready-to-flash implementations:

- **`01_blink_led`**: The absolute basics—toggling the board LED.
- **`02_Hello_world`**: LED toggling and formatted USART printing with button interrupts.
- **`03_Print_buffer`**: Buffered USART communication using device ring buffers.
- **`04_Loopback`**: Asynchronous USART loopback implementation.
- **`05_Double_Buffered`**: High-speed zero-copy RX/TX echo using double-buffering.
- **`06_Math_lib`**: Comprehensive validation suite for the mathematical library.
- **`07_RTC`**: Periodic events and timed interrupts using RTC and PIT.
- **`10_Clock_PLL`**: Advanced clock configuration using the Phase-Locked Loop (PLL).
- **`11_Clock_scaling`**: Dynamic CPU frequency adjustment and peripheral re-calibration.
- **`12_Watchdog_timer`**: System safety and recovery—enabling the WDT and handling periodic resets.
- **`13_Brownout_detector`**: Power monitoring—configuring BOD and VLM for reliable low-voltage operation.
- **`14_Analog_Digital_Converter`**: Sensor integration—reading analog signals from AIN0 with configurable references.

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
./curiosity.sh AVR16EB32_CNANO Examples/05_Double_Buffered/main.S
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
- **Atomicity**: Leverage modern AVR features like `_OUTTGL`, `_DIRSET`, and `_DIRCLR` for atomic I/O operations.

---

## 📖 Usage Example

```assembly
; -----------------------------------------------------------------------------
; Function: main
; Description: Example entry point. Toggles LED and prints heartbeat message.
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                   ; Board-specific I/O init
    sei                                       ; Enable global interrupts

  loop:
    ldi     r19, BOARD_LED_PIN                ; Load LED pin
    sts     _(BOARD_LED_PORT, _OUTTGL), r19   ; Atomic pin toggle
    HAL_DELAY_MS 500                          ; Frequency-aware delay
    
    PRINT_STR "Heartbeat...\r\n"
    rjmp    loop
ENDF main
```

---

## ⚖️ License

Distributed under the **GNU General Public License v3.0**. See `LICENSE` for details.

---

## ❤️ Credits
AVR was the family that started it all for me. Returning to it after years of development on other platforms has been a total joy.

The modern AVR-Dx and AVR-Ex series introduce a powerhouse of features: a Unified Memory Map, UPDI, the Event System (EVSYS), and Configurable Custom Logic (CCL). Combined with Multi-Voltage I/O (MVIO), Atomic Port manipulation, crystal-less USB, and revamped peripherals (USART, ADC, and Timers), this architecture is a massive leap forward.

This project was born from a desire to create a high-performance Assembly boilerplate that leverages these modern features while capturing the elegant simplicity of writing in Assembly.

Developed for the modern AVR enthusiast.
