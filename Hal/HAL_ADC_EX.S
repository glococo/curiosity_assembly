; File: Hal/HAL_ADC_EX.S
; Description: Analog-to-Digital Converter (ADC) helper library for modern AVR (Dx/Ex).
;              Provides routines for initializing, reading, and configuring ADC.

; Macro: .macro HAL_ADC_EX_ENABLE
; Description: Inline macro for EA/EB series to configure ADC reference voltage, prescaler and ENABLE
; Inputs:  prescaler  - Prescaler, ex: ADC_PRESC_DIV14_bm
;          vreference - Voltage reference, ex: ADC_REFSEL_1V024_bm
; Outputs: None
.macro HAL_ADC_EX_ENABLE prescaler, vreference
    ldi     r22, ADC_ENABLE_bm
    ldi     r23, \prescaler
    ldi     r24, \vreference
    rcall   HAL_ADC_EX_SETUP
.endm

.macro HAL_ADC_EX_READ ain
    ldi     r22, \ain
    rcall   HAL_ADC_EX_READ_POLLING
.endm

; Function: HAL_ADC_EX_SETUP (EA/EB series)
; Description: Initializes the ADC and calculate SAMPDUR.
; Inputs:  r22 - CTRLA (Enable)
;          r23 - CTRLB (Prescaler)
;          r24 - CTRLC (V_reference)
; Outputs: None
FUNC HAL_ADC_EX_SETUP
    sts     ADC0_CTRLC, r24
    sts     ADC0_CTRLB, r23
    sts     ADC0_CTRLA, r22

    ; Configure ADC: Ref=1.024V, Prescaler=/64 (~312.5kHz @ 20MHz)
    ; SAMPDUR >= 32us * fCLK_ADC = 10. Let's use 64 for safety.
    ldi     r22, 10
    sts     ADC0_CTRLE, r22
  0:
    lds     r22, ADC0_STATUS
    sbrc    r22, ADC_ADCBUSY_bp                 ; Wait for ADCBUSY (bit 0)
    rjmp    0b
ENDF HAL_ADC_EX_SETUP

; Function: HAL_ADC_EX_READ_POLLING
; Description: Performs a single conversion on the specified channel.
; Inputs:  r22 - ADC0_MUXPOS (Channel)
; Outputs: r23:r22 - 16-bit ADC Result
FUNC HAL_ADC_EX_READ_POLLING
    sts     ADC0_MUXPOS, r22                    ; Select Channel
    ldi     r22, (ADC_START_IMMEDIATE_bm | ADC_MODE_SINGLE_12bit_bm)
    sts     ADC0_COMMAND, r22                   ; Start Conversion
  0:
    lds     r22, ADC0_INTFLAGS
    sbrs    r22, ADC_RESRDY_bp                  ; Wait for SAMPCIF/RESRDY (bit 0)
    rjmp    0b
    sts     ADC0_INTFLAGS, r22                  ; Clear flag
    ldsw    r22, ADC0_RESULT0                   ; Read Result
ENDF HAL_ADC_EX_READ_POLLING

FUNC HAL_ADC_EX_PRINT_TEMPERATURE
  PUSH_MANY r18, r19, r22, r23, r24, r25
    PRINT_STR "Temperature: "

    ; 3. Calculate Temperature in Kelvin * 10 (for one decimal place)
    ; Formula: T_k10 = [ (ADC_RES + OFFSET) * SLOPE * 10 ] / 4096
    ldsw    r18, SIGROW_TEMPSENSE1                  ; r19:r18 = Offset (signed 16-bit)
    add     r22, r18
    adc     r23, r19                                ; r23:r22 = ADC_RES + Offset
    ldsw    r18, SIGROW_TEMPSENSE0                  ; r19:r18 = Slope (signed 16-bit)
    rcall   MATH_MUL_S_16_32                        ; r25:r22 = (ADC_RES + Offset) * Slope (signed 32-bit)
    ldi     r18, 12
    rcall   MATH_ASR_32                             ; r25:r22 /= 4096 (r25:r22>>12)

    ; 4. Convert to Celsius * 10 (T_c10 = T_k10 - 2730)
    subi    r22, lo8(273)
    sbci    r23, hi8(273)                          ; r23:r22 = Temperature in Celsius * 10

    rcall   HAL_PRINT_UINT16_REG
    PRINT_STR "ºC"
    rcall   HAL_PRINT_NEW_LINE
  POP_MANY r25, r24, r23, r22, r19, r18
ENDF HAL_ADC_EX_PRINT_TEMPERATURE
