; -----------------------------------------------------------------------------
; File: Examples/12_Watchdog_timer/main.S
; Description: Watchdog Timer (WDT) example.
;              - Shows how to enable the WDT.
;              - Demonstrates "patting" the dog to prevent reset.
;              - Demonstrates a system reset by deliberately stopping pats.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   The LED will blink 4 times slow on reset, then 5 times faster.
;   After 1s, the LED will stay in its last state until the WDT resets the MCU.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point.
;              - Performs a slow blink on startup (to indicate reset/boot).
;              - Enables the WDT.
;              - Toggles LED faster and resets WDT in a loop for one second.
;              - Stops resetting WDT and enters a busy loop to trigger reset.
; -----------------------------------------------------------------------------
FUNC main
  rcall   HAL_BOARD_SETUP                     ; Basic board initialization
  _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)   ; Initialize the USART ring buffer
  _STR("__ CURIOSITY ASSEMBLY __\r\n")
  _STR("__ WDT: Toggles LED and resets WDT in a loop for a second\r\n")$ _STR_FLUSH()

  ; Indication of reset/start: Fast blink 4 times
  ldi     r20, 8                              ; 8 toggles = 4 blinks
  reset_blink:
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)
    _DELAY_MS(800)
    dec     r20
    brne    reset_blink

    _WDT_ENABLE( WDT_PERIOD_8KCLK_gc )

    ; Normal Operation: Loop 10 toggles (1 second total), patting the dog.
    ; The LED will toggle every 100ms.
    ldi     r20, 10
  normal_op:
    _WDT_RESET()                              ; Pat the dog
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)
    _DELAY_MS(100)                            ; Wait 100ms
    dec     r20
    brne    normal_op

  ; System will now stop patting and enter a busy loop.
  ; The WDT will trigger a reset after 250 milliseconds.
  ; After reset, the "Fast blink" sequence at the start of main will repeat.
  loop_forever:
    rjmp    loop_forever

ENDF main
