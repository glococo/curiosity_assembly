; -----------------------------------------------------------------------------
; File: Examples/14_Analog_Digital_Converter/main.S
; Description: Analog-to-Digital Converter (ADC) example for EA/EB Series
;              - Reads an analog value from AIN0.
;              - Toggles LED based on the reading.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   Apply a variable voltage (0 to VDD) to the AIN0 pin (e.g., PD0 on EB32).
;   The LED will blink faster as the voltage increases.
; -----------------------------------------------------------------------------
; Define a 256-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 256, USART_ADDR

FUNC main
    rcall   HAL_BOARD_SETUP                         ; Basic board initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER              ; Initialize USART TX buffer
    ldi2    ZL, TX_DEVBUFFER                        ; Set Z to point to the device buffer for all PRINT functions

    rcall   HAL_PRINT_NEW_LINE
    PRINT_STR "__ CURIOSITY ASSEMBLY __\r\n"
    PRINT_STR "__ ADC: Measuring AIN0 pin\r\n"

    ; Ref: VDD, Prescaler: /16 (1250kHz ADC clock at 20MHz CPU)
    HAL_ADC_EX_ENABLE ADC_PRESC_DIV16_gc, ADC_REFSEL_VDD_gc

  loop:
    HAL_ADC_EX_READ ADC_MUXPOS_AIN0_gc              ; Do one time instant ADC Read

    DEBUG_STR_REGW r22, "ADC RESULT: "

    ; If result > 2048 (approx VDD/2), blink fast
    ; If result <= 2048, blink slow
    cpi2    r22, 2048
    brsh    fast_blink

  slow_blink:
    HAL_DELAY_MS 500
    rjmp    toggle_led

  fast_blink:
    HAL_DELAY_MS 100

  toggle_led:
    ldi     r22, 1<<BOARD_LED_PIN
    sts     _(BOARD_LED_PORT,_OUTTGL), r22
    rjmp    loop

ENDF main
