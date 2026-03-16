; File: Examples/USART_loopback/main.S
; Description: Example of using a High-Performance Byte Ring Buffer for USART transmission.
;              - Initializes a 64-byte ring buffer (HAL_USART_BUFFER_TX).
;              - Sends a string every 1 second.
; Target: CURIOSITY NANO eval boards (e.g., AVR16EB32 Curiosity Nano)

HAL_DEV_BUFFER_Y_NEW   HAL_USART0_TX_BUFFER, 128, USART0_ADDR

FUNC main                                     ; ✅ Main Program
    rcall   HAL_BOARD_SETUP                   ; Hardware setup: Button int and USART config
    HAL_DEV_BUFFER_Y_INIT HAL_USART0_TX_BUFFER ; Initialize the USART ring buffer

    lds     r18, USART0_CTRLB                 ; SETUP RX INT USART
    ori     r18, USART_RXEN_bm                ; Enable Receive
    sts     USART0_CTRLB, r18                 ;
    ldi     r18, USART_RXCIE_bm               ; Enable Receive Interruption
    sts     USART0_CTRLA, r18

    PRINT_STR "\r\nUSART Loopback test: !\r\n"
    sei                                       ; Enable interrupts

  loop:
    rcall   HAL_USART_SEND_FROM_DEV_Y         ; Drain the USART ring buffer until empty
    rcall   HAL_USART_SEND_FLUSH_DEV_Y
    sleep                                     ; Sleep until int/wakeup

    rjmp    loop                              ; Repeat indefinitely

ENDF main


FUNC USART0_RXC_vect                          ; ✅ USART Rx Interrupt
  ISR_START r18
  PUSH_MANY YL, YH
    ldi   YL, lo8( HAL_USART0_TX_BUFFER )     ; There is a case when USART is reading from the Y-Pointer
    ldi   YH, hi8( HAL_USART0_TX_BUFFER )     ;  and Interruption need the Y-Pointer too.
    rcall   HAL_USART_RECEIVE_TO_DEV_Y
  POP_MANY YH, YL
  ISR_END r18
ENDF USART0_RXC_vect
