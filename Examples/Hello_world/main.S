; Description: Blinks the BOARD LED and send a STRING in UART at 1 Hz, while scaling CPU divisor factor /1, /2 .. /64.
; Target: CURIOSITY NANO eval boards
; #include "../../Boards/AVR16EB32_Curiosity_Nano.S"
#include "../../Boards/AVR128DB48_Curiosity_Nano.S"

#define  REG_HELLO_OR_HOLA  r10
#include "toggle.S"

DEFUN main                    ; ✅ Main Program
  main:
    rcall BOARD_SETUP_DEFAULT
    sei

    ; r18 receive divisior, ej: 0=Clk/1 (PEN=0, PDIV=0), 1=Clk/2 (PEN=1, PDIV=0),
    ;  1=Clk/4 (PEN=1, PDIV=1), 2=Clk/8 (PEN=1, PDIV=2), 3= Clk/16 ... max=6= /64

    ldi     r18, 0
  loop:
    rcall   HAL_CORE_PRESCALER
    rcall   HAL_USART_UPDATE_BAUDRATE
    rcall   my_toggle_function
    OS_DELAY_MS 1000
    lds     r18, CORE_DIVISOR
    inc     r18                 ; Increment divisor r18
    cpi     r18, 7              ; Compare with 7 (6 max, 7=wrong value)
    brlo    loop                ; Continue with loop while r18<7
    ldi     r18, 0              ; if r18 >= 7, r18=0
    rjmp    loop                ; goto loop

ENDF main

DEFUN _(BUTTON_PORT,_PORT_vect)         ; ✅ Button Interrupt
  _(BUTTON_PORT,_PORT_vect):            ; PUSH_BUTTON toggle LED and UART message
  ISR_START r18

    ldi     r18, 1
    eor     REG_HELLO_OR_HOLA, r18
    ldi     r18, BUTTON_PIN
    sts     _(BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BUTTON_PORT,_PORT_vect)
