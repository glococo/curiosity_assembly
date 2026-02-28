.section .progmem.data
CLOCK_DIV_LOOKUP_TABLE:     .byte 2, 4, 8, 16, 32, 64, 0, 0, 6, 10, 12, 24, 48
.section .bss
ONE_MS:                     .byte 0, 0
CPU_DIVISOR:                .byte 0

; Receives a new clock divisor (DS40002522A p102) in r16, 0: PEN=0 (prescaler
; disabled, div /1), 1: PEN=1, PDIV=0 (div /2), 2: PEN=1, PDIV=1 (div /4), ...
DEFUN HAL_CPU_SPEED
  HAL_CPU_SPEED:
  PUSH_MANY r16, r17, r22, r30, r31

    tst   r16
    breq  write_divisor_register
    dec   r16                                   ; enable PEN and set PDIV
    lsl   r16
    ori   r16, 1

  write_divisor_register:
    ldi   r17, 0xD8                             ; Unlock CPU_CCP register
    sts   CPU_CCP, r17
    sts   CLKCTRL_MCLKCTRLB, r16

  update_CPU_DIVISOR:
    sbrc  r16, 0                                ; Skip next instruction if PEN is 0
    rjmp  prescaler_enabled                     ; PEN is disabled, divisor is 1
    ldi   r22, 1
    rjmp  save_CPU_DIVISOR
  prescaler_enabled:
    eor   r0, r0
    lsr   r16
    andi  r16, 0x0F
    ldi   r30, lo8( CLOCK_DIV_LOOKUP_TABLE )
    ldi   r31, hi8( CLOCK_DIV_LOOKUP_TABLE )
    add   r30, r16
    adc   r31, r0
    lpm   r22, Z
  save_CPU_DIVISOR:
    sts   CPU_DIVISOR, r22

    rcall hal_UPDATE_ONE_MS

  POP_MANY r31, r30, r22, r17, r16
  ret
ENDF HAL_CPU_SPEED

DEFUN hal_UPDATE_ONE_MS
  hal_UPDATE_ONE_MS:
  PUSH_MANY r18, r19, r22, r23
    ldi   r22, lo8( CLOCK_INT_KHZ/4 )
    ldi   r23, hi8( CLOCK_INT_KHZ/4 )
    lds   r18, CPU_DIVISOR
    cpi   r18, 1
    brne  needs_division                        ; Divisor is 1, skip division
    rjmp  store_one_ms
  needs_division:
    ldi   r19, 0
    rcall MATH_UDIV_16_16                       ; r23:r22 /= r19:r18
  store_one_ms:
    ; subi  r22, 3
    ; sbci  r23, 0
    sts   ONE_MS, r22
    sts   ONE_MS+1, r23
  POP_MANY r23, r22, r19, r18
  ret
ENDF hal_UPDATE_ONE_MS

DEFUN HAL_USART_UPDATE_BAUDRATE
  HAL_USART_UPDATE_BAUDRATE:
    ; Calculate divisor = CPU_DIVISOR * 16 * USART_BAUD_RATE
    lds r22, CPU_DIVISOR                        ; Load CPU_DIVISOR into r23:r22
    ldi r23, 0

    ldi r20, lo8( 16 * USART_BAUD_RATE / 1000)  ; Load (16 * USART_BAUD_RATE) into r21:r20
    ldi r21, hi8( 16 * USART_BAUD_RATE / 1000)

    rcall MATH_MUL_16_32                       ; r19:r18:r17:r16 = r23:r22 * r21:r20

    ; Calculate baud_reg = ( 10 * 64 * CLOCK_INT_KHZ ) / divisor
    movw r20, r18
    movw r18, r16

    ldi r22, lo8(  64 * CLOCK_INT_KHZ )
    ldi r23, hi8(  64 * CLOCK_INT_KHZ )
    ldi r24, hlo8( 64 * CLOCK_INT_KHZ )
    ldi r25, hhi8( 64 * CLOCK_INT_KHZ )

    rcall MATH_UDIV_32_32

    subi r18, 1                                 ; Subtract 1
    sbci r19, 0

    sts USART0_BAUDL, r18
    sts USART0_BAUDH, r19

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
