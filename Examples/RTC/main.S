; File: Examples/RTC/main.S
; Description: Demonstrates using the Real-Time Counter (RTC) for periodic events.
;              - Initializes the RTC to fire an interrupt every 3 seconds.
;              - Toggles the message state (HELLO/HOLA) via RTC interrupt or button.
;              - Toggles the board LED and sends the selected string every 1 second.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   The message "Hello World!" or "Hola Mundo!" will be sent every second.
;   Every 3 seconds, the RTC interrupt will swap the current message.
;   Pressing the board button will also swap the message.

#define  TOGGLE_REG   r10               // Register used to track message state
#include "toggle.S"

; Function: main
; Description: Application entry point. Initializes hardware, RTC, and USART,
;              then enters a periodic loop to send messages and toggle the LED.
; Inputs:  None
; Outputs: Never returns
FUNC main
    clr     TOGGLE_REG                  ; Initialize state register (0: Hello, 1: Hola)
    rcall   HAL_BOARD_SETUP             ; Basic board and USART initialization
    rcall   RTC_INIT_THREE_SECOND       ; Configure RTC for 3s periodic interrupt
    sei                                 ; Enable global interrupts

    ; Set Y to point to USART0 for HAL_USART_SEND_LENGTH (used in toggle.S)
    ldi     YL, lo8( USART0_ADDR )
    ldi     YH, hi8( USART0_ADDR )

  loop:
    rcall   a_toggle_function           ; Toggle LED and send string via USART
    HAL_DELAY_MS 1000                   ; Wait 1 second
    rjmp    loop                        ; Repeat indefinitely
ENDF main

; ISR: PORT_vect (Button Interrupt)
; Description: Toggles the message state when the board button is pressed.
ISR_START _(BOARD_BUTTON_PORT,_PORT_vect) r18
    ldi     r18, 1                      ; Load bit 0
    eor     TOGGLE_REG, r18             ; Flip state bit

    ldi     r18, BOARD_BUTTON_PIN       ; Load button pin mask
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18 ; Clear interrupt flag
ISR_END _(BOARD_BUTTON_PORT,_PORT_vect) r18

; ISR: RTC_CNT_vect (RTC Overflow Interrupt)
; Description: Toggles the message state every time the RTC period expires.
ISR_START RTC_CNT_vect r18
    ldi     r18, 1                      ; Load bit 0
    eor     TOGGLE_REG, r18             ; Flip state bit

    ldi     r18, RTC_OVF_bm             ; Load RTC overflow flag mask
    sts     RTC_INTFLAGS, r18           ; Clear RTC interrupt flag
ISR_END RTC_CNT_vect r18
