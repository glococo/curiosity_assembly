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

FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board initialization
    _DOUBLEBUFFER( DOUBLE_BUFFER, 10 )        ; Initialize high-speed double buffer (Z point to DoubleBuffer)
    _DEVBUFFER(DEV_BUFFER, 128, USART_ADDR)   ; Initialize the USART devBuffer (but now, Z point to DevBuffer)
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")     ; Output to devBuffer
    _STR("__ USART Double Buffered Echo Demo!\r\nWrite +10 characters to output\r\n")
    _STR_FLUSH()                              ; <- Drain DevBuffer

    ; Configure USART RX Interrupt
    lds     r18, _(USART,_CTRLB)              ; Read CTRLB
    ori     r18, USART_RXEN_bm                ; Enable Receiver
    sts     _(USART,_CTRLB), r18              ; Update CTRLB
    ldi     r18, USART_RXCIE_bm               ; Enable RX Complete Interrupt
    sts     _(USART,_CTRLA), r18              ; Update CTRLA
    sei                                       ; Enable global interrupts

    ; Switch Z to DOUBLE_BUFFER descriptor (for the ISRs)
    ldi2    ZL, DOUBLE_BUFFER
    ; Switch Y to USART_TXDATAL TX address (for the ISRs)
    ldi2    YL, USART_ADDR + 2

  loop:
    sleep                                     ; Wait for interrupts
    rjmp    loop                              ; Repeat

ENDF main

; -----------------------------------------------------------------------------
; ISR: USART0_RXC_vect (RX Complete)
; Description: Handles incoming USART bytes and pushes them to the double buffer.
;              Triggers TX (DRE) interrupt when a buffer is full.
; -----------------------------------------------------------------------------
ISR_START _(USART,_RXC_vect), r22
    lds     r22, USART_ADDR                   ; Read received byte (RXDATAL)
    rcall   HAL_DOUBLEBUFFER_PUSH             ; Push to active buffer, returns CS if full
    brcc    0f

    ; Buffer flipped: Trigger draining/echoing by enabling Data Register Empty ISR
    lds     r22, _(USART,_CTRLA)              ; Read current CTRLA
    ori     r22, USART_DREIE_bm               ; Set DREIE bit
    sts     _(USART,_CTRLA), r22              ; Write back
  0:
ISR_END _(USART,_RXC_vect), r22

; -----------------------------------------------------------------------------
; ISR: USART0_DRE_vect (Data Register Empty)
; Description: Drains the "Spare" (full) double buffer and sends it via USART.
;              Disables itself once the buffer is empty.
; -----------------------------------------------------------------------------
ISR_START USART0_DRE_vect, r22
    rcall   HAL_DOUBLEBUFFER_PULL             ; Pop byte from spare buffer to r22, CS if empty
    brcc    0f                                ; If Carry-Clear = data in r22 -> Send it back
                                              ; If Carry-Set = Buffer_empty -> Disable DRE ISR
    lds     r22, _(USART,_CTRLA)              ; Read current CTRLA
    cbr     r22, USART_DREIE_bm               ; Clear DREIE bit
    sts     _(USART,_CTRLA), r22              ; Write back
    rjmp    1f
  0:
    st      Y, r22                      ; Write byte to Target (e.g., USART TX)
  1:
ISR_END USART0_DRE_vect, r22
