; Description: Blinks the BOARD LED and send a STRING in UART at 1 Hz.
; Target: CURIOSITY NANO eval boards

#include "toggle.S"

DEFUN main                        ; ✅ Main Program
  main:
    rcall HAL_BOARD_SETUP         ; BTN int fill fire on every click
    rcall RTC_INIT_THREE_SECOND   ; RTC int fill fire every 3 seconds
    sei

  loop:
    rcall   my_toggle_function    ; Soft delay will call toggle every second
    HAL_DELAY_MS 1000
    rjmp    loop                  ; goto loop

ENDF main

DEFUN _(BUTTON_PORT,_PORT_vect)   ; ✅ Button Interrupt
  _(BUTTON_PORT,_PORT_vect):      ; PUSH_BUTTON toggle LED and UART message
  ISR_START r18

    ldi     r18, 1                ; Toggle REG
    eor     TOGGLE_REG, r18

    ldi     r18, BUTTON_PIN       ; Clear Button Int Flag
    sts     _(BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BUTTON_PORT,_PORT_vect)


DEFUN RTC_CNT_vect                ; ✅ RTC Interrupt
  RTC_CNT_vect:
  ISR_START r18
    ldi     r18, 1                ; Toggle REG
    eor     TOGGLE_REG, r18

    ldi     r18, RTC_OVF_bm       ; Clear RTC Int flag
    sts     RTC_INTFLAGS, r18
  ISR_END r18
ENDF RTC_CNT_vect

