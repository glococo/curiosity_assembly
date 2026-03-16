; File: Examples/Clock_scaling/main.S
; Description: Demonstrates dynamic CPU clock scaling and its effect on peripherals.
;              - Iterates through different CPU clock divisors (1, 2, 4, 8, 16, 32, 64).
;              - Updates the USART baud rate and delay constants dynamically.
;              - Toggles the LED and sends status via a 64-byte ring buffer.
; Target: CURIOSITY NANO eval boards (e.g., AVR16EB32 Curiosity Nano)

HAL_BBUF_DEFINE   HAL_USART_BUFFER_TX, 128

#include "toggle.S"

DEFUN main                          ; ✅ Main Program
  main:
    clr     TOGGLE_REG              ; Initialize state register (default: Hello World)
    rcall   HAL_BOARD_SETUP         ; Hardware setup: Button int and USART config
    HAL_BBUF_INITIALIZE HAL_USART_BUFFER_TX ; Initialize the USART ring buffer
    sei                             ; Enable interrupts

    ; HAL_CORE_PRESCALER input (r18):
    ; 0: /1 (PEN=0, PDIV=0)
    ; 1: /2 (PEN=1, PDIV=0)
    ; 2: /4 (PEN=1, PDIV=1)
    ; 3: /8 (PEN=1, PDIV=2)
    ; 4: /16 (PEN=1, PDIV=3)
    ; 5: /32 (PEN=1, PDIV=4)
    ; 6: /64 (PEN=1, PDIV=5)

    ldi     r18, 0                  ; Start with no divisor (/1)
  loop:
    rcall   HAL_CORE_PRESCALER      ; Apply new clock divisor
    rcall   HAL_USART_BAUDRATE_UPD  ; Re-calculate baud rate based on new clock
    rcall   a_toggle_function       ; Push message and toggle LED
    rcall   HAL_USART_X_SEND        ; Drain the ring buffer
    HAL_DELAY_MS 1000               ; Delay 1 second (stays accurate due to HAL scaling)

    inc     r18                     ; Increment divisor index
    cpi     r18, 7                  ; Wrap around after index 6 (/64)
    brlo    loop
    ldi     r18, 0
    rjmp    loop

ENDF main

DEFUN _(BOARD_BUTTON_PORT,_PORT_vect)             ; ✅ Button Interrupt
  ISR_START r18

    ldi     r18, 1                                ; Toggle state bit in TOGGLE_REG
    eor     TOGGLE_REG, r18

    ldi     r18, BOARD_BUTTON_PIN                 ; Clear the button interrupt flag
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BOARD_BUTTON_PORT,_PORT_vect)
