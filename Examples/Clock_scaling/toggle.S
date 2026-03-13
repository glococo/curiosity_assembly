; File: Examples/Clock_scaling/toggle.S
; Description: Logic for status reporting and LED toggling during clock scaling.

#define  TOGGLE_REG   r10

.section    .progmem.rodata
HELLO:      .asciz "Hello World!"
HOLA:       .asciz "Hola Mundo!"
SPEED:      .asciz "Current clock divisor index: "
BAUD:       .asciz "Configured Baud rate: "
BAUDRATE:   .asciz STRINGIFY( USART_BAUD_RATE )
BAUDCLK:    .asciz "Auto-configured Baudrate clock: "

; DEFUN: my_toggle_function
; Description: Reports the current clock divisor index and a chosen string
;              (HELLO/HOLA) to the ring buffer, then toggles the LED.
DEFUN a_toggle_function
  a_toggle_function:
  PUSH_MANY r18, r19, r22, r30, r31
    tst     TOGGLE_REG                      ; Check the toggle state bit
    breq    0f                              ; If 0, use HELLO
    ldi     r30, lo8( HOLA )                ; If !0, use HOLA
    ldi     r31, hi8( HOLA )
    rjmp    1f
  0:
    ldi     r30, lo8( HELLO )
    ldi     r31, hi8( HELLO )

  1:
    ; No need to redefine USAR BUFFER in X pointer since we haven't overwrited it
    ; ldi   XL, lo8( HAL_USART_BUFFER_TX )
    ; ldi   XH, hi8( HAL_USART_BUFFER_TX )

    ; Push chosen string to ring buffer
    rcall   HAL_PRINT_FROM_Z                ; Returns r18 -> 0:success | 1:full
    rcall   HAL_PRINT_NEW_LINE              ; Push newline

    ldi     r30, lo8( SPEED )               ; Push "Current clock divisor index: "
    ldi     r31, hi8( SPEED )
    rcall   HAL_PRINT_FROM_Z

    ; Push the numeric divisor index (0-6) converted to ASCII ('0'-'6')
    ldi     r18, '0'
    lds     r22, HAL_CORE_DIVISOR           ; Read current divisor index from RAM
    add     r22, r18                        ; Convert 0-6 to '0'-'6'
    rcall   HAL_PRINT_A_CHAR                ; Expect value in r22
    rcall   HAL_PRINT_NEW_LINE              ; Push newline

    ldi     r30, lo8( BAUD )                ; Push "Configured Baud rate: "
    ldi     r31, hi8( BAUD )
    rcall   HAL_PRINT_FROM_Z
    ldi     r30, lo8( BAUDRATE )
    ldi     r31, hi8( BAUDRATE )
    rcall   HAL_PRINT_FROM_Z
    rcall   HAL_PRINT_NEW_LINE              ; Push newline

    ldi     r30, lo8( BAUDCLK )             ; Push "Auto-configured Baudrate clock: "
    ldi     r31, hi8( BAUDCLK )
    rcall   HAL_PRINT_FROM_Z

    lds     r22, _(USART,_BAUDL)
    lds     r23, _(USART,_BAUDH)
    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE

  blink:
    ldi     r18, LED_PIN                    ; Toggle the BOARD LED
    sts     _(LED_PORT,_OUTTGL), r18
  POP_MANY r31, r30, r22, r19, r18
  ret
ENDF a_toggle_function
