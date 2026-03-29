; -----------------------------------------------------------------------------
; File: Examples/05_Double_Buffered/main.S
; Description: Demonstrates Zero-Copy Double-Buffering with USART.
;              - Receives blocks of characters into a double buffer.
;              - Once a block is full, it triggers the DRE interrupt to echo it back.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Connect via USART at the configured baud rate. Type characters in blocks;
;   the board will echo them back once the buffer limit is reached.
; -----------------------------------------------------------------------------

; 1. Define a Zero-Copy 10-byte Double Buffer (High Speed)
;    Size 10 means it will flip after 10 bytes are received.
HAL_DOUBLEBUFFER_DEFINE  RX_BUFFER, 10

; 2. Define a 128-byte Dev-Ring-Buffer for USART (regular speed)
HAL_DEVICEBUFFER_DEFINE  RX_DEVBUFFER, 128, USART_ADDR

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point. Initializes buffers and USART interrupts.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board initialization
    HAL_DOUBLEBUFFER_INIT RX_BUFFER           ; Initialize high-speed double buffer
    HAL_DEVICEBUFFER_INIT RX_DEVBUFFER        ; Initialize standard ring buffer

    ; Configure USART RX Interrupt
    lds     r18, _(USART,_CTRLB)              ; Read CTRLB
    ori     r18, USART_RXEN_bm                ; Enable Receiver
    sts     _(USART,_CTRLB), r18              ; Update CTRLB
    ldi     r18, USART_RXCIE_bm               ; Enable RX Complete Interrupt
    sts     _(USART,_CTRLA), r18              ; Update CTRLA
    PRINT_STR "__ CURIOSITY ASSEMBLY __ \r\n"
    PRINT_STR "__ USART Double Buffered Echo Demo!\r\nWrite +10 characters to output\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER      ; Clear boot message
    sei                                       ; Enable global interrupts

    ; Set Z to point to the Double Buffer descriptor for the ISRs
    ldiw     ZL, RX_BUFFER

  loop:
    sleep                                     ; Wait for interrupts
    rjmp    loop                              ; Repeat

ENDF main

; -----------------------------------------------------------------------------
; ISR: USART0_RXC_vect (RX Complete)
; Description: Handles incoming USART bytes and pushes them to the double buffer.
;              Triggers TX (DRE) interrupt when a buffer is full.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START USART0_RXC_vect r18
    PUSH_MANY r22
    lds     r22, USART_ADDR                   ; Read received byte (RXDATAL)
    rcall   HAL_DOUBLEBUFFER_PUSH             ; Push to active buffer, returns r18=1 if full
    tst     r18                               ; Check if flip occurred
    breq    0f                                ; If not full, exit ISR

    ; Buffer full: Trigger echoing by enabling Data Register Empty interrupt
    lds     r22, _(USART,_CTRLA)              ; Read current CTRLA
    ori     r22, USART_DREIE_bm               ; Set DREIE bit
    sts     _(USART,_CTRLA), r22              ; Write back
  0:
    POP_MANY r22
ISR_END USART0_RXC_vect r18

; -----------------------------------------------------------------------------
; ISR: USART0_DRE_vect (Data Register Empty)
; Description: Drains the "Spare" (full) double buffer and sends it via USART.
;              Disables itself once the buffer is empty.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START USART0_DRE_vect r18
    PUSH_MANY YL, YH
    ldiw    YL, USART_ADDR + 2                ; Point Y to USART_TXDATAL
    rcall   HAL_DOUBLEBUFFER_WRITE_BYTE       ; Pop byte from spare buffer to Y, returns r18=1 if empty
    tst     r18                               ; Check if all bytes sent
    breq    0f                                ; If not empty, exit ISR (will re-trigger)

    ; Buffer empty: Disable DRE interrupt
    lds     r18, _(USART,_CTRLA)              ; Read current CTRLA
    cbr     r18, USART_DREIE_bm               ; Clear DREIE bit
    sts     _(USART,_CTRLA), r18              ; Write back
  0:
    POP_MANY YH, YL
ISR_END USART0_DRE_vect r18
