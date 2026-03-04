; Description: Blinks the BOARD LED and send a STRING in UART at 1 Hz.
; Target: CURIOSITY NANO eval boards

#include "toggle.S"

DEFUN main                        ; ✅ Main Program
  main:
    rcall HAL_BOARD_SETUP
    sei

  loop:
    rcall   my_toggle_function
    HAL_DELAY_MS 1000
    rjmp    loop                  ; goto loop

ENDF main

DEFUN _(BUTTON_PORT,_PORT_vect)   ; ✅ Button Interrupt
  _(BUTTON_PORT,_PORT_vect):      ; PUSH_BUTTON toggle LED and UART message
  ISR_START r18

    ldi     r18, 1
    eor     TOGGLE_REG, r18
    ldi     r18, BUTTON_PIN
    sts     _(BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BUTTON_PORT,_PORT_vect)
