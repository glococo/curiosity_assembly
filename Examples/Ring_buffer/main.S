; File: Examples/Ring_buffer/main.S
; Description: Example of using a High-Performance Byte Ring Buffer for USART transmission.
;              - Initializes a 64-byte ring buffer (HAL_USART_BUFFER_TX).
;              - Toggles the BOARD LED and sends a string every 1 second.
;              - Uses a Button Interrupt to toggle between two message states.
; Target: CURIOSITY NANO eval boards (e.g., AVR16EB32 Curiosity Nano)

HAL_BBUF_DEFINE   HAL_USART_BUFFER_TX, 64

#include "toggle.S"

DEFUN main                        ; ✅ Main Program
  main:
    clr     TOGGLE_REG            ; Initialize state register (default: Hello World)
    rcall   HAL_BOARD_SETUP       ; Hardware setup: Button int and USART config
    HAL_BBUF_INITIALIZE HAL_USART_BUFFER_TX ; Initialize the USART ring buffer
    sei                           ; Enable interrupts

  loop:
    rcall   a_toggle_function     ; Push message to buffer and toggle LED
    rcall   HAL_USART_X_SEND      ; Drain the USART ring buffer until empty
    HAL_DELAY_MS 1000             ; Delay for 1 second
    rjmp    loop                  ; Repeat indefinitely

ENDF main


DEFUN _(BOARD_BUTTON_PORT,_PORT_vect)   ; ✅ Button Interrupt
  _(BOARD_BUTTON_PORT,_PORT_vect):      ; Toggles the message state for the next cycle
  ISR_START r18

    ldi     r18, 1                ; Toggle state bit in TOGGLE_REG
    eor     TOGGLE_REG, r18

    ldi     r18, BOARD_BUTTON_PIN       ; Clear the button interrupt flag
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BOARD_BUTTON_PORT,_PORT_vect)
