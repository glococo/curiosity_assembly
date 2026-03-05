.section .bss
HAL_ONE_MS:                     .byte 0, 0
HAL_CORE_DIVISOR:               .byte 0

; Receives a new clock divisor (DS40002522A p102) in r16, 0: PEN=0 (prescaler
; disabled, div /1), 1: PEN=1, PDIV=0 (div /2), 2: PEN=1, PDIV=1 (div /4), ...
DEFUN HAL_CORE_PRESCALER
  HAL_CORE_PRESCALER:
  PUSH_MANY r18, r22, r23
    sts     HAL_CORE_DIVISOR, r18           ; Make sure r18 is never higher than 6 (/64 div)
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
    lds     r18, HAL_CORE_DIVISOR
    rcall   MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18 - Logical Shift Right - Result = Input >> Count
    sts     HAL_ONE_MS, r22
    sts     HAL_ONE_MS+1, r23

  POP_MANY r23, r22, r18
  ret
ENDF HAL_CORE_PRESCALER

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
    ldi     r20, 0
    ldi     r21, 0
    rcall   MATH_UDIV_32_32                       ; r25:r22 = r25:r22 / r21:r18
    sts     _(USART,_BAUDL), r22
    sts     _(USART,_BAUDH), r23
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18
  ret
ENDF HAL_USART_BAUDRATE_UPD

DEFUN _HAL_UART_Print_Text_from_flash
  _HAL_UART_Print_Text_from_flash:
  PUSH_MANY  r18, r19
  uart_read_next_char:
    lpm   r18, Z+
    tst   r18
    breq  exit
  wait_for_DREIF:
    lds   r19, _(USART,_STATUS)
    sbrs  r19, USART_DREIF_bp
    rjmp  wait_for_DREIF
    sts   _(USART,_TXDATAL), r18
    rjmp  uart_read_next_char
  exit:
  POP_MANY   r19, r18
  ret
ENDF _HAL_UART_Print_Text_from_flash

DEFUN _HAL_UART_Print_char
  _HAL_UART_Print_char:
  push  r19
  wait_for_DREIF_char:
    lds   r19, _(USART,_STATUS)
    sbrs  r19, USART_DREIF_bp
    rjmp  wait_for_DREIF_char
    sts   _(USART,_TXDATAL), r18
  pop   r19
  ret
ENDF _HAL_UART_Print_char
