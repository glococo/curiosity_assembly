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

    ; Enable ADC with Prescaler /4, vREF 1.024v and SampleDuration of 10uS
    HAL_ADC_EX_ENABLE ADC_PRESC_DIV10_gc, ADC_REFSEL_1V024_gc, 10

    ; Do an instant Burst ADC Read
    HAL_ADC_EX_BURST ADC_MUXPOS_TEMPSENSE_gc, (ADC_SAMPNUM_ACC64_gc | ADC_CHOPPING_bm)
    _DEBUG_REG4(r22, "ADC RAW RESULT 32-bit value: ")

    ldi     r18, 6                                  ; Shift right 4pos (RESULT/16)
    rcall   MATH_LSR_32
    _DEBUG_REG4(r22, "ADC /16 RESULT 32-bit value: ")
    _DEBUG_LDS2(ADC0_SAMPLE, "ADC last sampled value (SAMPLE0): ")

    rcall   HAL_ADC_EX_GET_TEMPERATURE
    _STR("Int Temperature: ")$ _STR_REG_U16()$ _STR("ºC")$ _STR_FLUSH()

  loop:
    rjmp    loop

ENDF main
