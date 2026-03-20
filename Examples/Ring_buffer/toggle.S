; File: Examples/Ring_buffer/toggle.S
; Description: Toggle logic for LED and string selection for the ring buffer.

.section    .progmem.rodata
HELLO:      .asciz "Hello World!\r\n"
HOLA:       .asciz "Hola Mundo!\r\n"

; DEFUN: a_toggle_function
; Description: Checks TOGGLE_REG to pick a string (HELLO/HOLA),
;              pushes it into the ring buffer (pointed by X),
;              and toggles the BOARD LED.
DEFUN a_toggle_function
  PUSH_MANY r18, r19, XL, XH
    tst     TOGGLE_REG                              ; Check the toggle state bit
    breq    1f                                      ; If 0, use HELLO
    ldi     XL, lo8( MAPPED_PROGMEM_START + HOLA )  ; If !0, use HOLA
    ldi     XH, hi8( MAPPED_PROGMEM_START + HOLA )
    rjmp    2f
  1:
    ldi     XL, lo8( MAPPED_PROGMEM_START + HELLO )
    ldi     XH, hi8( MAPPED_PROGMEM_START + HELLO )

  2:
    rcall   HAL_PRINT_STR                           ; Returns r18 -> 0:success | 1:full

    ldi     r19, BOARD_LED_PIN                      ; Toggle the BOARD_LED_PIN
    sts     _(BOARD_LED_PORT,_OUTTGL), r19
  POP_MANY XH, XL, r19, r18
  ret
ENDF a_toggle_function
