; File: Examples/Ring_buffer/main.S
; Description: Demonstrates the use of a high-performance byte ring buffer for USART.
;              - Initializes a 64-byte ring buffer.
;              - Periodically pushes messages into the buffer and toggles the board LED.
;              - Uses a button interrupt to switch between message strings.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Connect via USART. The LED will blink every second, and a message will be sent.
;   Press the board button to toggle between "Hello World!" and "Hola Mundo!".

#define  TOGGLE_REG   r10
#include "toggle.S"

; 1. Define a 64-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_RX_DEVBUFFER, 64, USART0_ADDR

; Function: main
; Description: Application entry point. Initializes hardware, the ring buffer,
;              and enters a periodic loop to send messages.
; Inputs:  None
; Outputs: Never returns
FUNC main
    clr     TOGGLE_REG                  ; Initialize state register (0: Hello, 1: Hola)
    rcall   HAL_BOARD_SETUP             ; Basic board and USART initialization
    HAL_DEVICEBUFFER_INIT USART0_RX_DEVBUFFER ; Initialize the USART ring buffer
    sei                                 ; Enable global interrupts

    ; Set Z to point to the ring buffer for all HAL_PRINT calls
    ldi     ZL, lo8( USART0_RX_DEVBUFFER )
    ldi     ZH, hi8( USART0_RX_DEVBUFFER )

  loop:
    rcall   a_toggle_function           ; Push string to buffer and toggle LED
    rcall   HAL_USART_FLUSH_DEVICEBUFFER ; Drain buffer to USART hardware

    HAL_DELAY_MS 1000                   ; Wait 1 second
    rjmp    loop                        ; Repeat indefinitely
ENDF main

; ISR: PORT_vect (Button Interrupt)
; Description: Toggles the message state when the board button is pressed.
ISR_START _(BOARD_BUTTON_PORT,_PORT_vect) r18
    ldi     r18, 1                      ; Load bit 0
    eor     TOGGLE_REG, r18             ; Flip bit 0 of state register

    ldi     r18, BOARD_BUTTON_PIN       ; Load button pin mask
    sts     _(BOARD_BUTTON_PORT,_INTFLAGS), r18 ; Clear the interrupt flag
ISR_END _(BOARD_BUTTON_PORT,_PORT_vect) r18
