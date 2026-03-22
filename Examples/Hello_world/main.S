; File: Examples/Hello_world/main.S
; Description: Basic example showing LED blinking and USART string transmission.
;              - Toggles the BOARD LED and sends a string every 1 second.
;              - Uses a Button Interrupt to switch between "Hello World!" and "Hola Mundo!".
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR-Dx/Ex board.
;   The LED will blink every second, and "Hello World!" will be sent via USART.
;   Press the board button to switch the greeting message.

#define  TOGGLE_REG   r10
#include "toggle.S"

; 1. Define a 128-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_RX_DEVBUFFER, 128, USART0_ADDR

; Function: main
; Description: Main application entry point. Initializes hardware and loops
;              sending a greeting message every second.
; Inputs:  None
; Outputs: Never returns
FUNC main
    clr     TOGGLE_REG                  ; Initialize state register (0: Hello, 1: Hola)
    rcall   HAL_BOARD_SETUP             ; Basic board and USART initialization
    HAL_DEVICEBUFFER_INIT USART0_RX_DEVBUFFER ; Initialize the USART ring buffer
    sei                                 ; Enable global interrupts

  loop:
    rcall   a_toggle_function           ; Select string, send to buffer, toggle LED
    rcall   HAL_USART_FLUSH_DEVICEBUFFER ; Drain buffer to USART hardware

    HAL_DELAY_MS 1000                   ; Wait 1 second
    rjmp    loop                        ; Repeat indefinitely
ENDF main

; ISR: PORT_vect (Button Interrupt)
; Description: Toggles the greeting state (TOGGLE_REG) when the button is pressed.
ISR_START _(BOARD_BUTTON_PORT,_PORT_vect), r18
    ldi     r18, 1                      ; Load bit 0
    eor     TOGGLE_REG, r18             ; Flip bit 0 of state register

    ldi     r18, BOARD_BUTTON_PIN       ; Load button pin mask
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18 ; Clear the interrupt flag
ISR_END _(BOARD_BUTTON_PORT,_PORT_vect), r18
