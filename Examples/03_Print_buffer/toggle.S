; -----------------------------------------------------------------------------
; File: Examples/03_Print_buffer/toggle.S
; Description: Toggle logic for LED and string selection for buffered USART transmission.
;              Provides the `a_toggle_function` used by the Print_buffer example.
;
; Example Usage:
;   #define TOGGLE_REG r10
;   #include "toggle.S"
;   rcall a_toggle_function                   ; Call to select string and toggle LED
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: a_toggle_function
; Description: Selects a greeting string based on TOGGLE_REG, sends it to the
;              current device buffer (Z), and toggles the board LED.
; Inputs:      TOGGLE_REG - State bit 0 determines string (0: HELLO, 1: HOLA)
;              Z          - Points to the device ring buffer
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC a_toggle_function

    tst     TOGGLE_REG                        ; Check the toggle state bit
    breq    0f                                ; If 0, use HELLO
    _STR("Hello World!\r\n")
    rjmp    1f                                ; Jump to 1f(orward)
  0:
    _STR("Hola Mundo!\r\n")
  1:
    _STR_FLUSH()                              ; Push selected string to buffer Z
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)   ; Toggle LED via hardware register

ENDF a_toggle_function
