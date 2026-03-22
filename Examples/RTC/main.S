; File: Examples/RTC/main.S
; Description: Example of using the Real-Time Counter (RTC) to trigger an event.
;              - Initializes the RTC to fire an interrupt every 3 seconds.
;              - Toggles the message state (HELLO/HOLA) via RTC interrupt or Button.
;              - Toggles the BOARD LED and sends the selected string every 1 second.
; Target: CURIOSITY NANO eval boards (e.g., AVR16EB32 Curiosity Nano)

#include "toggle.S"

FUNC main                        ; ✅ Main Program
    clr     TOGGLE_REG            ; Initialize state register (default: Hello World)
    rcall   HAL_BOARD_SETUP       ; Hardware setup: Button int and USART config
    rcall   RTC_INIT_THREE_SECOND ; Configure RTC to trigger every 3 seconds
    sei                           ; Enable interrupts

  loop:
    rcall   a_toggle_function     ; Toggle LED and send current string to USART
    HAL_DELAY_MS 1000             ; Delay for 1 second
    rjmp    loop                  ; Repeat indefinitely

ENDF main


FUNC _(BOARD_BUTTON_PORT,_PORT_vect)   ; ✅ Button Interrupt
  ISR_START r18

    ldi     r18, 1                ; Toggle state bit in TOGGLE_REG
    eor     TOGGLE_REG, r18

    ldi     r18, BOARD_BUTTON_PIN       ; Clear the button interrupt flag
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18

  ISR_END r18
ENDF _(BOARD_BUTTON_PORT,_PORT_vect)


FUNC RTC_CNT_vect                ; ✅ RTC Overflow Interrupt
  ISR_START r18

    ldi     r18, 1                ; Toggle state bit in TOGGLE_REG
    eor     TOGGLE_REG, r18

    ldi     r18, RTC_OVF_bm       ; Clear the RTC Overflow interrupt flag
    sts     RTC_INTFLAGS, r18

  ISR_END r18
ENDF RTC_CNT_vect

