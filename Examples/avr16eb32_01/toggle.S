; .rodata append to the end of code in flash
; .progmem.data append to the end of the vector table in flash, before the code.
; .text append inside the code text in flash
; .data sram initialized in flash but manually but not automatically copied
; .bss sram uninitialized

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
