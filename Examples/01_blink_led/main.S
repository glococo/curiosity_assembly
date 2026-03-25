; File: Examples/01_Blink_led/main.S
; Description: Basic example showing LED blinking.
;              - Toggles the BOARD LED every 1 second.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR-Dx/Ex board.
;   The LED will blink every second.

; Function: main
; Description: Main application entry point. Initializes hardware and loops every second.

FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board initialization

  loop:
    HAL_DELAY_MS 1000                         ; Wait 1 second
    ldi     r22, BOARD_LED_PIN                ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r22    ; Toggle LED via hardware register

    rjmp    loop                              ; Repeat indefinitely

ENDF main
