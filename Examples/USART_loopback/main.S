; File: Examples/USART_loopback/main.S
; Description: Demonstrates USART loopback using a high-performance ring buffer.
;              - Initializes a 128-byte ring buffer.
;              - Uses RX interrupts to receive data and store it in the buffer.
;              - The main loop periodically flushes the buffer back to TX.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Connect via USART. Any character typed in your terminal will be received
;   by the board and echoed back (loopback).

; Define a 128-byte Dev-Ring-Buffer for USART0
HAL_DEVICEBUFFER_DEFINE   USART0_TX_BUFFER, 128, USART0_ADDR

; Function: main
; Description: Application entry point. Initializes hardware and the ring buffer,
;              then enters a loop to flush received data back to USART.
; Inputs:  None
; Outputs: Never returns
FUNC main
    rcall   HAL_BOARD_SETUP             ; Basic board and USART initialization
    HAL_DEVICEBUFFER_INIT USART0_TX_BUFFER ; Initialize the USART ring buffer

    ; Set Z to point to the ring buffer for ISR and main loop
    ldi     ZL, lo8( USART0_TX_BUFFER )
    ldi     ZH, hi8( USART0_TX_BUFFER )

    ; Configure USART RX Interrupt
    lds     r18, USART0_CTRLB           ; Read CTRLB
    ori     r18, USART_RXEN_bm          ; Enable Receiver
    sts     USART0_CTRLB, r18           ; Update CTRLB
    ldi     r18, USART_RXCIE_bm         ; Enable RX Complete Interrupt
    sts     USART0_CTRLA, r18           ; Update CTRLA

    PRINT_STR "\r\nUSART Loopback test: Start typing!\r\n"

  loop:
    cli                                 ; Disable interrupts for atomic flush
    rcall   HAL_USART_FLUSH_DEVICEBUFFER ; Send all data in buffer back to TX
    sei                                 ; Re-enable interrupts
    sleep                               ; Wait for new data (RX interrupt)

    rjmp    loop                        ; Repeat indefinitely
ENDF main

; ISR: USART0_RXC_vect (RX Complete)
; Description: Receives incoming data and pushes it into the ring buffer.
ISR_START USART0_RXC_vect r18
    rcall   HAL_USART_RECEIVE_DEVICEBUFFER ; Pull from hardware, push to buffer Z
ISR_END USART0_RXC_vect r18
