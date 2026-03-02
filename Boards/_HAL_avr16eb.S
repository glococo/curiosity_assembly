.section .bss
ONE_MS:                     .byte 0, 0
CORE_DIVISOR:               .byte 0

; Receives a new clock divisor (DS40002522A p102) in r16, 0: PEN=0 (prescaler
; disabled, div /1), 1: PEN=1, PDIV=0 (div /2), 2: PEN=1, PDIV=1 (div /4), ...
DEFUN HAL_CPU_SPEED
  HAL_CPU_SPEED:
  PUSH_MANY r18, r22, r23
    sts     CORE_DIVISOR, r18           ; Make sure r18 is never higher than 6 (/64 div)
    tst     r18
    breq    write_divisor_register
    dec     r18                         ; enable PEN and set PDIV
    lsl     r18
    ori     r18, 1

  write_divisor_register:
    ldi     r22, 0xD8                   ; Unlock CPU_CCP register
    sts     CPU_CCP, r22
    sts     CLKCTRL_MCLKCTRLB, r18

  update_one_ms:
    ldi     r22, lo8( CLOCK_INT_KHZ/4 )
    ldi     r23, hi8( CLOCK_INT_KHZ/4 )
    lds     r18, CORE_DIVISOR
    rcall   MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18 - Logical Shift Right - Result = Input >> Count
    sts     ONE_MS, r22
    sts     ONE_MS+1, r23

  POP_MANY r23, r22, r18
  ret
ENDF HAL_CPU_SPEED

DEFUN HAL_USART_UPDATE_BAUDRATE
  HAL_USART_UPDATE_BAUDRATE:
  PUSH_MANY r18, r19, r20, r21, r22, r23, r24, r25
    ; Calculate Baud rate register
    ; Optimized short function ( fClock << 3 ) / BaudRate

    ; Load dividend ( fClock in mhz << 2 ) into r25:r22
    ldi     r22,  lo8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r23,  hi8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r24, hlo8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ldi     r25, hhi8( (CLOCK_INT_KHZ * 1000) << (2+USART_DOUBLE_SPEED) )
    ; MATH_LSR_32           ; r25:r22 = r25:r22 << r18
    lds     r18, CORE_DIVISOR
    rcall   MATH_LSR_32

    ; Load Divisor BaudRate into r21:r18
    ldi     r18, lo8( USART_BAUD_RATE )
    ldi     r19, hi8( USART_BAUD_RATE )
    ldi     r20, 0
    ldi     r21, 0
    rcall   MATH_UDIV_32_32                       ; r21:r18 = r25:r22 / r21:r18
    sts     _(USART,_BAUDL), r18
    sts     _(USART,_BAUDH), r19
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18
  ret
ENDF HAL_USART_UPDATE_BAUDRATE

DEFUN Print_Text_From_Flash
  Print_Text_From_Flash:
    lpm   r5, Z+
    tst   r5
    breq  exit
  wait_for_DREIF:
    lds   r4, _(USART,_STATUS)
    sbrs  r4, USART_DREIF_bp
    rjmp  wait_for_DREIF
    sts   _(USART,_TXDATAL), r5
    rjmp  Print_Text_From_Flash
  exit:
  ret
ENDF Print_Text_From_Flash

DEFUN Print_Char
  Print_Char:
    push  r17
  wait_for_DREIF_char:
    lds   r17, _(USART,_STATUS)
    sbrs  r17, USART_DREIF_bp
    rjmp  wait_for_DREIF_char
    sts   _(USART,_TXDATAL), r16
    pop   r17
    ret
ENDF Print_Char
