; File: Examples/Double_Buffer_Demo/main.S
; Description: Demonstrates Zero-Copy Double-Buffering with USART.
;              - Receives blocks of 16 characters.
;              - Once a block is full, it echoes it back directly from SRAM.

; 1. Define a Zero-Copy 16-byte Double Buffer (High Speed)
HAL_DOUBLEBUFFER_DEFINE  USART0_TX_BUFFER, 16

; 2. Define a 64-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_TX_DEVBUFFER, 64, USART0_ADDR

DEFUN main
    rcall   HAL_BOARD_SETUP

    HAL_DOUBLEBUFFER_INIT USART0_TX_BUFFER      ; Initialize the High Speed Double Buffer
    HAL_DEVICEBUFFER_INIT USART0_TX_DEVBUFFER   ; Initialize the USART ring buffer

    lds     r18, USART0_CTRLB                   ; SETUP RX INT USART
    ori     r18, USART_RXEN_bm                  ; Enable Receive
    sts     USART0_CTRLB, r18                   ;
    ldi     r18, USART_RXCIE_bm                 ; Enable Receive Interruption
    sts     USART0_CTRLA, r18

    PRINT_STR "\r\nUSART Double Buffered vs Dev Ring Buffer!\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    sei                                         ; Enable Interrupts

  loop:
    lds     r18, USART0_TX_BUFFER + 8           ; 4. Check Status Byte (Offset 8 of Descriptor)
    sbrc    r18, 1                              ; Check Buffer A Ready (Bit 1)
    rcall   process_buffer_a
    sbrc    r18, 2                              ; Check Buffer B Ready (Bit 2)
    rcall   process_buffer_b
    sleep
    rjmp    loop
ENDF main

DEFUN process_buffer_a                          ; --- Processor for Buffer A ---
  PUSH_MANY r22
    ldi     YL, lo8( USART0_ADDR )
    ldi     YH, hi8( USART0_ADDR )
    ldi     ZL, lo8( USART0_TX_BUFFER_A )
    ldi     ZH, hi8( USART0_TX_BUFFER_A )
    ldi     r22, USART0_TX_BUFFER_SIZE
    rcall   HAL_USART_SEND_LENGTH

    lds     r22, USART0_TX_BUFFER + 8           ; Clear Ready Flag (Bit 1)
    cbr     r22, 0x02
    sts     USART0_TX_BUFFER + 8, r22
  POP_MANY r22
  ret
ENDF process_buffer_a

DEFUN process_buffer_b                          ; --- Processor for Buffer B ---
  PUSH_MANY r22
    ldi     YL, lo8( USART0_ADDR )
    ldi     YH, hi8( USART0_ADDR )
    ldi     ZL, lo8( USART0_TX_BUFFER_B )
    ldi     ZH, hi8( USART0_TX_BUFFER_B )
    ldi     r22, USART0_TX_BUFFER_SIZE
    rcall   HAL_USART_SEND_LENGTH

    lds     r22, USART0_TX_BUFFER + 8           ; Clear Ready Flag (Bit 2)
    cbr     r22, 0x04
    sts     USART0_TX_BUFFER + 8, r22
  POP_MANY r22
  ret
ENDF process_buffer_b

FUNC USART0_RXC_vect                                            ; --- The Lean ISR ---
  ISR_START r18
    HAL_DOUBLEBUFFER_ISR_RX_PUSH USART0_TX_BUFFER, USART0_ADDR  ; Zero-Copy Push
  ISR_END r18
ENDF USART0_RXC_vect
