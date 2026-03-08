; Description: Blinks the BOARD LED and send a STRING in UART at 1 Hz.
; Target: CURIOSITY NANO eval boards

HAL_BBUF_DEFINE HAL_UART_BUFFER_TX, 64
#include "toggle.S"

DEFUN main                        ; ✅ Main Program
  main:
    rcall HAL_BOARD_SETUP         ; BTN int fill fire on every click

    ldi   XL, lo8( HAL_UART_BUFFER_TX )
    ldi   XH, hi8( HAL_UART_BUFFER_TX )
    ldi   r18, HAL_UART_BUFFER_TX_SIZE
    rcall HAL_BBUF_INIT
    sei

  loop:
    rcall   my_toggle_function    ; Soft delay will call toggle every second
    rcall   HAL_BBUF_IS_EMPTY

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
