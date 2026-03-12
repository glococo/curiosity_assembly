; File: Examples/Clock_scaling/toggle.S
; Description: Logic for status reporting and LED toggling during clock scaling.

#define  TOGGLE_REG   r10

.section    .progmem.rodata
HELLO:      .asciz "Hello World!\r\n"
HOLA:       .asciz "Hola Mundo!\r\n"
SPEED:      .asciz "Current clock divisor index: "
RETURN:     .asciz "\r\n"

; DEFUN: my_toggle_function
; Description: Reports the current clock divisor index and a chosen string
;              (HELLO/HOLA) to the ring buffer, then toggles the LED.
DEFUN a_toggle_function
  a_toggle_function:
  PUSH_MANY r18, r22, r30, r31
    tst     TOGGLE_REG                      ; Check the toggle state bit
    breq    0f                              ; If 0, use HELLO
    ldi     r30, lo8( HOLA )                ; If !0, use HOLA
    ldi     r31, hi8( HOLA )
    rjmp    1f
  0:
    ldi     r30, lo8( HELLO )
    ldi     r31, hi8( HELLO )

  1:
    ; Push chosen string to ring buffer
    rcall   HAL_BBUF_PUSH_FROM_Z            ; Returns r18 -> 0:success | 1:full

    ; Push "Current clock divisor index: "
    ldi     r30, lo8( SPEED )
    ldi     r31, hi8( SPEED )
    rcall   HAL_BBUF_PUSH_FROM_Z

    ; Push the numeric divisor index (0-6) converted to ASCII ('0'-'6')
    ldi     r18, '0'
    lds     r22, HAL_CORE_DIVISOR           ; Read current divisor index from RAM
    add     r22, r18                        ; Convert 0-6 to '0'-'6'
    rcall   HAL_BBUF_PUSH

    ; Push newline
    ldi     r30, lo8( RETURN )
    ldi     r31, hi8( RETURN )
    rcall   HAL_BBUF_PUSH_FROM_Z

  blink:
    ldi     r18, LED_PIN                    ; Toggle the BOARD LED
    sts     _(LED_PORT,_OUTTGL), r18
  POP_MANY r31, r30, r22, r18
  ret
ENDF a_toggle_function
