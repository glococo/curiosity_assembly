# AVR Assembly HAL Framework & Mathematical Library

> Architectural overview, developer guidelines, and agent instructions for the AVR Assembly HAL codebase.

---

## 1. Project Overview

High-performance, modular **Hardware Abstraction Layer (HAL)** and **Mathematical Library** written in optimized AVR GNU Assembly (`avr-as` / `avr-gcc`) targeting modern AVR microcontrollers (AVR-Dx, AVR-Ex, AVR-DU, AVR-EB, AVR-SD, and ATtiny 0/1/2 series).

### Core Highlights
- **Zero-Overhead Abstraction**: Modular functions wrapped in `FUNC` / `ENDF` macros with subsection placement (`.text.<name>`) allowing linker garbage collection (`--gc-sections`).
- **Unified Memory Map**: Flash constants mapped into SRAM space (`MAPPED_PROGMEM_START`), accessed directly via `ld` instead of `lpm`.
- **Extended ISA Macros**: Multi-byte primitives (`ldi2/4/8`, `lds2/4`, `sts2/4`, `add2/4`, `cp2/4`, `lsli2/4`) for 8-bit cores.
- **Tiered Peripheral Architecture**: Distinguishes streaming (buffered), control (handle-based), and static system peripherals.
- **Clock Awareness Engine**: Runtime / compile-time frequency calculation ensuring cycle-accurate delays and baud rates.

---

## 2. Directory Layout & Architecture

```
avr_dev/
├── boards/                  # Curiosity Nano board target definitions
│   ├── avr16eb32_cnano.S
│   ├── avr128da48_cnano.S
│   ├── avr64du32_cnano.S
│   └── _template.S
├── drivers/                 # External sensor & chip drivers
│   ├── lan9252/             # SPI EtherCAT slave controller
│   ├── mcp9700b/            # Analog temperature sensor
│   ├── mcp9804/             # I2C temperature sensor
│   ├── sinewave/            # DAC quarter-wave sine LUT generator
│   ├── usb_keyboard/        # USB HID keyboard helpers
│   └── veml6075/            # I2C UV light sensor
├── examples/                # 29 standalone, ready-to-flash sample applications
│   ├── 01_blink_led/
│   ├── 06_math_lib/
│   ├── 26_usb_hid/
│   └── 29_my_c_code/
├── hal/                     # Modular HAL Framework
│   ├── all.S                # Master umbrella include
│   ├── core/                # Core primitives, ISA extensions, buffers & printing
│   │   ├── macro.S          # FUNC/ENDF, ASCIZ, register defines
│   │   ├── extend.S         # 16/32/64-bit multi-byte operations
│   │   ├── delay.S          # Frequency-aware cycle delay routines
│   │   ├── devicebuffer.S   # Circular ring buffer
│   │   ├── doublebuffer.S   # High-speed ping-pong buffer
│   │   └── print*.S         # Formatted numeric and string printing
│   ├── dev/                 # On-chip peripheral drivers
│   │   ├── usart.S, twi.S, spi.S, adc_v1.S, adc_v2.S
│   │   ├── tca.S, tce.S, rtc.S, wdt.S, bod.S, dac.S, ac.S
│   │   ├── clkctrl.S, pin.S, portmux.S, vref.S, slpctrl.S, errctrl.S
│   │   └── usb.S, usb_ep0.S, usb_def.S, usb_hid_def.S, usb_struct.S
│   ├── math/                # Optimized math routines (mul.S, div.S, shifts.S, cast.S)
│   └── def/                 # Target register map defines & generator script
├── notes/                   # Architecture specs, buffer documentation, and conventions
└── .agents/                 # Rules and on-demand skills for agents & developers
```

---

## 3. Rules & Guidelines (`.agents/rules/`)

- **[01. Register Social Contract](file:///home/laboratory/mcu/avr_dev/.agents/rules/01_social_contract.md)**: Preservation rules (`r2` = 0x00 zero, `r3` = 0xFF full; callee-saved registers `r4-r15`, `r18-r21`, `X`, `Y`, `Z`), volatile registers (`r0-r1`, `r16-r17`, `r22-r25`), and peripheral tiers.
- **[02. Assembly Code Style](file:///home/laboratory/mcu/avr_dev/.agents/rules/02_code_style.md)**: Function/ISR macro wrappers (`FUNC`/`ENDF`, `ISR_START`/`ISR_END`), numeric local labels (`0f`/`1b`), `ASCIZ` string definitions, and extended ISA macros.
- **[03. Git & Contributions](file:///home/laboratory/mcu/avr_dev/.agents/rules/03_git_workflow.md)**: Conventional commit conventions, branch policies, and artifact hygiene.

---

## 4. Skills & Runbooks (`.agents/skills/`)

- **[Build, Flash & Debug](file:///home/laboratory/mcu/avr_dev/.agents/skills/build-and-flash/SKILL.md)**: Toolchain commands, flashing via [`curiosity.sh`](file:///home/laboratory/mcu/avr_dev/curiosity.sh), UPDI fuse management with [`avr_fuses.sh`](file:///home/laboratory/mcu/avr_dev/avr_fuses.sh), and VTarget configuration with [`avr_vtarget.sh`](file:///home/laboratory/mcu/avr_dev/avr_vtarget.sh).
- **[Math Verification](file:///home/laboratory/mcu/avr_dev/.agents/skills/math-verification/SKILL.md)**: Automated validation and test vector execution for 16/32/64-bit routines using [`examples/06_math_lib`](file:///home/laboratory/mcu/avr_dev/examples/06_math_lib).
- **[Adding a Target Board](file:///home/laboratory/mcu/avr_dev/.agents/skills/add-board/SKILL.md)**: Procedure for creating new board definitions from [`boards/_template.S`](file:///home/laboratory/mcu/avr_dev/boards/_template.S).

---

## 5. Development Quickstart

```bash
# Prerequisites
sudo apt install gcc-avr avr-libc avrdude

# Build and flash an example
./curiosity.sh avr16eb32_cnano examples/01_blink_led/main.S

# Inspect disassembly output
./curiosity.sh -debug avr64du32_cnano examples/26_usb_hid/main.S

# Inspect target fuses
./avr_fuses.sh avr16eb32 read
```
