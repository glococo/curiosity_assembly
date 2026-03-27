; -----------------------------------------------------------------------------
; File: Examples/14_Analog_Digital_Converter/main.S
; Description: Analog-to-Digital Converter (ADC) example.
;              - Reads an analog value from AIN0.
;              - Toggles LED based on the reading.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Apply a variable voltage (0 to VDD) to the AIN0 pin (e.g., PD0 on EB32).
;   The LED will blink faster as the voltage increases.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point.
; -----------------------------------------------------------------------------
FUNC main
  rcall   HAL_BOARD_SETUP                         ; Basic board initialization

  ; Ref: VDD, Prescaler: /64 (for ~312KHz ADC clock at 20MHz CPU)
  ldi     r22, (ADC_REFSEL_VDD_bm | ADC_PRESC_DIV64_bm)
  ldi     r23, ADC_ENABLE_bm                      ; Enable: Yes
  rcall   HAL_ADC_INIT                            ; 1. Configure ADC

  loop:
    ldi     r22, 0x00                             ; ADC0_MUXPOS_AIN0 Read from AIN0 (Channel 0)
    rcall   HAL_ADC_POLL_READ                     ; Returns result in r25:r24

    ; If result > 2048 (approx VDD/2), blink fast
    ; If result <= 2048, blink slow
    cpi     r24, lo8(2048)
    ldi     r18, hi8(2048)
    cpc     r25, r18
    brsh    fast_blink

  slow_blink:
    HAL_DELAY_MS 500
    rjmp    toggle_led

  fast_blink:
    HAL_DELAY_MS 100

  toggle_led:
    ldi     r22, 1<<BOARD_LED_PIN
    sts     _(BOARD_LED_PORT,_OUTTGL), r22
    rjmp    loop

ENDF main
