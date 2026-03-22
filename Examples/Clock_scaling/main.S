; File: Examples/Clock_scaling/main.S
; Description: Demonstrates dynamic CPU clock scaling and its effect on peripherals.
;              - Iterates through different CPU clock divisors (1, 2, 4, 8, 16, 32, 64).
;              - Updates the USART baud rate and delay constants dynamically.
;              - Toggles the LED and sends status via a 128-byte ring buffer.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR-Dx/Ex board.
;   Observe the USART output as the clock speed changes; the baud rate remains
;   consistent because it's recalculated after each clock change.

#define  TOGGLE_REG   r10
#include "toggle.S"

; 1. Define a 128-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_TX_DEVBUFFER, 128, USART0_ADDR

; Function: main
; Description: Main application entry point. Initializes hardware and loops through
;              clock prescaler settings.
; Inputs:  None
; Outputs: Never returns
FUNC main
    clr     TOGGLE_REG                  ; Initialize toggle state (0: Hello, 1: Hola)
    rcall   HAL_BOARD_SETUP             ; Basic board initialization
    HAL_DEVICEBUFFER_INIT USART0_TX_DEVBUFFER ; Initialize USART TX buffer
    sei                                 ; Enable global interrupts

    ; Clock Prescaler Indices (r18):
    ; 0: /1, 1: /2, 2: /4, 3: /8, 4: /16, 5: /32, 6: /64

    ldi     r18, 0                      ; Start with divisor index 0 (/1)
  loop:
    rcall   HAL_CORE_PRESCALER          ; Apply new clock divisor index (r18)
    rcall   HAL_USART_BAUDRATE_UPD      ; Recalculate USART baud for new frequency
    rcall   a_toggle_function           ; Print status and toggle LED
    rcall   HAL_USART_FLUSH_DEVICEBUFFER ; Send all pending data in buffer
    HAL_DELAY_MS 1000                   ; 1s delay (calibrated by HAL_CORE_PRESCALER)

    inc     r18                         ; Move to next divisor index
    cpi     r18, 7                      ; Check if we've passed index 6
    brlo    loop                        ; If < 7, continue
    ldi     r18, 0                      ; Otherwise, reset to 0
    rjmp    loop                        ; Repeat indefinitely
ENDF main

; ISR: PORT_vect (Button Interrupt)
; Description: Toggles the TOGGLE_REG state when the board button is pressed.
ISR_START _(BOARD_BUTTON_PORT,_PORT_vect) r18
    ldi     r18, 1                      ; Load toggle bit
    eor     TOGGLE_REG, r18             ; Flip bit 0 of state register

    ldi     r18, BOARD_BUTTON_PIN       ; Load button pin mask
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18 ; Clear interrupt flag
ISR_END _(BOARD_BUTTON_PORT,_PORT_vect) r18
