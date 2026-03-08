#define  TOGGLE_REG   r10

.section    .progmem.rodata
HELLO:      .asciz "Hello World!\r\n"
HOLA:       .asciz "Hola Mundo!\r\n"

DEFUN my_toggle_function
  my_toggle_function:
  PUSH_MANY r18, r19, r30, r31
    tst     TOGGLE_REG
    breq    1f
    ldi     r30, lo8( HOLA )
    ldi     r31, hi8( HOLA )
    rjmp    2f
  1:
    ldi     r30, lo8( HELLO )
    ldi     r31, hi8( HELLO )

  2:
    rcall   HAL_BBUF_PUSH_FROM_Z

    ldi     r18, LED_PIN                ; Blink
    sts     _(LED_PORT,_OUTTGL), r18
  POP_MANY r31, r30, r19, r18
  ret
ENDF my_toggle_function
