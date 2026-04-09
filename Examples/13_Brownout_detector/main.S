; -----------------------------------------------------------------------------
; File: Examples/13_Brownout_detector/main.S
; Description: Brown-out Detector (BOD) and Voltage Level Monitor (VLM) example.
;              - Shows how to configure BOD and VLM.
;              - Toggles LED on a Voltage Level drop (VLM Interrupt).
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   The LED will blink slowly during normal operation.
;   If the supply voltage drops below the VLM threshold, the LED blinks fast.
; -----------------------------------------------------------------------------

FUNC main
  rcall   HAL_BOARD_SETUP                     ; Basic board initialization
  _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)     ; Initialize the USART ring buffer
  _STR("__ CURIOSITY ASSEMBLY __\r\n")
  _STR("__ BOD: Toggle fast LED on a Voltage Level drop\r\n")$ _STR_FLUSH()

  ; 1. Configure BOD
  ; Active mode: Enabled
  ; Sleep mode: Disabled
  ; Level: 0 (typically the lowest safe level, e.g., 1.8V-2.0V)
  ldi     r22, BOD_ACTIVE_ENABLED_gc
  ldi     r23, BOD_LVL_BODLEVEL3_gc
  rcall   HAL_BOD_CONFIG

  ; 2. Configure VLM
  ; Threshold: 5% above BOD level
  ; Interrupt: Enabled
  ldi     r22, BOD_VLMLVL_5ABOVE_gc
  ldi     r23, 0x01                           ; VLMIE = 1 (VLM Interrupt Enable)
  rcall   HAL_BOD_VLM_CONFIG

  sei                                         ; Enable global interrupts

  loop:
    _DELAY_MS(1000)                         ; Slow blink
    _PORT_TGL(BOARD_LED_PORT,BOARD_LED_PIN)
    rjmp    loop

ENDF main

; -----------------------------------------------------------------------------
; ISR: BOD_VLM_vect
; Description: Voltage Level Monitor Interrupt.
;              Triggered when VDD falls below the VLM threshold.
; -----------------------------------------------------------------------------
ISR_START BOD_VLM_vect, r18
    ; Visual Alert: Fast blink 5 times
    ldi     r20, 10
    vlm_alert:
      _PORT_TGL(BOARD_LED_PORT,BOARD_LED_PIN)
      _DELAY_MS(50)
      dec     r20
      brne    vlm_alert

    ; Clear VLM Interrupt Flag
    ldi     r18, BOD_VLMIF_bm
    sts     BOD_INTFLAGS, r18
ISR_END BOD_VLM_vect, r18
