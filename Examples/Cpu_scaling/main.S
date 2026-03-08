; Description: Blinks the BOARD LED and send a STRING in UART at 1 Hz, while scaling CPU divisor factor /1, /2 .. /64.
; Target: CURIOSITY NANO eval boards

#include "toggle.S"

DEFUN main                    ; ✅ Main Program
  main:
    rcall HAL_BOARD_SETUP
    sei

    ; r18 receive divisior, ej: 0=Clk/1 (PEN=0, PDIV=0), 1=Clk/2 (PEN=1, PDIV=0),
    ;  1=Clk/4 (PEN=1, PDIV=1), 2=Clk/8 (PEN=1, PDIV=2), 3= Clk/16 ... max=6= /64

    ldi     r18, 0
  loop:
    rcall   HAL_CORE_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD
    rcall   my_toggle_function
    HAL_DELAY_MS 1000
    inc     r18                     ; r18++
    cpi     r18, 7                  ; Compare r18 to 7
    brlo    loop                    ; r18 < 7 -> goto loop
    ldi     r18, 0                  ; r18 = 0
    rjmp    loop                    ; goto loop

ENDF main

DEFUN _(BUTTON_PORT,_PORT_vect)         ; ✅ Button Interrupt
  _(BUTTON_PORT,_PORT_vect):            ; PUSH_BUTTON toggle LED and UART message
  ISR_START r18

    ldi     r18, 1
    eor     TOGGLE_REG, r18
    ldi     r18, BUTTON_PIN
    sts     _(BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BUTTON_PORT,_PORT_vect)
