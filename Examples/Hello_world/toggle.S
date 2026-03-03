.section .progmem.rodata
HELLO:      .asciz "Hello World!\r\n"
HOLA:       .asciz "Hola Mundo!\r\n"
SPEED:      .asciz "Current clock divisor: "
RETURN:     .asciz "\r\n"

DEFUN my_toggle_function
  my_toggle_function:
  PUSH_MANY r18, r19, r30, r31
    tst     REG_HELLO_OR_HOLA
    breq    hello
    ldi     r30, lo8( HOLA )
    ldi     r31, hi8( HOLA )
    rjmp    print
  hello:
    ldi     r30, lo8( HELLO )
    ldi     r31, hi8( HELLO )

  print:
    rcall   _HAL_UART_Print_Text_from_flash
    ldi     r30, lo8( SPEED )
    ldi     r31, hi8( SPEED )
    rcall   _HAL_UART_Print_Text_from_flash
    ldi     r19, 48
    lds     r18, CORE_DIVISOR
    add     r18, r19
    rcall   _HAL_UART_Print_char
    ldi     r30, lo8( RETURN )
    ldi     r31, hi8( RETURN )
    rcall   _HAL_UART_Print_Text_from_flash

  blink:
    ldi     r18, LED_PIN
    sts     _(LED_PORT,_OUTTGL), r18
  POP_MANY r31, r30, r19, r18
  ret
ENDF my_toggle_function
