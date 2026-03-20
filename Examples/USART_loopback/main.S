; File: Examples/USART_loopback/main.S
; Description: Example of using a High-Performance Byte Ring Buffer for USART transmission.
;              - Initializes a 64-byte ring buffer (HAL_USART_BUFFER_TX).
;              - Sends a string every 1 second.
; Target: CURIOSITY NANO eval boards (e.g., AVR16EB32 Curiosity Nano)

HAL_DEVICEBUFFER_DEFINE   USART0_TX_BUFFER, 128, USART0_ADDR

FUNC main                                       ; ✅ Main Program
    rcall   HAL_BOARD_SETUP                     ; Hardware setup: Button int and USART config
    HAL_DEVICEBUFFER_INIT USART0_TX_BUFFER      ; Initialize the USART ring buffer

    lds     r18, USART0_CTRLB                   ; SETUP RX INT USART
    ori     r18, USART_RXEN_bm                  ; Enable Receive
    sts     USART0_CTRLB, r18                   ;
    ldi     r18, USART_RXCIE_bm                 ; Enable Receive Interruption
    sts     USART0_CTRLA, r18

    PRINT_STR "\r\nUSART Loopback test: !\r\n"

  loop:
    cli                                         ; Wait for atomic Buffer flush (Z-pointer atomicy)
    rcall   HAL_USART_FLUSH_DEVICEBUFFER        ; Drain the USART ring buffer until empty
    sei                                         ; Re-enable interrupts
    sleep                                       ; Sleep until int/wakeup

    rjmp    loop                                ; Repeat indefinitely

ENDF main


FUNC USART0_RXC_vect                            ; ✅ USART Rx Interrupt
  ISR_START r18
    rcall   HAL_USART_RECEIVE_DEVICEBUFFER
  ISR_END r18
ENDF USART0_RXC_vect
