; -----------------------------------------------------------------------------
; File: Examples/16_Burst/main.S
; Description: Analog-to-Digital Converter (ADC) example for EA/EB series
;              - Reads the internal Temperature sensor value from TEMPSENSE.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
; -----------------------------------------------------------------------------

FUNC main
  rcall   HAL_BOARD_SETUP                         ; Basic board initialization
  _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)     ; Initialize the USART ring buffer
  _STR("__ CURIOSITY ASSEMBLY __\r\n")
  _STR("__ ADC: Burst reading of Int temperature sensor\r\n")$ _STR_FLUSH()

    ; Enable ADC with Prescaler /4, vREF 2.048v and SampleDuration of 10uS
    _ADC_ENABLE(ADC_PRESC_DIV4_gc, VREF_REFSEL_2V048_gc)

    lds2    r22, SIGROW_TEMPSENSE0              ; Load byte from address
    _STR("Temperature Calibration 0: ")$ _STR_U16()$ _STR(" 0x")$ _STR_HEX(r23,r22)$ _STR("\r\n")
    lds2    r22, SIGROW_TEMPSENSE1              ; Load byte from address
    _STR("Temperature Calibration 1: ")$ _STR_U16()$ _STR(" 0x")$ _STR_HEX(r23,r22)$ _STR("\r\n")

    ; Do an instant Burst ADC Read
    _ADC_BURST(ADC_MUXPOS_TEMPSENSE_gc, ADC_SAMPNUM_ACC64_gc)
    _DEBUG_REG2(r22, "ADC RAW RESULT 16-bit value: ")

    ldi     r18, 6                                  ; Shift right 4pos (RESULT/16)
    rcall   MATH_LSR_32

    rcall   HAL_ADC_GET_TEMPERATURE
    _STR("Int Temperature: ")$ _STR_U16()$ _STR("ºC")$ _STR_FLUSH()

  loop:
    rjmp    loop

ENDF main
