; -----------------------------------------------------------------------------
; File: Examples/16_Burst/main.S
; Description: Analog-to-Digital Converter (ADC) example for EA/EB series
;              - Reads the internal Temperature sensor value from TEMPSENSE.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point.
; -----------------------------------------------------------------------------
; Define a 256-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 256, USART_ADDR

FUNC main
    rcall   HAL_BOARD_SETUP                         ; Basic board initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER              ; Initialize USART TX buffer

    ldi2    ZL, TX_DEVBUFFER                        ; Set Z to point to the device buffer for all PRINT functions
    rcall   HAL_PRINT_NEW_LINE
    PRINT_STR "__ CURIOSITY ASSEMBLY __\r\n"
    PRINT_STR "__ ADC: Burst reading of Int temperature sensor\r\n"
    PRINT_STR "Reading Temperature sensor... \n\r"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; Enable ADC with Prescaler /4, vREF 1.024v and SampleDuration of 10uS
    HAL_ADC_EX_ENABLE ADC_PRESC_DIV10_gc, ADC_REFSEL_1V024_gc, 10

    ; Do an instant Burst ADC Read
    HAL_ADC_EX_BURST ADC_MUXPOS_TEMPSENSE_gc, (ADC_SAMPNUM_ACC64_gc | ADC_CHOPPING_bm)
    DEBUG_STR_REGL r22, "ADC RAW RESULT 32-bit value: "
    ldi     r18, 6                                  ; Shift right 4pos (RESULT/16)
    rcall   MATH_LSR_32
    DEBUG_STR_REGL r22, "ADC /16 RESULT 32-bit value: "
    DEBUG_STR_LDSW ADC0_SAMPLE, "ADC last sampled value (SAMPLE0): "

    rcall   HAL_ADC_EX_PRINT_TEMPERATURE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER


  loop:
    rjmp    loop

ENDF main
