; -----------------------------------------------------------------------------
; File: Examples/20_ADC_MCP9700B/main.S
; Description: MCP9700B Analog Temperature sensor example for EA/EB Series
;              - Reads an analog value from AIN0.
; -----------------------------------------------------------------------------

FUNC main
  rcall   HAL_BOARD_SETUP                         ; Basic board initialization
  _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)          ; Initialize the USART ring buffer
  _STR("__ CURIOSITY ASSEMBLY __\r\n")
  _STR("__ MCP9700B ADC: Reads an analog value from AIN0\r\n")$ _STR_FLUSH()

  ; Ref: VDD, Prescaler: /16 (1250kHz ADC clock at 20MHz CPU)

#ifdef ADC_REFSEL_1V024_gc
    _ADC_ENABLE(ADC_PRESC_DIV16_gc, ADC_REFSEL_1V024_gc, 32)
#else
    _ADC_ENABLE(ADC_PRESC_DIV24_gc, VREF_REFSEL_2V048_gc)     ; DB Series
#endif

  loop:
    _ADC_READ(ADC_MUXPOS_AIN0_gc)              ; Do one time instant ADC Read

    _STR("Raw value: ")$ _STR_U16()$ _STR(" - ")
    rcall   GET_MCP9700B_TEMP
    _STR("Temperature: ")$ _STR_S16()$ _STR(".")
    movw    r22, r18
    ldi2    r18, 25
    rcall   MATH_MUL_16_16
    _STR_S16(r22, 3)$ _STR(" C\r\n")$ _STR_FLUSH()
    _DELAY_MS(4000)

  toggle_led:
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)
    rjmp    loop

ENDF main

; Function: GET_MCP9700B_TEMP
; Description: Calculates temperature from MCP9700B ADC result (1.024V Ref, 12-bit)
; Formula: T = (ADC_RES - 2000) / 40
; Inputs:  r25:r22 - 32-bit ADC Result (actually 12-bit in r23:r22)
; Outputs: r23:r22 - Signed 16-bit Temperature in Celsius
FUNC GET_MCP9700B_TEMP
    ; 1. ADC_RES - 2000
    subi    r22, lo8(2000)
    sbci    r23, hi8(2000)              ; r23:r22 = ADC_RES - 2000 (signed 16-bit)

    ; 2. (ADC_RES - 2000) / 40
    ldi     r18, 40
    ldi     r19, 0                      ; Divisor = 40 (signed 16-bit)
    rcall   MATH_SDIV_16                ; r23:r22 = Quotient
ENDF GET_MCP9700B_TEMP
