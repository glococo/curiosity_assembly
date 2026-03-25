; File: Examples/RTC/toggle.S
; Description: Toggle logic for LED and string selection for direct USART transmission.
;              Provides the `a_toggle_function` used by the RTC example.
;
; Example Usage:
;   #include "toggle.S"
;   rcall a_toggle_function             ; Call to send string and toggle LED

.section    .progmem.rodata
ASCIZ HELLO "Hello World!\r\n"
ASCIZ HOLA  "Hola Mundo!\r\n"

; Function: a_toggle_function
; Description: Selects a string based on TOGGLE_REG and sends it directly
;              from Flash to the USART (Y), then toggles the board LED.
; Inputs:  TOGGLE_REG - State bit determines string (0: HELLO, 1: HOLA)
;          Y          - Points to the USART Peripheral Base Address
; Outputs: None
FUNC a_toggle_function
  PUSH_MANY r18, r19, r22, ZL, ZH
    tst     TOGGLE_REG                  ; Check toggle state bit
    breq    0f                          ; If 0, use HELLO
    ldi     ZL, lo8( MAPPED_PROGMEM_START + HOLA ) ; If !0, use HOLA
    ldi     ZH, hi8( MAPPED_PROGMEM_START + HOLA )
    ldi     r22, LENGTH( HOLA )         ; Load string length
    rjmp    1f
  0:
    ldi     ZL, lo8( MAPPED_PROGMEM_START + HELLO ) ; Load HELLO
    ldi     ZH, hi8( MAPPED_PROGMEM_START + HELLO )
    ldi     r22, LENGTH( HELLO )        ; Load string length
  1:
    rcall   HAL_USART_SEND_LENGTH       ; Send string: r22=len, Z=data, Y=uart

    ldi     r19, BOARD_LED_PIN          ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r19 ; Toggle LED via hardware register
  POP_MANY ZH, ZL, r22, r19, r18
ENDF a_toggle_function
