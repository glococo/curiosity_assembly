; -----------------------------------------------------------------------------
; File: Examples/15_ADC_temperature/main.S
; Description: Analog-to-Digital Converter (ADC) example for Dx/Ex/SD series
;              - Reads the internal Temperature sensor value from TEMPSENSE.
;
; -----------------------------------------------------------------------------

FUNC main
    call   HAL_BOARD_SETUP                          ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)          ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ ADC: Read Internal temperature sensor\r\n")$ _STR_FLUSH()

    ; If ADC RESULT is 32-bit wide
#ifdef ADC0_RESULT3
    .print "____ Using ADC v2-extended"
    ; Enable ADC with Prescaler /10, vREF 1.024v and SampleDuration of 10uS
    _ADC_ENABLE(ADC_PRESC_DIV10_gc, ADC_REFSEL_1V024_gc, 10)

    ; Do an instant ADC Read
    _ADC_READ(ADC_MUXPOS_TEMPSENSE_gc)
    call   HAL_ADC_GET_TEMPERATURE_ALT

#elif defined ADC_REFSEL_2V048_gc
    .print "____ Using ADC v2"
    ; Enable ADC with Prescaler /10, vREF 2.048v and SampleDuration of 10uS
    _ADC_ENABLE(ADC_PRESC_DIV10_gc, ADC_REFSEL_2V048_gc, 10)

    ; Do an instant ADC Read
    _ADC_READ(ADC_MUXPOS_TEMPSENSE_gc)
    call   HAL_ADC_GET_TEMPERATURE

#elif defined VREF_REFSEL_1V048_gc
    .print "____ Using ADC v1 with native VREF"
    ; Enable ADC with Prescaler /4, vREF 2.048v and SampleDuration of 10uS
    _ADC_ENABLE(ADC_PRESC_DIV4_gc, VREF_REFSEL_1V048_gc)

    ; Do an instant ADC Read
    _ADC_READ(ADC_MUXPOS_TEMPSENSE_gc)
    call   HAL_ADC_GET_TEMPERATURE

#elif defined VREF_ADC0REFSEL_1V1_gc
    .print "____ Using ADC v1 with VREF"
    ; Enable ADC with Prescaler /16, vREF 1.1v
     _VREF_ADC0_CONFIG( VREF_ADC0REFSEL_1V1_gc )
    _ADC_ENABLE(ADC_PRESC_DIV16_gc)

    ; Do an instant Burst ADC Read
    _ADC_READ(ADC_MUXPOS_TEMPSENSE_gc)
    call   HAL_ADC_GET_TEMPERATURE_ALT

#else
    .error "____ ADC module not found"
#endif

    _STR("Int Temperature: ")$ _STR_U16()$ _STR("ºC")$ _STR_FLUSH()

  loop:
    jmp    loop

ENDF main
