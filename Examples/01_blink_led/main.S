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
  rcall   HAL_BOARD_SETUP                     ; Basic board initialization

  loop:
    HAL_DELAY_MS 500                          ; Wait half a second
    ldi     r22, 1<<BOARD_LED_PIN             ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r22    ; Toggle LED via hardware register

    ; Instead of hardcoding ports, "_()" macro glue two strings
    ; sts     PORTF_OUTTGL, r22

    rjmp    loop                              ; Repeat indefinitely

ENDF main
