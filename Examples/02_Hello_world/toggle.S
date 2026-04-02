; -----------------------------------------------------------------------------
; File: Examples/02_Hello_world/toggle.S
; Description: Toggle logic for LED and string selection for direct USART transmission.
;              Provides the `a_toggle_function` used by the Hello_world example.
;
; Example Usage:
;   #define TOGGLE_REG r10
;   #include "toggle.S"
;   rcall a_toggle_function                   ; Call to select string and toggle LED
; -----------------------------------------------------------------------------

.section    .progmem.rodata
ASCIZ HELLO "Hello World!\r\n"
ASCIZ  HOLA "Hola Mundo!\r\n"

; -----------------------------------------------------------------------------
; Function: a_toggle_function
; Description: Selects a greeting string based on TOGGLE_REG, sends it to the
;              current device buffer (Z), and toggles the board LED.
; Inputs:      TOGGLE_REG - State bit 0 determines string (0: HELLO, 1: HOLA)
;              Y          - Points to USART TX buffer
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC a_toggle_function
    PUSH_MANY r18, r19, r22, ZL, ZH

    tst     TOGGLE_REG                        ; Check the toggle state bit
    breq    0f                                ; If 0, use HELLO
    ldi2    ZL, MAPPED_PROGMEM_START + HOLA   ; Load HOLA address
    ldi     r22, LENGTH( HOLA )               ; Load string length
    rjmp    1f                                ; Jump to 1f(orward)
  0:
    ldi2    ZL, MAPPED_PROGMEM_START + HELLO  ; Load HELLO address
    ldi     r22, LENGTH( HELLO )              ; Load string length
  1:
    rcall   HAL_USART_SEND_LENGTH             ; Send string: r22=len, Z=data, Y=uart

    ldi     r19, 1<<BOARD_LED_PIN             ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r19    ; Toggle LED via hardware register

    POP_MANY ZH, ZL, r22, r19, r18
ENDF a_toggle_function
