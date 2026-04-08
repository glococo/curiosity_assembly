# AVR Assembly HAL Framework

A professional-grade, lightweight **Hardware Abstraction Layer (HAL)** and **Mathematical Library** for modern AVR microcontrollers (AVR-Dx and AVR-Ex series). Built entirely in optimized assembly, this framework provides a high-performance foundation for mission-critical embedded applications.

![Curiosity Assembly](notes/curiosity_assembly.jpg)

---

## Key Features

- **🎯 Zero-Overhead Abstraction**: Clean, linkable function definitions using `FUNC` and `ENDF` macros.
- **🕒 Clock-Aware Timing**: Automatic frequency adjustment for cycle-accurate delays and peripheral baud rates.
- **🧮 High-Performance Math**: Optimized 16-bit, 32-bit, and 64-bit routines for multiplication, division, and multi-byte shifts.
- **🚀 Extended ISA**: Rich set of macros for 16, 32, and 64-bit operations (`ldi2/4/8`, `add2/4`, `cp2/4`, etc.) on an 8-bit core.
- **📊 Efficient Data Structures**: 
  - **Power-of-Two Ring Buffers**: Ultra-fast bitwise wrapping for low-latency I/O.
  - **Zero-Copy Double-Buffering**: Ping-pong architecture for high-speed peripheral data transfer.
- **📠 Professional Printing**: Robust string and numeric formatting (UINT8, UINT16, UINT32, UINT64) for diagnostic output.
- **⚡ Modern AVR Support**: Unified Memory Mapping for strings, UPDI programming, and atomic hardware registers.

---

## 📂 Project Structure

### 🛠️ Core HAL (`Hal/`)
- **`ALL.S`**: Master include file—your one-stop shop for the entire framework.
- **`HAL_MACRO.S`**: Essential primitives for function definitions (`FUNC`/`ENDF`), ISR management, and the `ASCIZ` string macro.
- **`HAL_EXTEND.S`**: 16, 32, and 64-bit instruction extensions (Load, Store, Add, Compare, Shift).
- **`HAL_CLKCTRL.S`**: Full Clock Control (CLKCTRL) driver—source selection, OSCHF frequency, prescaling, and PLL configuration.
- **`HAL_DELAY.S`**: Frequency-aware, cycle-accurate software delays.
- **`HAL_PRINT.S`**: Formatted printing engine (Strings, Hex, Dec, Newline).
- **`HAL_PORT.S`**: Atomic Port-Pin helper utilizing Virtual Ports (VPORT) for single-cycle access.
- **`HAL_RTC.S`**: Real-Time Counter (RTC) and Periodic Interrupt Timer (PIT) helpers.
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

- **`01_blink_led`**: The absolute basics—toggling the board LED using atomic registers.
- **`02_Hello_world`**: LED toggling and formatted USART printing with button interrupts.
- **`03_Print_buffer`**: Buffered USART communication using device ring buffers.
- **`04_Loopback`**: Simple asynchronous USART loopback implementation.
- **`05_Double_Buffered`**: High-speed zero-copy RX/TX echo using the ping-pong double-buffer.
- **`06_Math_lib`**: Comprehensive validation suite for the 16, 32, and 64-bit mathematical library.
- **`07_RTC`**: Periodic events and timed interrupts using the Real-Time Counter (RTC) and PIT.
- **`08_Device_ID`**: Reading and printing the unique Device ID, Serial Number, and Calibration rows from SIGROW.
- **`09_Debug`**: Demonstrates the `_DEBUG` macro suite for quick register and memory inspection.
- **`10_Clock_PLL`**: Advanced clock configuration using the Phase-Locked Loop (PLL) for high-frequency operation.
- **`11_Clock_scaling`**: Dynamic CPU frequency adjustment and automatic peripheral re-calibration.
- **`12_Watchdog_timer`**: System safety—enabling the WDT and handling periodic resets to prevent hangs.
- **`13_Brownout_detector`**: Power monitoring—configuring BOD and VLM for reliable low-voltage operation.
- **`14_Analog_Digital_Converter`**: Basic ADC integration—reading analog signals from AIN0 with configurable references.
- **`15_ADC_temperature`**: Reading the internal silicon temperature sensor using the ADC.
- **`16_ADC_Burst`**: High-accuracy ADC sampling using Burst mode and accumulation (64x hardware averaging).
- **`17_I2C_Scanner`**: Scans the I2C bus for connected devices and reports their 7-bit addresses.
- **`18_I2C_UV_sensor`**: Advanced I2C example reading UV index data from a VEML6075 sensor.
- **`19_I2C_Temperature_sensor`**: Reading high-precision temperature data from an MCP9804 sensor via I2C.
- **`20_ADC_MCP9700B`**: Interfacing with an MCP9700B analog temperature sensor and performing fixed-point math.

---

## 🛠️ Getting Started

### Prerequisites
Ensure you have the AVR toolchain installed:
```bash
sudo apt install gcc-avr avrdude avr-libc
```

### Building and Flashing
Use the `curiosity.sh` automation script. It handles MCU detection, compilation, and UPDI flashing via Curiosity Nano boards.

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
| **`r2`** | `__zero_reg__` | **Permanent Zero.** Never write to `r2`. |
| **`r0, r1`** | Volatile | Scratch registers. Modified by `mul`. |
| **`r18-r25`** | Volatile | Arguments (`r25:r22`) and Return values. |
| **`X (r27:r26)`** | Volatile | Primary for **Streaming** (strings, arrays). |
| **`Y (r29:r28)`** | Callee-Saved | Primary for **Peripheral Base Addresses**. |
| **`Z (r31:r30)`** | Volatile | Primary for **Structures** and **Program Memory**. |
| **`r3-r17`** | Callee-Saved | Strictly preserved via PUSH/POP. |

**Success Signaling**: Functions typically use the **Carry Flag** (Set = Success/True, Clear = Failure/Empty).

## 📖 Usage Example

```assembly
; -----------------------------------------------------------------------------
; Function: main
; Description: Example entry point. Toggles LED and prints heartbeat message.
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                   ; Board-specific I/O init
    _DEVBUFFER(RX_DEVBUFFER, 128, USART_ADDR) ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")$ _STR_FLUSH()
  
  loop:
    _PORT_TGL(BOARD_LED_PORT, BOARD_LED_PIN)      ; Toggle LED via hardware register
    _DELAY_MS(500)                                ; Frequency-aware delay  
    _STR("Heartbeat...\r\n")$ _STR_FLUSH()
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
