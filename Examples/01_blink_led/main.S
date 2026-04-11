; -----------------------------------------------------------------------------
; File: Examples/01_blink_led/main.S
; Description: Basic example showing LED blinking.
;              - Toggles the BOARD LED every half second.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR-Dx/Ex board.
;   The LED will blink every second.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point. Initializes hardware and loops.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC main
  rcall   HAL_BOARD_SETUP                         ; Basic board initialization

  loop:
    _DELAY_MS(500)                                ; Wait half a second
    _PIN_TGL(BOARD_LED_PORT, BOARD_LED_PIN)      ; Toggle LED via hardware register

    ; Also, albeit slower option: "_()" macro glue two strings
    ;           ldi   r22, 1<<BOARD_LED_PIN
    ; old way   sts   _(BOARD_LED_PORT,_OUTTGL), r22
    ; or plain  sts   PORTF_OUTTGL, r22

    rjmp    loop                              ; Repeat indefinitely

ENDF main
