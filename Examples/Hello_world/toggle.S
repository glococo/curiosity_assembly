.section .rodata
HELLO:              .asciz "Hello World!\r\n"
HOLA:               .asciz "Hola Mundo!\r\n"

DEFUN toggle
  toggle:
    tst   REG_HELLO_OR_HOLA
    breq  hello
    ldi   r30, lo8( HOLA )
    ldi   r31, hi8( HOLA )
    rjmp  print
  hello:
    ldi   r30, lo8( HELLO )
    ldi   r31, hi8( HELLO )

  print:
    rcall Print_Text_From_Flash

  blink:
    ldi   r16, LED_PIN
    sts   _(LED_PORT,_OUTTGL), r16
  ret
ENDF toggle
