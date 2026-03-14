; File: Examples/Hello_world/main.S
; Description: Basic example showing LED blinking and USART string transmission.
;              - Toggles the BOARD LED and sends a string every 1 second.
;              - Uses a Button Interrupt to switch between "Hello World!" and "Hola Mundo!".
; Target: CURIOSITY NANO eval boards (e.g., AVR16EB32 Curiosity Nano)

#include "toggle.S"

DEFUN main                        ; ✅ Main Program
  main:
    clr     TOGGLE_REG            ; Initialize state register (default: Hello World)
    rcall   HAL_BOARD_SETUP       ; Hardware setup: Button int and USART config
    sei                           ; Enable interrupts

  loop:
    rcall   a_toggle_function     ; Send current string and toggle LED
    HAL_DELAY_MS 1000             ; Delay for 1 second
    rjmp    loop                  ; Repeat indefinitely

ENDF main

DEFUN _(BOARD_BUTTON_PORT,_PORT_vect)           ; ✅ Button Interrupt
  _(BOARD_BUTTON_PORT,_PORT_vect):              ; Toggles the message state on every press
  ISR_START r18

    ldi     r18, 1                              ; Toggle state bit in TOGGLE_REG
    eor     TOGGLE_REG, r18

    ldi     r18, BOARD_BUTTON_PIN               ; Clear the button interrupt flag
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BOARD_BUTTON_PORT,_PORT_vect)
