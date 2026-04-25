; -----------------------------------------------------------------------------
; File: Examples/02_Hello_world/toggle.S
; Description: Toggle logic for LED and string selection for direct USART transmission.
;              Provides the `a_toggle_function` used by the Hello_world example.
;
; Example Usage:
;   #define TOGGLE_REG r10
;   #include "toggle.S"
;   call a_toggle_function                   ; Call to select string and toggle LED
; -----------------------------------------------------------------------------

_ASCIZ(HELLO, "Hello World!\r\n")
_ASCIZ( HOLA, "Hola Mundo!\r\n")

; -----------------------------------------------------------------------------
; Function: a_toggle_function
; Description: Selects a greeting string based on TOGGLE_REG, sends it to the
;              current device buffer (Z), and toggles the board LED.
; Inputs:      TOGGLE_REG - State bit 0 determines string (0: HELLO, 1: HOLA)
;              Y          - Points to USART TX buffer
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC a_toggle_function
  PUSH_MANY r22, ZL, ZH

    tst     TOGGLE_REG                        ; Check the toggle state bit
    breq    0f                                ; If 0, use HELLO
    ldi2    ZL, MAPPED_PROGMEM_START + HOLA   ; Load HOLA address
    ldi     r22, LENGTH( HOLA )               ; Load string length
    jmp    1f                                ; Jump to 1f(orward)
  0:
    ldi2    ZL, MAPPED_PROGMEM_START + HELLO  ; Load HELLO address
    ldi     r22, LENGTH( HELLO )              ; Load string length
  1:
    call   HAL_USART_SEND_LENGTH             ; Send string: r22=len, Z=data, Y=uart
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)

  POP_MANY ZH, ZL, r22
ENDF a_toggle_function
