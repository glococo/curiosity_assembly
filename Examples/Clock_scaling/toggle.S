; File: Examples/Clock_scaling/toggle.S
; Description: Logic for status reporting and LED toggling during clock scaling.

.section    .progmem.rodata
HELLO:      .asciz "Hello World!"
HOLA:       .asciz "Hola Mundo!"

; DEFUN: my_toggle_function
; Description: Reports the current clock divisor index and a chosen string
;              (HELLO/HOLA) to the ring buffer, then toggles the LED.
DEFUN a_toggle_function
  PUSH_MANY r18, r19, r22, r30, r31
    tst     TOGGLE_REG                              ; Check the toggle state bit
    breq    0f                                      ; If 0, use HELLO
    ldi     XL, lo8( MAPPED_PROGMEM_START + HOLA )  ; If !0, use HOLA
    ldi     XH, hi8( MAPPED_PROGMEM_START + HOLA )
    rjmp    1f
  0:
    ldi     XL, lo8( MAPPED_PROGMEM_START + HELLO )
    ldi     XH, hi8( MAPPED_PROGMEM_START + HELLO )

  1:
    ; Push chosen string to ring buffer
    rcall   HAL_PRINT_NEW_LINE              ; Push newline
    rcall   HAL_PRINT_STR                           ; Returns r18 -> 0:success | 1:full
    rcall   HAL_PRINT_NEW_LINE              ; Push newline
    PRINT_STR "Current clock divisor index: "

    ; Push the numeric divisor index (0-6) converted to ASCII ('0'-'6')
    ldi     r18, '0'
    lds     r22, HAL_CORE_DIVISOR           ; Read current divisor index from RAM
    add     r22, r18                        ; Convert 0-6 to '0'-'6'
    rcall   HAL_DEVICEBUFFER_PUSH           ; Expect value in r22
    rcall   HAL_PRINT_NEW_LINE              ; Push newline

    PRINT_STR "Configured Baud rate: "
    PRINT_STR STRINGIFY( USART_BAUD_RATE )
    rcall   HAL_PRINT_NEW_LINE              ; Push newline
    PRINT_STR "Auto-configured Baudrate clock: "

    lds     r22, _(USART,_BAUDL)
    lds     r23, _(USART,_BAUDH)
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE

  blink:
    ldi     r18, BOARD_LED_PIN                    ; Toggle the BOARD_LED_PIN
    sts     _(BOARD_LED_PORT,_OUTTGL), r18
  POP_MANY r31, r30, r22, r19, r18
  ret
ENDF a_toggle_function
