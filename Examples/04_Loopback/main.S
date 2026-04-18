; -----------------------------------------------------------------------------
; File: Examples/04_Loopback/main.S
; Description: Demonstrates USART loopback using a high-performance ring buffer.
;              - Initializes a 128-byte ring buffer.
;              - Uses RX interrupts to receive data and store it in the buffer.
;              - The main loop periodically flushes the buffer back to TX.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Connect via USART. Any character typed in your terminal will be received
;   by the board and echoed back (loopback).
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: main
; Description: Application entry point. Initializes hardware and the ring buffer,
;              then enters a loop to flush received data back to USART.
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board and USART initialization
    _DEVBUFFER(RX_DEVBUFFER, 128, USART_ADDR) ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")
    _STR("__ USART Loopback test: Start typing!\r\n")$ _STR_FLUSH()

    ; Configure USART RX Interrupt
    lds     r18, _(USART,_CTRLB)              ; Read CTRLB
    ori     r18, USART_RXEN_bm                ; Enable Receiver
    sts     _(USART,_CTRLB), r18              ; Update CTRLB
    ldi     r18, USART_RXCIE_bm               ; Enable RX Complete Interrupt
    sts     _(USART,_CTRLA), r18              ; Update CTRLA

  loop:
    cli                                       ; Disable interrupts for atomic flush
    _STR_FLUSH()                              ; Send all data in buffer back to TX
    sei
    _SLEEP()                                  ; Wait for new data (RX interrupt)
    rjmp    loop                              ; Repeat indefinitely

ENDF main

; -----------------------------------------------------------------------------
; ISR: USART0_RXC_vect (RX Complete)
; Description: Receives incoming data and pushes it into the ring buffer.
; -----------------------------------------------------------------------------
ISR_START _(USART,_RXC_vect), r18
    rcall   HAL_USART_RECEIVE_DEVICEBUFFER    ; Pull from hardware, push to buffer Z
ISR_END _(USART,_RXC_vect), r18
