---
name: add-board
description: >-
  Create and configure a new Curiosity Nano target board definition file.
---

# Adding a New Target Board

Use this skill when adding support for a new Curiosity Nano target or custom AVR board.

## Procedure

1. **Copy the Template**:
   ```bash
   cp boards/_template.S boards/<NEW_BOARD_NAME>.S
   ```

2. **Configure Core Header**:
   Ensure the first line declares the MCU exact name for the toolchain:
   ```assembly
   ; Core: <mcu_name>  (e.g., ; Core: avr128db48)
   ```

3. **Define Clock & Peripheral Pins**:
   Define clock frequencies, LED/button pins, and alternate pin multiplexing (`PORTMUX`):
   ```assembly
   #define CORE_CLOCK_OSCHF      24000
   #define BOARD_LED_PIN         PIN5_bp
   #define BOARD_LED_PORT        PORTF
   #define USART_PORT            PORTC
   #define USART_TX              PIN1_bp
   #define USART_RX              PIN2_bp
   #define USART_ALT             ALT4
   ```

4. **Implement `HAL_BOARD_SETUP`**:
   Initialize registers, clock awareness, and peripheral routing:
   ```assembly
   FUNC HAL_BOARD_SETUP
       _REGS_INIT()
       _CLOCK_AWARENESS_INIT()
       _USART_CONFIG()
       _PIN_DIR_SET(BOARD_LED_PORT, BOARD_LED_PIN)
   ENDF HAL_BOARD_SETUP
   ```

5. **Verify with Blink Example**:
   ```bash
   ./curiosity.sh <NEW_BOARD_NAME> examples/01_blink_led/main.S
   ```
