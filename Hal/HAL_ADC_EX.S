; File: Hal/HAL_ADC_EX.S
; Description: Analog-to-Digital Converter (ADC) helper library for modern AVR (Dx/Ex).
;              Provides routines for initializing, reading, and configuring ADC.

.section .progmem.rodata
ADC_DIV_TABLE:  .byte 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32, 40, 48, 56, 64

; Macro: .macro HAL_ADC_EX_ENABLE
; Description: Inline macro for EA/EB series to configure ADC reference voltage, prescaler and ENABLE
; Inputs:  prescaler  - Prescaler, ex: ADC_PRESC_DIV16_gc
;          vreference - Voltage reference, ex: ADC_REFSEL_VDD_gc
;          sampdur    - Sample duration in us, ex: 4
; Outputs: None
.macro HAL_ADC_EX_ENABLE prescaler, vreference, sampdur=4
    ldi     r22, ADC_ENABLE_bm
    ldi     r23, \prescaler
    ldi     r24, \vreference
    ldi     r25, \sampdur
    rcall   HAL_ADC_EX_SETUP
.endm

.macro HAL_ADC_EX_READ ain
    ldi     r22, \ain
    ldi     r23, (ADC_START_IMMEDIATE_gc | ADC_MODE_SINGLE_12BIT_gc)
    rcall   HAL_ADC_EX_READ_POLLING
.endm
.macro HAL_ADC_EX_BURST ain, sampnum
    ldi     r22, \sampnum
    sts     ADC0_CTRLF, r22
    ldi     r22, \ain
    ldi     r23, (ADC_START_IMMEDIATE_gc | ADC_MODE_BURST_gc)
    rcall   HAL_ADC_EX_READ_POLLING
.endm

; Function: HAL_ADC_EX_SETUP (EA/EB series)
; Description: Initializes the ADC and calculate SAMPDUR.
; Inputs:  r22 - CTRLA (Enable)
;          r23 - CTRLB (Prescaler)
;          r24 - CTRLC (V_reference)
;          r25 - CTRLE (Sample duration in us)
; Outputs: None
FUNC HAL_ADC_EX_SETUP
  PUSH_MANY r18, XL, XH
    sts     ADC0_CTRLC, r24     ; CTRLC (V_reference)
    sts     ADC0_CTRLB, r23     ; CTRLB (Prescaler)
    sts     ADC0_CTRLA, r22     ; CTRLA (Enable)

    ; SAMPDUR = SampleTime_us * fCLK_ADC
    ; fCLK_ADC = fCLK_MAIN / Prescaler
    ; fCLK_MAIN = MCLKTIMEBASE (MHz)
    ; SAMPDUR = (SampleTime_us * MCLKTIMEBASE) / Prescaler

    lds     r22, CLKCTRL_MCLKTIMEBASE
    andi    r22, 0x1F
    mul     r22, r25            ; r1:r0 = SampleTime_us * MCLKTIMEBASE
    movw    r22, r0             ; r23:r22 = result

    ldiw    XL, MAPPED_PROGMEM_START + ADC_DIV_TABLE
    add     XL, r23
    adc     XH, __zero_reg__
    ld      r18, X              ; r18 = Divisor

    rcall   MATH_UDIV_08        ; r22 = (SampleTime_us * MCLKTIMEBASE) / Prescaler
    inc     r22                 ; Rounding +1
    sts     ADC0_CTRLE, r22
  0:
    lds     r22, ADC0_STATUS
    sbrc    r22, ADC_ADCBUSY_bp                 ; Wait for ADCBUSY (bit 0)
    rjmp    0b
  POP_MANY XH, XL, r18
ENDF HAL_ADC_EX_SETUP

; Function: HAL_ADC_EX_READ_POLLING
; Description: Performs a single conversion on the specified channel.
; Inputs:  r22 - ADC0_MUXPOS (Channel)
; Outputs: r25:r22 - 32-bit ADC Result
FUNC HAL_ADC_EX_READ_POLLING
    sts     ADC0_MUXPOS, r22                    ; Select Channel
    sts     ADC0_COMMAND, r23                   ; Start Conversion
  0:
    lds     r22, ADC0_INTFLAGS
    sbrs    r22, ADC_RESRDY_bp                  ; Wait for SAMPCIF/RESRDY (bit 0)
    rjmp    0b
    sts     ADC0_INTFLAGS, r22                  ; Clear flag
    lds4    r22, ADC0_RESULT0                   ; Read Result
ENDF HAL_ADC_EX_READ_POLLING

FUNC HAL_ADC_EX_PRINT_TEMPERATURE
  PUSH_MANY r18, r19, r22, r23, r24, r25
    PRINT_STR "Temperature: "

    ; 3. Calculate Temperature in Kelvin
    ; Formula: [ (ADC_RES + OFFSET) * SLOPE ] / 4096
    ldsw    r18, SIGROW_TEMPSENSE1                  ; r19:r18 = Offset (signed 16-bit)
    add     r22, r18
    adc     r23, r19                                ; r23:r22 = ADC_RES + Offset
    ldsw    r18, SIGROW_TEMPSENSE0                  ; r19:r18 = Slope (signed 16-bit)
    rcall   MATH_MUL_S_16_32                        ; r25:r22 = (ADC_RES + Offset) * Slope (signed 32-bit)
    ldi     r18, 12
    rcall   MATH_ASR_32                             ; r25:r22 /= 4096 (r25:r22>>12)

    subi    r22, lo8(273)
    sbci    r23, hi8(273)                           ; r23:r22 = Temperature in Celsius

    rcall   HAL_PRINT_UINT16_REG
    PRINT_STR "ºC"
    rcall   HAL_PRINT_NEW_LINE
  POP_MANY r25, r24, r23, r22, r19, r18
ENDF HAL_ADC_EX_PRINT_TEMPERATURE
