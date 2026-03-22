; File: Examples/Hello_world/toggle.S
; Description: Toggle logic for LED and string selection for direct USART transmission.
;              Provides the `a_toggle_function` used by the Hello_world example.
;
; Example Usage:
;   #define TOGGLE_REG r10
;   #include "toggle.S"
;   rcall a_toggle_function             ; Call to select string and toggle LED

.section    .progmem.rodata
HELLO:      .asciz "Hello World!\r\n"
HOLA:       .asciz "Hola Mundo!\r\n"

; Function: a_toggle_function
; Description: Selects a greeting string based on TOGGLE_REG, sends it to the
;              current device buffer (Z), and toggles the board LED.
; Inputs:  TOGGLE_REG - State bit 0 determines string (0: HELLO, 1: HOLA)
;          Z          - Points to USART TX buffer
; Outputs: None
FUNC a_toggle_function
  PUSH_MANY r18, r19, XL, XH
    tst     TOGGLE_REG                  ; Check the toggle state bit
    breq    0f                          ; If 0, use HELLO
    ldi     XL, lo8( MAPPED_PROGMEM_START + HOLA ) ; If !0, use HOLA
    ldi     XH, hi8( MAPPED_PROGMEM_START + HOLA )
    rjmp    1f
  0:
    ldi     XL, lo8( MAPPED_PROGMEM_START + HELLO ) ; Load HELLO address
    ldi     XH, hi8( MAPPED_PROGMEM_START + HELLO )

  1:
    rcall   HAL_PRINT_STR               ; Push selected string to buffer Z

    ldi     r19, BOARD_LED_PIN          ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r19 ; Toggle LED via hardware register
  POP_MANY XH, XL, r19, r18
ENDF a_toggle_function
