; -----------------------------------------------------------------------------
; File: Examples/14_Analog_Digital_Converter/main.S
; Description: Analog-to-Digital Converter (ADC) example for Dx/Ex/SD/Attiny1-2 Series
;              - Reads an analog value from AIN1.
;              - Toggles LED based on the reading.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Apply a variable voltage (0 to VDD) to the AIN1 pin (e.g., PA1 on Attiny3217).
;   The LED will blink faster as the voltage increases.
; -----------------------------------------------------------------------------

FUNC main
  rcall   HAL_BOARD_SETUP                         ; Basic board initialization
  _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)       ; Initialize the USART ring buffer
  _STR("__ CURIOSITY ASSEMBLY __\r\n")
  _STR("__ ADC: Reads an analog value from AIN1\r\n")$ _STR_FLUSH()

  ; Ref: VDD, Prescaler: /16 (1250kHz ADC clock at 20MHz CPU)
  _ADC_ENABLE_VDD()

  loop:
    ; Do one time instant ADC0 Read. Depending on the ADC max resolution,
    ;  range will vary between 10 or 12-bits (1023-0 or 4095-0)
    _ADC_READ(ADC_MUXPOS_AIN1_gc)
    _STR("ADC result: ")$ _STR_U16()$ _STRNR()$ _STR_FLUSH()

    ; If result > 2048 (approx VDD/2), blink fast
    ; If result <= 2048, blink slow
    cpi2    r22, 2048
    brsh    fast_blink

  slow_blink:
    _DELAY_MS(1000)
    rjmp    toggle_led

  fast_blink:
    _DELAY_MS(100)

  toggle_led:
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)
    rjmp    loop

ENDF main
