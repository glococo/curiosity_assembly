; File: Hal/HAL_USART.S
; Description: USART (Universal Synchronous/Asynchronous Receiver/Transmitter)
;              helper library for AVR-Dx/Ex families.
;
; Example Usage:
;   rcall   HAL_USART_BAUDRATE_UPD      ; Recompute BAUD based on current clock
;
;   ldi     YL, lo8(USART0_ADDR)
;   ldi     YH, hi8(USART0_ADDR)
;   ldi     r22, '!'
;   rcall   HAL_USART_SEND_BYTE         ; Send single byte

; Function: HAL_USART_BAUDRATE_UPD
; Description: Recomputes the USART BAUD register based on BOARD_CLOCK_MAIN,
;              the current CPU prescaler (HAL_CORE_DIVISOR), and USART_BAUD_RATE.
;              Formula: BAUD = (64 * fClock) / (S * BaudRate)
; Inputs:  None (Uses global constants and HAL_CORE_DIVISOR)
; Outputs: None (Updates USART_BAUDL/H registers)
FUNC HAL_USART_BAUDRATE_UPD
  PUSH_MANY r18, r19, r20, r21, r22, r23, r24, r25
    ; Load dividend: (fClock in Hz << (2 + USART_DOUBLE_SPEED))
    ; This scaling factor (4 or 8) is part of the asynchronous BAUD calculation.
    ldi     r22, lo8( (BOARD_CLOCK_MAIN * 1000) << (2 + USART_DOUBLE_SPEED) )
    ldi     r23, hi8( (BOARD_CLOCK_MAIN * 1000) << (2 + USART_DOUBLE_SPEED) )
    ldi     r24, hlo8( (BOARD_CLOCK_MAIN * 1000) << (2 + USART_DOUBLE_SPEED) )
    ldi     r25, hhi8( (BOARD_CLOCK_MAIN * 1000) << (2 + USART_DOUBLE_SPEED) )

    lds     r18, HAL_CORE_DIVISOR       ; Load current CPU clock divisor index
    rcall   MATH_LSR_32                 ; Apply CPU prescaler to dividend

    ; Load Divisor: BaudRate
    ldi     r18, lo8( USART_BAUD_RATE )
    ldi     r19, hi8( USART_BAUD_RATE )
    ldi     r20, hlo8( USART_BAUD_RATE )
    ldi     r21, hhi8( USART_BAUD_RATE )
    rcall   MATH_UDIV_32_32             ; r25:r22 = Dividend / BaudRate
    sts     _(USART,_BAUDL), r22        ; Store Baud Rate Low Byte
    sts     _(USART,_BAUDH), r23        ; Store Baud Rate High Byte
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18
ENDF HAL_USART_BAUDRATE_UPD

; Function: HAL_USART_SEND_LENGTH
; Description: Sends a block of bytes from memory to the USART.
; Inputs:  r22 - Number of bytes to send
;          Y   - Points to USART Peripheral Base Address
;          Z   - Points to Data in memory
; Outputs: None
FUNC HAL_USART_SEND_LENGTH
  PUSH_MANY  r24, r25, ZL, ZH
  0:
    ld      r24, Z+                     ; Load byte from memory
  1:
    ldd     r25, Y+4                    ; Read USART_STATUS (Base + 4)
    sbrs    r25, USART_DREIF_bp         ; Check Data Register Empty Flag
    rjmp    1b                          ; Wait until ready
    std     Y+2, r24                    ; Write to USART_TXDATAL (Base + 2)
    dec     r22                         ; Decrement length
    brne    0b                          ; Loop until all bytes sent
  POP_MANY  ZH, ZL, r25, r24
ENDF HAL_USART_SEND_LENGTH

; Function: HAL_USART_SEND_BYTE
; Description: Sends a single byte to the USART.
; Inputs:  r22 - Data byte to send
;          Y   - Points to USART Peripheral Base Address
; Outputs: None
FUNC HAL_USART_SEND_BYTE
  PUSH r23
  1:
    ldd     r23, Y+4                    ; Read USART_STATUS
    sbrs    r23, USART_DREIF_bp         ; Check DREIF
    rjmp    1b                          ; Wait until ready
    std     Y+2, r22                    ; Write to USART_TXDATAL
  POP  r23
ENDF HAL_USART_SEND_BYTE

; Function: HAL_USART_FLUSH_DEVICEBUFFER
; Description: Drains all bytes from a HAL_DEVICEBUFFER and sends them via USART.
; Inputs:  Z   - Points to HAL_DEVICEBUFFER Structure
; Outputs: r18 - 1: Buffer empty (Success)
FUNC HAL_USART_FLUSH_DEVICEBUFFER
  PUSH_MANY  r18, r22, YL, YH
  0:
    rcall   HAL_DEVICEBUFFER_PULL       ; Pull byte from ring buffer
    tst     r18                         ; Check if buffer is empty
    brne    2f                          ; Exit if empty
    ldd     YL, Z+3                     ; Load USART Base Address L from descriptor
    ldd     YH, Z+4                     ; Load USART Base Address H from descriptor
  1:
    ldd     r18, Y+4                    ; Read USART_STATUS
    sbrs    r18, USART_DREIF_bp         ; Check DREIF
    rjmp    1b                          ; Wait until ready
    std     Y+2, r22                    ; Write to USART_TXDATAL
    rjmp    0b                          ; Continue pulling
  2:
  POP_MANY YH, YL, r22, r18
ENDF HAL_USART_FLUSH_DEVICEBUFFER

; Function: HAL_USART_RECEIVE_DEVICEBUFFER
; Description: Reads all pending bytes from USART and pushes them to a HAL_DEVICEBUFFER.
; Inputs:  Z   - Points to HAL_DEVICEBUFFER Structure
; Outputs: r18 - 0: Success, 1: Buffer full
FUNC HAL_USART_RECEIVE_DEVICEBUFFER
  PUSH_MANY r22, YL, YH
    ldd     YL, Z+3                     ; Load USART Base Address L
    ldd     YH, Z+4                     ; Load USART Base Address H
  0:
    ld      r22, Y                      ; Read byte from USART_RXDATAL (Base + 0)
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push into ring buffer
    tst     r18                         ; Check if full
    brne    1f                          ; Exit if full

    ldd     r22, Y+4                    ; Read USART_STATUS
    sbrc    r22, USART_RXCIF_bp         ; Check Receive Complete Interrupt Flag
    rjmp    0b                          ; If more data, keep reading
  1:
  POP_MANY YH, YL, r22
ENDF HAL_USART_RECEIVE_DEVICEBUFFER
