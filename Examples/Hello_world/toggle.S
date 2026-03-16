; File: Examples/Hello_world/toggle.S
; Description: Toggle logic for LED and string selection for direct USART transmission.

#define  TOGGLE_REG   r10

.section    .progmem.rodata
HELLO:      .asciz "Hello World!\r\n"
HOLA:       .asciz "Hola Mundo!\r\n"

; DEFUN: a_toggle_function
; Description: Checks TOGGLE_REG to pick a string (HELLO/HOLA),
;              sends it directly over USART (from Flash),
;              and toggles the BOARD LED.
DEFUN a_toggle_function
  PUSH_MANY r18, r19, r30, r31
    tst     TOGGLE_REG                  ; Check the toggle state bit
    breq    1f                          ; If 0, use HELLO
    ldi     r30, lo8( HOLA )            ; If !0, use HOLA
    ldi     r31, hi8( HOLA )
    rjmp    2f
  1:
    ldi     r30, lo8( HELLO )
    ldi     r31, hi8( HELLO )

  2:
    ; HAL_USART_Z_SEND expects:
    ; Z (r31:r30) = Flash pointer to string
    rcall   HAL_USART_Z_SEND            ; Send the string until the null terminator

    ldi     r19, BOARD_LED_PIN          ; Toggle the BOARD_LED_PIN
    sts     _(BOARD_LED_PORT,_OUTTGL), r19
  POP_MANY r31, r30, r19, r18
  ret
ENDF a_toggle_function
