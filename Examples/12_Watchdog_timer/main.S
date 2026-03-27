; -----------------------------------------------------------------------------
; File: Examples/12_Watchdog_timer/main.S
; Description: Watchdog Timer (WDT) example.
;              - Shows how to enable the WDT.
;              - Demonstrates "patting" the dog to prevent reset.
;              - Demonstrates a system reset by deliberately stopping pats.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   The LED will blink 3 times fast on reset, then 5 times slowly (1s toggles).
;   After 5s, the LED will stay in its last state until the WDT resets the MCU.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point.
;              - Performs a fast blink on startup (to indicate reset/boot).
;              - Enables the WDT.
;              - Toggles LED and resets WDT in a loop for 5 seconds.
;              - Stops resetting WDT and enters a busy loop to trigger reset.
; -----------------------------------------------------------------------------
FUNC main
  rcall   HAL_BOARD_SETUP                     ; Basic board initialization

  ; Indication of reset/start: Fast blink 3 times
  ldi     r20, 6                              ; 6 toggles = 3 blinks
  reset_blink:
    ldi     r22, 1<<BOARD_LED_PIN
    sts     _(BOARD_LED_PORT,_OUTTGL), r22
    HAL_DELAY_MS 100
    dec     r20
    brne    reset_blink

  ; Enable WDT with ~2s period (64KCLK at 32kHz OSCULP32K)
  ; Note: WDT_PERIOD_64KCLK_bm is approx 2 seconds.
  ldi     r22, WDT_PERIOD_64KCLK_bm
  rcall   HAL_WDT_ENABLE

  ; Normal Operation: Loop 10 toggles (5 seconds total), patting the dog.
  ; The LED will toggle every 500ms.
  ldi     r20, 10
  normal_op:
    rcall   HAL_WDT_RESET                     ; Pat the dog

    ldi     r22, 1<<BOARD_LED_PIN
    sts     _(BOARD_LED_PORT,_OUTTGL), r22
    HAL_DELAY_MS 500                          ; Wait 0.5s
    dec     r20
    brne    normal_op

  ; System will now stop patting and enter a busy loop.
  ; The WDT will trigger a reset after ~2 seconds.
  ; After reset, the "Fast blink" sequence at the start of main will repeat.
  loop_forever:
    rjmp    loop_forever

ENDF main
