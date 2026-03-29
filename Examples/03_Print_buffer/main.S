; -----------------------------------------------------------------------------
; File: Examples/03_Print_buffer/main.S
; Description: Example showing LED blinking and USART string transmission using a buffer.
;              - Toggles the BOARD LED and sends a string every 1 second.
;              - Uses a Button Interrupt to switch between "Hello World!" and "Hola Mundo!".
;              - Utilizes HAL_DEVICEBUFFER for buffered USART communication.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR-Dx/Ex board.
;   The LED will blink every second, and a greeting will be sent via USART.
;   Press the board button to switch the greeting message.
; -----------------------------------------------------------------------------

#define  TOGGLE_REG   r10
#include "toggle.S"

; 1. Define a 128-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  RX_DEVBUFFER, 128, USART_ADDR

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point. Initializes hardware, buffer,
;              and loops sending a greeting message every second.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC main
    clr     TOGGLE_REG                        ; Initialize state register (0: Hello, 1: Hola)
    rcall   HAL_BOARD_SETUP                   ; Basic board and USART initialization
    HAL_DEVICEBUFFER_INIT RX_DEVBUFFER        ; Initialize the USART ring buffer
    PRINT_STR "__ CURIOSITY ASSEMBLY __ \r\n"
    sei                                       ; Enable global interrupts

  loop:
    rcall   a_toggle_function                 ; Select string, send to buffer, toggle LED
    rcall   HAL_USART_FLUSH_DEVICEBUFFER      ; Drain buffer to USART hardware

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
