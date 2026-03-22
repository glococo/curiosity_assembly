; File: Examples/Double_buffer/main.S
; Description: Demonstrates Zero-Copy Double-Buffering with USART.
;              - Receives blocks of characters into a double buffer.
;              - Once a block is full, it triggers the DRE interrupt to echo it back.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Connect via USART at the configured baud rate. Type characters in blocks;
;   the board will echo them back once the buffer limit is reached.

; 1. Define a Zero-Copy 6-byte Double Buffer (High Speed)
;    Size 6 means it will flip after 6 bytes are received.
HAL_DOUBLEBUFFER_DEFINE  USART0_RX_BUFFER, 6

; 2. Define a 64-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  USART0_RX_DEVBUFFER, 64, USART0_ADDR

; Function: main
; Description: Main application entry point. Initializes buffers and USART interrupts.
; Inputs:  None
; Outputs: Never returns
FUNC main
    rcall   HAL_BOARD_SETUP             ; Basic board initialization
    HAL_DOUBLEBUFFER_INIT USART0_RX_BUFFER ; Initialize high-speed double buffer
    HAL_DEVICEBUFFER_INIT USART0_RX_DEVBUFFER ; Initialize standard ring buffer

    ; Setup USART RX Interrupt
    lds     r18, USART0_CTRLB           ; Read CTRLB
    ori     r18, USART_RXEN_bm          ; Enable Receiver
    sts     USART0_CTRLB, r18           ; Update CTRLB
    ldi     r18, USART_RXCIE_bm         ; Enable RX Complete Interrupt
    sts     USART0_CTRLA, r18           ; Update CTRLA

    PRINT_STR "\r\nUSART Double Buffered Echo Demo!\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER ; Clear boot message
    
    sei                                 ; Enable global interrupts
    
    ; Set Z to point to the Double Buffer descriptor for the ISRs
    ldi     ZL, lo8( USART0_RX_BUFFER )
    ldi     ZH, hi8( USART0_RX_BUFFER )
    
  loop:
    sleep                               ; Wait for interrupts
    rjmp    loop                        ; Repeat
ENDF main

; ISR: USART0_RXC_vect (RX Complete)
; Description: Handles incoming USART bytes and pushes them to the double buffer.
;              Triggers TX (DRE) interrupt when a buffer is full.
ISR_START USART0_RXC_vect r18
  PUSH_MANY r22
    lds     r22, USART0_ADDR            ; Read received byte (RXDATAL)
    rcall   HAL_DOUBLEBUFFER_PUSH       ; Push to active buffer, returns r18=1 if full
    tst     r18                         ; Check if flip occurred
    breq    0f                          ; If not full, exit ISR

    ; Buffer full: Trigger echoing by enabling Data Register Empty interrupt
    lds     r22, USART0_CTRLA           ; Read current CTRLA
    ori     r22, USART_DREIE_bm         ; Set DREIE bit
    sts     USART0_CTRLA, r22           ; Write back
  0:
  POP_MANY r22
ISR_END USART0_RXC_vect r18

; ISR: USART0_DRE_vect (Data Register Empty)
; Description: Drains the "Spare" (full) double buffer and sends it via USART.
;              Disables itself once the buffer is empty.
ISR_START USART0_DRE_vect r18
  PUSH_MANY YL, YH
    ldi     YL, lo8( USART0_ADDR + 2 )  ; Point Y to USART_TXDATAL
    ldi     YH, hi8( USART0_ADDR + 2 )
    rcall   HAL_DOUBLEBUFFER_WRITE_BYTE ; Pop byte from spare buffer to Y, returns r18=1 if empty
    tst     r18                         ; Check if all bytes sent
    breq    0f                          ; If not empty, exit ISR (will re-trigger)

    ; Buffer empty: Disable DRE interrupt
    lds     r18, USART0_CTRLA           ; Read current CTRLA
    cbr     r18, USART_DREIE_bm         ; Clear DREIE bit
    sts     USART0_CTRLA, r18           ; Write back
  0:
  POP_MANY YH, YL
ISR_END USART0_DRE_vect r18
