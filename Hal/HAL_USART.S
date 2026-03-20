;------------------------------------------------------------------------------
; HAL USART — AVR Dx/Ex family
;------------------------------------------------------------------------------
;  - HAL_USART_BAUDRATE_UPD     : Recompute BAUD from BOARD_CLOCK_MAIN + divisor
;  - HAL_USART_
;  - HAL_USART_
;  - HAL_USART_

;------------------------------------------------------------------------------
; Function: HAL_USART_BAUDRATE_UPD
; Compute BAUD from BOARD_CLOCK_MAIN (kHz) and HAL_CORE_DIVISOR prescaler.
;------------------------------------------------------------------------------
FUNC HAL_USART_BAUDRATE_UPD
  PUSH_MANY r18, r19, r20, r21, r22, r23, r24, r25
    ; Optimized short function: (fClock << (2+DOUBLE)) / BaudRate

    ; Load dividend (fClock in Hz << (2+USART_DOUBLE_SPEED)) into r25:r22
    ldi     r22,  lo8( (BOARD_CLOCK_MAIN * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r23,  hi8( (BOARD_CLOCK_MAIN * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r24, hlo8( (BOARD_CLOCK_MAIN * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r25, hhi8( (BOARD_CLOCK_MAIN * 1000) << (2+USART_DOUBLE_SPEED) )

    lds     r18, HAL_CORE_DIVISOR
    rcall   MATH_LSR_32                        ; Apply CPU prescaler

    ; Load Divisor BaudRate into r21:r18
    ldi     r18, lo8( USART_BAUD_RATE )
    ldi     r19, hi8( USART_BAUD_RATE )
    ldi     r20, hlo8( USART_BAUD_RATE )
    ldi     r21, hhi8( USART_BAUD_RATE )
    rcall   MATH_UDIV_32_32                    ; r25:r22 = r25:r22 / r21:r18
    sts     _(USART,_BAUDL), r22
    sts     _(USART,_BAUDH), r23
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18
  ret
ENDF HAL_USART_BAUDRATE_UPD

; Function: HAL_USART_SEND_LENGTH
; Description: Send bytes from Unified-Memory-Map to USART Base Address.
; Input:  r22 - Length
;           Y - Points to USART Base Address.
;           Z - Pointer to Data
FUNC HAL_USART_SEND_LENGTH
  PUSH_MANY  r24, r25
  0:
    ld      r24, Z+
  1:
    ldd     r25, Y+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r25, USART_DREIF_bp
    rjmp    1b                              ; wait_for_DREIF
    std     Y+2, r24                        ; USART_TXDATAL
    dec     r22
    brne    0b                              ; read next char
  POP_MANY  r25, r24
  ret
ENDF HAL_USART_SEND_LENGTH

; Function: HAL_USART_SEND_BYTE
; Description: Send a byte to USART Base Address.
; Input:  r22 - Data
;           Y - Points to USART Base Address.
FUNC HAL_USART_SEND_BYTE
  PUSH r23
  1:
    ldd     r23, Y+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r23, USART_DREIF_bp
    rjmp    1b                              ; wait_for_DREIF
    std     Y+2, r22                        ; USART_TXDATAL
  POP  r23
  ret
ENDF HAL_USART_SEND_BYTE

;------------------------------------------------------------------------------
; Function: HAL_USART_FLUSH_DEVICEBUFFER
; Send chars over USART until DEVICEBUFFER is empty
; Returns r18: 0=done, 1=empty
;------------------------------------------------------------------------------
FUNC HAL_USART_FLUSH_DEVICEBUFFER
  PUSH_MANY  r18, r22, YL, YH
  0:
    rcall   HAL_DEVICEBUFFER_PULL
    tst     r18
    brne    2f
    ldd     YL, Z+3                         ; [ DevBuf + 3 ] USART_BASE_ADDRESS_L
    ldd     YH, Z+4                         ; [ DevBuf + 4 ] USART_BASE_ADDRESS_H
  1:
    ldd     r18, Y+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r18, USART_DREIF_bp
    rjmp    1b
    std     Y+2, r22                        ; USART_TXDATAL
    rjmp    0b
  2:
  POP_MANY YH, YL, r22, r18
  ret
ENDF HAL_USART_FLUSH_DEVICEBUFFER

;------------------------------------------------------------------------------
; Function: HAL_USART_RECEIVE_DEVICEBUFFER
; If RXCIF set, pulls one byte and pushes into ring buffer at Y.
; Returns r18: 0=stored, 1=buffer full, 2?=no data
;------------------------------------------------------------------------------
FUNC HAL_USART_RECEIVE_DEVICEBUFFER
  PUSH_MANY r22, YL, YH
    ldd     YL, Z+3                         ; [ BBuf + 3 ] USART_BASE_ADDRESS_L
    ldd     YH, Z+4                         ; [ BBuf + 4 ] USART_BASE_ADDRESS_H
  0:
    ld      r22, Y
    rcall   HAL_DEVICEBUFFER_PUSH           ; r18: 0 ok, 1 full

    ldd     r22, Y+4                        ; [ USART + 4 ] USART_STATUS
    sbrc    r22, USART_RXCIF_bp
    rjmp    0b
  POP_MANY YH, YL, r22
  ret
ENDF HAL_USART_RECEIVE_DEVICEBUFFER
