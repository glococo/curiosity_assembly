; -----------------------------------------------------------------------------
; File: Examples/15_ADC_temperature/main.S
; Description: Analog-to-Digital Converter (ADC) example.
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

    ldiw    ZL, TX_DEVBUFFER                        ; Set Z to point to the device buffer for all PRINT functions
    rcall   HAL_PRINT_NEW_LINE
    PRINT_STR "__ ADC: Internal temperature sensor"
    rcall   HAL_PRINT_NEW_LINE

    PRINT_STR "Temperature Calibration 0: "
    ldsw    r22, SIGROW_TEMPSENSE0
    rcall   HAL_PRINT_UINT16_REG                    ; Print 16-bit result
    PRINT_STR " 0x"
    rcall   HAL_PRINT_HEX16_REG                     ; Print 16-bit hex result
    rcall   HAL_PRINT_NEW_LINE

    PRINT_STR "Temperature Calibration 1: "
    ldsw    r22, SIGROW_TEMPSENSE1
    rcall   HAL_PRINT_UINT16_REG                    ; Print 16-bit result
    PRINT_STR " 0x"
    rcall   HAL_PRINT_HEX16_REG                     ; Print 16-bit hex result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER


    ldi     r22, ADC_REFSEL_1V024_bm                ; Voltage Reference for ADC (1.024V internal)
    rcall   HAL_ADC_VREF_SET

    ; 2. Configure ADC: Ref=1.024V, Prescaler=/64 (~312.5kHz @ 20MHz)
    ; SAMPDUR >= 32us * fCLK_ADC = 10. Let's use 64 for safety.
    ldi     r22, 64
    sts     ADC0_CTRLE, r22

    ldi     r22, (ADC_REFSEL_1V024_bm | ADC_PRESC_DIV64_bm)
    ldi     r23, (ADC_ENABLE_bm | ADC_RESSEL_12BIT_bm)
    rcall   HAL_ADC_INIT

    PRINT_STR "Reading Temperature sensor... "
    ldi     r22, 0x32                               ; ADC_MUXPOS_TEMPSENSE_gc
    rcall   HAL_ADC_POLL_READ                       ; Returns result in r23:r22
    movw    r14, r22                                ; Store ADC Result in r15:r14

    rcall   HAL_PRINT_UINT16_REG
    rcall   HAL_PRINT_NEW_LINE

    ; 3. Calculate Temperature in Kelvin
    ; Formula: T = [ (ADC_RES + OFFSET) * SLOPE ] / 4096
    ; OFFSET = SIGROW_TEMPSENSE1 (signed 16-bit)
    ; SLOPE  = SIGROW_TEMPSENSE0 (signed 16-bit)

    PRINT_STR "Calculating Kelvin: "
    ldsw    r18, SIGROW_TEMPSENSE1                  ; r19:r18 = OFFSET (signed)
    add     r22, r18                                ; r23:r22 = ADC_RES + OFFSET
    adc     r23, r19

    ldsw    r18, SIGROW_TEMPSENSE0                  ; r19:r18 = SLOPE (signed)
    rcall   MATH_MUL_S_16_32                        ; r25:r22 = (ADC_RES + OFFSET) * SLOPE (signed 32-bit)

    ; Division by 4096 is >> 12.
    ; Since T_k is positive, LSR or ASR works.
    ldi     r18, 12
    rcall   MATH_ASR_32                             ; r25:r22 = result / 4096

    rcall   HAL_PRINT_UINT16_REG                    ; Print Kelvin
    PRINT_STR " K"
    rcall   HAL_PRINT_NEW_LINE

    ; 4. Calculate Celsius
    ; T_c = T_k - 273
    PRINT_STR "Temperature Celsius: "
    subi    r22, lo8(273)
    sbci    r23, hi8(273)
    rcall   HAL_PRINT_INT16_REG
    PRINT_STR " C"
    rcall   HAL_PRINT_NEW_LINE

    rcall   HAL_USART_FLUSH_DEVICEBUFFER

  loop:
    rjmp    loop

ENDF main
