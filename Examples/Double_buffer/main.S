; File: Examples/Double_Buffer_Demo/main.S
; Description: Demonstrates Zero-Copy Double-Buffering with USART.
;              - Receives blocks of 16 characters.
;              - Once a block is full, it triggers DRE_vect to echo it back.

; 1. Define a Zero-Copy 16-byte Double Buffer (High Speed)
HAL_DOUBLEBUFFER_DEFINE  USART0_RX_BUFFER, 6

; 2. Define a 64-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_RX_DEVBUFFER, 64, USART0_ADDR

FUNC main

    rcall   HAL_BOARD_SETUP
    HAL_DOUBLEBUFFER_INIT USART0_RX_BUFFER      ; Initialize the High Speed Double Buffer
    HAL_DEVICEBUFFER_INIT USART0_RX_DEVBUFFER   ; Initialize the USART ring buffer

    lds     r18, USART0_CTRLB                   ; SETUP RX INT USART
    ori     r18, USART_RXEN_bm                  ; Enable Receive
    sts     USART0_CTRLB, r18                   ;
    ldi     r18, USART_RXCIE_bm                 ; Enable Receive Interruption
    sts     USART0_CTRLA, r18

    PRINT_STR "\r\nUSART Double Buffered vs Dev Ring Buffer!\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    sei                                         ; Enable Interrupts
    ldi     ZL, lo8( USART0_RX_BUFFER )
    ldi     ZH, hi8( USART0_RX_BUFFER )
  loop:
    sleep
    rjmp    loop
ENDF main

ISR_START USART0_RXC_vect r18                   ; --- The RX ISR ---
  PUSH_MANY r22
    lds     r22, USART0_ADDR                    ; Get Byte (RXDATAL)
    rcall   HAL_DOUBLEBUFFER_PUSH               ; Zero-Copy Push, returns r18=1 if full/ready
    tst     r18
    breq    0f                                  ; If no ready flag, exit

    lds     r22, USART0_CTRLA                   ; Enable DRE Interrupt
    ori     r22, USART_DREIE_bm
    sts     USART0_CTRLA, r22
  0:
  POP_MANY r22
ISR_END USART0_RXC_vect r18

ISR_START USART0_DRE_vect r18                   ; --- The TX Buffer trigger ---
  PUSH_MANY YL, YH
    ldi     YL, lo8( USART0_ADDR + 2 )          ; USART_TXDATAL Address
    ldi     YH, hi8( USART0_ADDR + 2 )
    rcall   HAL_DOUBLEBUFFER_WRITE_BYTE         ; Returns 0: done, 1: empty
    tst     r18
    breq    0f

    lds     r18, USART0_CTRLA                   ; Disable DRE Interrupt
    cbr     r18, USART_DREIE_bm
    sts     USART0_CTRLA, r18
  0:
  POP_MANY YH, YL
ISR_END USART0_DRE_vect r18
