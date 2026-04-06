; -----------------------------------------------------------------------------
; File: Examples/15_ADC_temperature/main.S
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
    _STR("__ ADC: Reads the internal Temperature sensor\r\n")$ _STR_FLUSH()


    HAL_ADC_EX_ENABLE ADC_PRESC_DIV16_gc, ADC_REFSEL_1V024_gc, 32
    HAL_ADC_EX_READ ADC_MUXPOS_TEMPSENSE_gc         ; Do one time instant ADC Read

    rcall   HAL_ADC_EX_GET_TEMPERATURE
    _STR("Int Temperature: ")$ _STR_REG_U16()$ _STR("ºC")$ _STR_FLUSH()

  loop:
    rjmp    loop

ENDF main
