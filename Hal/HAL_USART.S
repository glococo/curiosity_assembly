DEFUN HAL_USART_BAUDRATE_UPD
  HAL_USART_BAUDRATE_UPD:
  PUSH_MANY r18, r19, r20, r21, r22, r23, r24, r25
    ; Calculate Baud rate register
    ; Optimized short function ( fClock << 3 ) / BaudRate

    ; Load dividend ( fClock in mhz << 2 ) into r25:r22
    ldi     r22,  lo8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r23,  hi8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r24, hlo8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r25, hhi8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ; MATH_LSR_32           ; r25:r22 = r25:r22 << r18
    lds     r18, HAL_CORE_DIVISOR
    rcall   MATH_LSR_32

    ; Load Divisor BaudRate into r21:r18
    ldi     r18, lo8( USART_BAUD_RATE )
    ldi     r19, hi8( USART_BAUD_RATE )
    ldi     r20, hlo8( USART_BAUD_RATE )
    ldi     r21, hhi8( USART_BAUD_RATE )
    rcall   MATH_UDIV_32_32                       ; r25:r22 = r25:r22 / r21:r18
    sts     _(USART,_BAUDL), r22
    sts     _(USART,_BAUDH), r23
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18
  ret
ENDF HAL_USART_BAUDRATE_UPD

; Send chars over USART until BBUF is empty
DEFUN HAL_USART_X_SEND
  HAL_USART_X_SEND:
  PUSH_MANY  r18, r22
  0:
    rcall   HAL_BBUF_PULL
    tst     r18
    brne    2f
  1:
    lds   r18, _(USART,_STATUS)
    sbrs  r18, USART_DREIF_bp
    rjmp  1b
    sts   _(USART,_TXDATAL), r22
    rjmp  0b
  2:
  POP_MANY r22, r18
  ret
ENDF HAL_USART_X_SEND

; Send chars over USART from FLASH until \0
DEFUN HAL_USART_Z_SEND
  HAL_USART_Z_SEND:
  PUSH_MANY  r0, r1
  0:
    lpm   r0, Z+
    tst   r0
    breq  2f                  ; exit
  1:
    lds   r1, _(USART,_STATUS)
    sbrs  r1, USART_DREIF_bp
    rjmp  1b                  ; wait_for_DREIF
    sts   _(USART,_TXDATAL), r0
    rjmp  0b                  ; read next char
  2:
  POP_MANY  r1, r0
  ret
ENDF HAL_USART_Z_SEND

; Send ONE char over USART from r22
DEFUN HAL_USART_SEND
  HAL_USART_SEND:
  push  r0
  1:
    lds   r0, _(USART,_STATUS)
    sbrs  r0, USART_DREIF_bp
    rjmp  1b
    sts   _(USART,_TXDATAL), r22
  pop   r0
  ret
ENDF HAL_USART_SEND
