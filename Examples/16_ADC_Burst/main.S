; -----------------------------------------------------------------------------
; File: Examples/16_Burst/main.S
; Description: Analog-to-Digital Converter (ADC) example for Dx/Ex/SD series
;              - Reads the internal Temperature sensor value from TEMPSENSE.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
; -----------------------------------------------------------------------------

FUNC main
    call   HAL_BOARD_SETUP                          ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)          ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ ADC: Burst reading of Int temperature sensor\r\n")$ _STR_FLUSH()

    _DEBUG_LDS2(SIGROW_TEMPSENSE0, "Temp cal 0: ")
    _DEBUG_LDS2(SIGROW_TEMPSENSE1, "Temp cal 1: ")

    ; If ADC RESULT is 32-bit wide
#ifdef ADC0_RESULT3
    .print "____ Using ADC v2-extended"
    ; Enable ADC with Prescaler /10, vREF 1.024v and SampleDuration of 10uS
    _ADC_ENABLE(ADC_PRESC_DIV10_gc, ADC_REFSEL_1V024_gc, 10)

    ; Do an instant Burst ADC Read
    _ADC_BURST(ADC_MUXPOS_TEMPSENSE_gc, ADC_SAMPNUM_ACC64_gc)
    _DEBUG_REG4(r22, "ADC RAW x64 RESULT 32-bit value: ")$ _STRNR()

    ldi     r18, 6                                  ; Shift right 6pos (RESULT/64)
    call    _LSR32
    _DEBUG_REG4(r22, "ADC RAW/64 RESULT value: ")
    call   HAL_ADC_GET_TEMPERATURE_ALT

#elif defined ADC_REFSEL_2V048_gc
    .print "____ Using ADC v2"
    ; Enable ADC with Prescaler /10, vREF 2.048v and SampleDuration of 10uS
    _ADC_ENABLE(ADC_PRESC_DIV10_gc, ADC_REFSEL_2V048_gc, 10)

    ; Do an instant Burst ADC Read
    _ADC_BURST(ADC_MUXPOS_TEMPSENSE_gc, ADC_SAMPNUM_ACC64_gc)
    _DEBUG_REG2(r22, "ADC RAW x64 RESULT 16-bit value: ")$ _STRNR()

    ldi     r18, 6                                  ; Shift right 6pos (RESULT/64)
    call    _LSR16
    _DEBUG_REG2(r22, "ADC RAW/64 RESULT value: ")

    call   HAL_ADC_GET_TEMPERATURE

#elif defined VREF_REFSEL_1V048_gc
    .print "____ Using ADC v1 with native VREF"
    ; Enable ADC with Prescaler /4, vREF 2.048v and SampleDuration of 10uS
    _ADC_ENABLE(ADC_PRESC_DIV4_gc, VREF_REFSEL_1V048_gc)
    ; Do an instant Burst ADC Read
    _ADC_BURST(ADC_MUXPOS_TEMPSENSE_gc, ADC_SAMPNUM_ACC64_gc)
    _DEBUG_REG2(r22, "ADC RAW RESULT 16-bit value: ")

    ldi     r18, 6                                  ; Shift right 6pos (RESULT/64)
    call    _LSR16

    call   HAL_ADC_GET_TEMPERATURE

#elif defined VREF_ADC0REFSEL_1V1_gc
    .print "____ Using ADC v1 with VREF"
    ; Enable ADC with Prescaler /16, vREF 1.1v
     _VREF_ADC0_CONFIG( VREF_ADC0REFSEL_1V1_gc )
    _ADC_ENABLE(ADC_PRESC_DIV16_gc)
    ldi     r16, ADC_INITDLY_DLY32_gc
    sts     ADC0_CTRLD, r16
    ldi     r16, 25
    sts     ADC0_SAMPCTRL, r16
    ; Do an instant Burst ADC Read
    _ADC_BURST(ADC_MUXPOS_TEMPSENSE_gc, ADC_SAMPNUM_ACC64_gc)

    _DEBUG_REG2(r22, "ADC RAW RESULT 16-bit value: ")

    ldi     r18, 6                                  ; Shift right 6pos (RESULT/64)
    call    _LSR16
    _DEBUG_REG2(r22, "ADC RESULT/64 16-bit value: ")

    call   HAL_ADC_GET_TEMPERATURE_ALT

#else
    .error "____ ADC module not found"
#endif

    _STR("Int Temperature: ")$ _STR_U16()$ _STR("ºC")$ _STR_FLUSH()

  loop:
    jmp    loop

ENDF main
