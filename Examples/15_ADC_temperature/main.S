; -----------------------------------------------------------------------------
; File: Examples/15_ADC_temperature/main.S
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
    PRINT_STR "__ ADC: Internal temperature sensor\r\n"
    PRINT_STR "Reading Temperature sensor... \n\r"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    HAL_ADC_EX_ENABLE ADC_PRESC_DIV16_gc, ADC_REFSEL_1V024_gc

/*  DEBUG_STR_LDSW SIGROW_TEMPSENSE0, "Temperature Calibration 0: "
    DEBUG_STR_LDSW SIGROW_TEMPSENSE1, "Temperature Calibration 1: "
    DEBUG_STR_LDSW HAL_ONE_MS, "Clocks/mS (HAL_ONE_MS): "
    DEBUG_STR_LDSW CLKCTRL_MCLKTIMEBASE, "Clocks/μS: "
    DEBUG_STR_LDS ADC0_CTRLA, "ADC0_CTRLA: "
    DEBUG_STR_LDS ADC0_CTRLB, "ADC0_CTRLB: "
    DEBUG_STR_LDS ADC0_CTRLC, "ADC0_CTRLC: "
    DEBUG_STR_LDS ADC0_CTRLE, "ADC0_CTRLE/SAMPLE DURATION: "
    DEBUG_STR_LDS ADC0_CTRLF, "ADC0_CTRLF: "
    DEBUG_STR_LDS ADC0_STATUS, "ADC0_STATUS: "
    DEBUG_STR_LDS ADC0_INTFLAGS, "ADC0_FLAGS: " */

    HAL_ADC_EX_READ ADC_MUXPOS_TEMPSENSE_gc         ; Do one time instant ADC Read
    rcall   HAL_ADC_EX_PRINT_TEMPERATURE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    ; DEBUG_STR_REGW r22, "ADC RESULT 16-bit value: "

  loop:
    rjmp    loop

ENDF main
