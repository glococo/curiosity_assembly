;------------------------------------------------------------------------------
; HAL USART — AVR Dx/Ex family
;------------------------------------------------------------------------------
;  - HAL_USART_BAUDRATE_UPD     : Recompute BAUD from BOARD_CLOCK_MAIN + divisor
;  - HAL_USART_
;  - HAL_USART_
;  - HAL_USART_
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


;------------------------------------------------------------------------------
; Function: HAL_USART_FLUSH_DEV_X
; Block until TX complete, then clear TXCIF.
;------------------------------------------------------------------------------
FUNC HAL_USART_SEND_FLUSH_DEV_X
  PUSH_MANY r18, ZL, ZH
    ld      ZL, X+                          ; [ BBuf + 3 ] USART_BASE_ADDRESS_L
    ld      ZH, X                           ; [ BBuf + 4 ] USART_BASE_ADDRESS_H
    sbiw    X, 1
  0:
    ldd     r18, Z+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r18, USART_TXCIF_bp
    rjmp    0b
  POP_MANY  ZH, ZL, r18
  ret
ENDF HAL_USART_SEND_FLUSH_DEV_X
;------------------------------------------------------------------------------
; Function: HAL_USART_FLUSH_DEV_Y
; Block until TX complete, then clear TXCIF.
;------------------------------------------------------------------------------
FUNC HAL_USART_SEND_FLUSH_DEV_Y
  PUSH_MANY r18, ZL, ZH
    ldd     ZL, Y+3                         ; [ BBuf + 3 ] USART_BASE_ADDRESS_L
    ldd     ZH, Y+4                         ; [ BBuf + 4 ] USART_BASE_ADDRESS_H
  0:
    ldd     r18, Z+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r18, USART_TXCIF_bp
    rjmp    0b
  POP_MANY  ZH, ZL, r18
  ret
ENDF HAL_USART_SEND_FLUSH_DEV_Y

;------------------------------------------------------------------------------
; Function: HAL_USART_RECEIVE_TO_DEV_X
; If RXCIF set, pulls one byte and pushes into ring dev buffer at X.
; Returns r18: 0=stored, 1=buffer full, 2?=no data
;------------------------------------------------------------------------------
FUNC HAL_USART_RECEIVE_TO_DEV_X
  PUSH_MANY r22, ZL, ZH
    ld      ZL, X+                          ; [ BBuf + 3 ] USART_BASE_ADDRESS_L
    ld      ZH, X                           ; [ BBuf + 4 ] USART_BASE_ADDRESS_H
    sbiw    X, 1
  0:
    ld      r22, Z
    rcall   HAL_DEV_BUFFER_X_PUSH           ; r18: 0 ok, 1 full

    ldd     r22, Z+4                        ; [ USART + 4 ] USART_STATUS
    sbrc    r22, USART_RXCIF_bp
    rjmp    0b
  POP_MANY ZH, ZL, r22
  ret
ENDF HAL_USART_RECEIVE_TO_DEV_X
;------------------------------------------------------------------------------
; Function: HAL_USART_RECEIVE_TO_DEV_Y
; If RXCIF set, pulls one byte and pushes into ring buffer at X.
; Returns r18: 0=stored, 1=buffer full, 2?=no data
;------------------------------------------------------------------------------
FUNC HAL_USART_RECEIVE_TO_DEV_Y
  PUSH_MANY r22, ZL, ZH
    ldd     ZL, Y+3                         ; [ BBuf + 3 ] USART_BASE_ADDRESS_L
    ldd     ZH, Y+4                         ; [ BBuf + 4 ] USART_BASE_ADDRESS_H
  0:
    ld      r22, Z
    rcall   HAL_DEV_BUFFER_Y_PUSH          ; r18: 0 ok, 1 full

    ldd     r22, Z+4                        ; [ USART + 4 ] USART_STATUS
    sbrc    r22, USART_RXCIF_bp
    rjmp    0b
  POP_MANY ZH, ZL, r22
  ret
ENDF HAL_USART_RECEIVE_TO_DEV_Y

; Send chars over USART until BBUF is empty
FUNC HAL_USART_SEND_FROM_DEV_Y
  PUSH_MANY  r18, r22, ZL, ZH
  0:
    rcall   HAL_DEV_BUFFER_Y_PULL
    tst     r18
    brne    2f
    ldd     ZL, Y+3                         ; [ DevBuf + 3 ] USART_BASE_ADDRESS_L
    ldd     ZH, Y+4                         ; [ DevBuf + 4 ] USART_BASE_ADDRESS_H
  1:
    ldd     r18, Z+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r18, USART_DREIF_bp
    rjmp    1b
    std     Z+2, r22                        ; USART_TXDATAL
    rjmp    0b
  2:
  POP_MANY ZH, ZL, r22, r18
  ret
ENDF HAL_USART_SEND_FROM_DEV_Y

; Send chars over USART until BBUF is empty
FUNC HAL_USART_SEND_FROM_DEV_X
  PUSH_MANY  r18, r22, ZL, ZH
  0:
    rcall   HAL_DEV_BUFFER_X_PULL
    tst     r18
    brne    2f
    ld      ZL, X+                          ; [ DevBuf + 0 ] USART_BASE_ADDRESS_L
    ld      ZH, X                           ; [ DevBuf + 1 ] USART_BASE_ADDRESS_H
    sbiw    X, 1                            ; Restore X pointer
  1:
    ldd     r18, Z+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r18, USART_DREIF_bp
    rjmp    1b
    std     Z+2, r22                        ; USART_TXDATAL
    rjmp    0b
  2:
  POP_MANY ZH, ZL, r22, r18
  ret
ENDF HAL_USART_SEND_FROM_DEV_X

; Function: HAL_USART_SEND_FROM_YZ
; Description: Send a null-terminated string from Mapped Flash to Y-Pointed USART Base Address.
; Input:  Y - Points to USART Base Address.
;         Z - Points to Mapped Flash string (.asciz).
FUNC HAL_USART_SEND_FROM_YZ
  PUSH_MANY  r22, r23
  0:
    ld      r22, Z+
    tst     r22
    breq    2f
  1:
    ldd     r23, Y+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r23, USART_DREIF_bp
    rjmp    1b                              ; wait_for_DREIF
    std     Y+2, r22                        ; USART_TXDATAL
    rjmp    0b                              ; read next char
  2:
  POP_MANY  r23, r22
  ret
ENDF HAL_USART_SEND_FROM_YZ

; Function: HAL_USART_SEND_BYTES_YX
; Send N bytes from SRAM buffer at X (length in r25:r24).
; Input:   Y - Points to USART Base Address.
;          X - Points to data.
;     r24:25 - Data Length.
FUNC HAL_USART_SEND_BYTES_YX
  PUSH r22
  0:
    ld      r22, X+
    rcall   HAL_USART_SEND_BYTE_Y
    sbiw    r24, 1
    brne    0b
  POP r22
  ret
ENDF HAL_USART_SEND_BYTES_YX

; Function: HAL_USART_SEND_BYTE
; Description: Send a byte from r22 to Y-Pointed USART Base Address.
; Input:   Y - Points to USART Base Address.
;        r22 - Data.
FUNC HAL_USART_SEND_BYTE_Y
  PUSH r23
  1:
    ldd     r23, Y+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r23, USART_DREIF_bp
    rjmp    1b                              ; wait_for_DREIF
    std     Y+2, r22                        ; USART_TXDATAL
  POP  r23
  ret
ENDF HAL_USART_SEND_BYTE_Y

; Function: HAL_USART_FLUSH_Y
; Block until TX complete, then clear TXCIF
FUNC HAL_USART_SEND_FLUSH_Y
  PUSH_MANY r18
  0:
    ldd     r18, Y+4                        ; [ USART + 4 ] USART_STATUS
    sbrs    r18, USART_TXCIF_bp
    rjmp    0b
  POP_MANY  r18
  ret
ENDF HAL_USART_SEND_FLUSH_Y

; Function: HAL_USART_RECEIVE_BYTE_Y ( seems to be pointless )
; Input:    Y - Points to USART Base Address.
; Output: r22 - Data.
FUNC HAL_USART_RECEIVE_BYTE_Y
  0:
    ld      r22, Y
  ret
ENDF HAL_USART_RECEIVE_BYTE_Y
