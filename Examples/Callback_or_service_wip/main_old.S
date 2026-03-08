; Description: Blinks the BOARD LED and send a STRING in UART at 1 Hz.
; Target: CURIOSITY NANO eval boards

HAL_BBUF_DEFINE HAL_UART_BUFFER_TX, 64
#define  CB_FLAGS    GPR_GPR0     /* 0: RTC-CB  */
#include "toggle.S"

DEFUN main                        ; ✅ Main Program
  main:
    rcall HAL_BOARD_SETUP
    rcall RTC_INIT_ONE_SECOND

    ldi   XL, lo8( HAL_UART_BUFFER_TX )
    ldi   XH, hi8( HAL_UART_BUFFER_TX )
    ldi   r18, 64
    rcall HAL_BBUF_INIT
    sei

  loop:
    rcall   my_toggle_function
    HAL_DELAY_MS 1000
    rjmp    loop                  ; goto loop

ENDF main

DEFUN RTC_CB_SEND_NINE
  RTC_CB_SEND_NINE:
  PUSH  r18
    sei
    ldi   r18, '9'
    rcall HAL_UART_Print_char
  POP r18
  ret
ENDF RTC_CB_SEND_NINE

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

    ; The idea of CALLBACK programming is being able to react as soon the interruption
    ;  is fired without blocking following interruptions, without waiting for the mainloop
    ;  to check if something was received
    ; So from within the ISR, call the callback just ONCE, and if while the callback is running another
    ;  interrupt is fired, no another callback should start until the previous had finished and consumed the data.
    sbic    CB_FLAGS, 0           ; if bit 0 in CB_FLAGS is clear
    rjmp    rtc_cnt_exit          ;   skip exit
    sbi     CB_FLAGS, 0           ;   and set bit 0 to 1
    rcall   RTC_CB_SEND_NINE      ;   call Callback function
    cbi     CB_FLAGS, 0           ; return from callback and clear bit 0
  rtc_cnt_exit:
  ISR_END r18
ENDF RTC_CNT_vect

