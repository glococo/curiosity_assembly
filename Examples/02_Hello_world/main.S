; -----------------------------------------------------------------------------
; File: Examples/02_Hello_world/main.S
; Description: Basic example showing LED blinking and USART string transmission.
;              - Toggles the BOARD LED and sends a string every 1 second.
;              - Uses a Button Interrupt to switch between "Hello World!" and "Hola Mundo!".
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR-Dx/Ex board.
;   The LED will blink every second, and "Hello World!" will be sent via USART.
;   Press the board button to switch the greeting message.
; -----------------------------------------------------------------------------

#define  TOGGLE_REG   r10
#include "toggle.S"

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point. Initializes hardware and loops
;              sending a greeting message every second.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC main
    clr     TOGGLE_REG                        ; Initialize state register (0: Hello, 1: Hola)
    rcall   HAL_BOARD_SETUP                   ; Basic board and USART initialization
    sei                                       ; Enable global interrupts

    ldiw    YL, USART_ADDR                    ; Set once Y-pointer to USART0 for HAL_USART_SEND_LENGTH

  loop:
    rcall   a_toggle_function                 ; Select string, send to buffer, toggle LED

    HAL_DELAY_MS 1000                         ; Wait 1 second
    rjmp    loop                              ; Repeat indefinitely

ENDF main

; -----------------------------------------------------------------------------
; ISR: PORT_vect (Button Interrupt)
; Description: Toggles the greeting state (TOGGLE_REG) when the button is pressed.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START _(BOARD_BUTTON_PORT,_PORT_vect), r18
    ldi     r18, 1                            ; Load bit 0
    eor     TOGGLE_REG, r18                   ; Flip bit 0 of state register

    cbi     _(BOARD_BUTTON_VPORT,_INTFLAGS), BOARD_BUTTON_PIN ; Clear the interrupt flag

ISR_END _(BOARD_BUTTON_PORT,_PORT_vect), r18
