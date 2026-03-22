; File: Examples/Clock_scaling/toggle.S
; Description: Logic for status reporting and LED toggling during clock scaling.
;              Provides the `a_toggle_function` used by the Clock_scaling example.
;
; Example Usage:
;   #define TOGGLE_REG r10
;   #include "toggle.S"
;   rcall a_toggle_function             ; Call to update status and toggle LED

.section    .progmem.rodata
HELLO:      .asciz "Hello World!\r\n"
HOLA:       .asciz "Hola Mundo!\r\n"

; Function: a_toggle_function
; Description: Reports the current clock divisor index and a chosen string
;              (HELLO/HOLA) based on TOGGLE_REG, then toggles the board LED.
; Inputs:  TOGGLE_REG - State bit 0 determines string (0: HELLO, 1: HOLA)
;          Z          - Points to USART TX buffer (for HAL_PRINT functions)
; Outputs: None
FUNC a_toggle_function
  PUSH_MANY r18, r19, r22, XL, XH
    tst     TOGGLE_REG                  ; Check the toggle state register
    breq    0f                          ; If 0, jump to HELLO
    ldi     XL, lo8( MAPPED_PROGMEM_START + HOLA ) ; If !0, load HOLA
    ldi     XH, hi8( MAPPED_PROGMEM_START + HOLA )
    rjmp    1f
  0:
    ldi     XL, lo8( MAPPED_PROGMEM_START + HELLO ) ; Load HELLO
    ldi     XH, hi8( MAPPED_PROGMEM_START + HELLO )

  1:
    ; Push chosen string to ring buffer
    rcall   HAL_PRINT_NEW_LINE          ; Send \r\n
    rcall   HAL_PRINT_STR               ; Send HELLO/HOLA string
    rcall   HAL_PRINT_NEW_LINE          ; Send \r\n
    PRINT_STR "Current clock divisor index: "

    ; Push the numeric divisor index (0-6) converted to ASCII ('0'-'6')
    ldi     r18, '0'                    ; ASCII base
    lds     r22, HAL_CORE_DIVISOR       ; Get current divisor index from RAM
    add     r22, r18                    ; Convert to ASCII char
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push char to buffer
    rcall   HAL_PRINT_NEW_LINE          ; Send \r\n

    PRINT_STR "Configured Baud rate: "
    PRINT_STR STRINGIFY( USART_BAUD_RATE )
    rcall   HAL_PRINT_NEW_LINE          ; Send \r\n
    PRINT_STR "Auto-configured Baudrate clock: "

    lds     r22, _(USART,_BAUDL)        ; Read current hardware BAUDL
    lds     r23, _(USART,_BAUDH)        ; Read current hardware BAUDH
    rcall   HAL_PRINT_UINT16_REG        ; Print BAUD value
    rcall   HAL_PRINT_NEW_LINE          ; Send \r\n

  blink:
    ldi     r18, BOARD_LED_PIN          ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r18 ; Toggle LED via hardware TGL reg
  POP_MANY XH, XL, r22, r19, r18
ENDF a_toggle_function
