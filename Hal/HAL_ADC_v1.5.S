; File: Hal/HAL_ADC_v2.S
; Description: Analog-to-Digital Converter (ADC) helper library for modern AVR (Ex).
;              Provides routines for initializing, reading, and configuring ADC.

.section .progmem.rodata
ADC_DIV_TABLE:  .byte 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32, 40, 48, 56, 64

#define _ADC_ENABLE(pre, vref, ...)   HAL_ADC_ENABLE pre, vref, ##__VA_ARGS__
#define _ADC_READ(ain)                HAL_ADC_READ ain
#define _ADC_BURST(ain, num)          HAL_ADC_BURST ain, num

; Macro: .macro HAL_ADC_ENABLE
; Description: Inline macro for EA/EB series to configure ADC reference voltage, prescaler and ENABLE
; Inputs:  prescaler  - Prescaler, ex: ADC_PRESC_DIV16_gc
;          vreference - Voltage reference, ex: ADC_REFSEL_VDD_gc
;          sampdur    - Sample duration in us, ex: 4
; Outputs: None
.macro HAL_ADC_ENABLE prescaler, vreference, sampdur=4
    ldi     r22, ADC_ENABLE_bm
    ldi     r23, \prescaler
    ldi     r24, \vreference
    ldi     r25, \sampdur
    rcall   HAL_ADC_SETUP
.endm

.macro HAL_ADC_READ ain
    ldi     r22, \ain
    ldi     r23, ADC_START_IMMEDIATE_gc
    rcall   HAL_ADC_READ_POLLING
.endm
.macro HAL_ADC_BURST ain, sampnum
    ldi     r22, \sampnum
    sts     ADC0_CTRLF, r22
    ldi     r22, \ain
    ldi     r23, (ADC_START_IMMEDIATE_gc | ADC_MODE_BURST_gc)
    rcall   HAL_ADC_READ_POLLING
.endm

; Function: HAL_ADC_SETUP (EA/EB series)
; Description: Initializes the ADC and calculate SAMPDUR.
; Inputs:  r22 - CTRLA (Enable)
;          r23 - CTRLB (Prescaler)
;          r24 - CTRLC (V_reference)
;          r25 - CTRLE (Sample duration in us)
; Outputs: None
FUNC HAL_ADC_SETUP
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

    ldi2    XL, MAPPED_PROGMEM_START + ADC_DIV_TABLE
    add     XL, r23
    adc     XH, __zero_reg__
    ld      r18, X              ; r18 = Divisor

    rcall   MATH_UDIV_08        ; r22 = (SampleTime_us * MCLKTIMEBASE) / Prescaler
    inc     r22                 ; Rounding +1
    sts     ADC0_CTRLE, r22
  0:
#ifdef ADC0_STATUS
    lds     r22, ADC0_STATUS
    sbrc    r22, ADC_ADCBUSY_bp                 ; Wait for ADCBUSY (bit 0)
    rjmp    0b
#endif
  POP_MANY XH, XL, r18
ENDF HAL_ADC_SETUP

; Function: HAL_ADC_READ_POLLING
; Description: Performs a single conversion on the specified channel.
; Inputs:  r22 - ADC0_MUXPOS (Channel)
; Outputs: r25:r22 - 32-bit ADC Result
FUNC HAL_ADC_READ_POLLING
    sts     ADC0_MUXPOS, r22                    ; Select Channel
    sts     ADC0_COMMAND, r23                   ; Start Conversion
  0:
    lds     r22, ADC0_INTFLAGS
    sbrs    r22, ADC_RESRDY_bp                  ; Wait for SAMPCIF/RESRDY (bit 0)
    rjmp    0b
    sts     ADC0_INTFLAGS, r22                  ; Clear flag
    lds2    r22, ADC0_RESULT                    ; Read Result
ENDF HAL_ADC_READ_POLLING

FUNC HAL_ADC_GET_TEMPERATURE
  PUSH_MANY r18, r19, r24, r25, r20, r21
    ; 1. Read calibration values (Slope and Offset are 16-bit)
    lds2    r18, SIGROW_TEMPSENSE1                  ; r19:r18 = Offset (signed 16-bit)
    lds2    r20, SIGROW_TEMPSENSE0                  ; r21:r20 = Slope (signed 16-bit)

    ; 2. (ADC_RES + Offset)
    add     r22, r18
    adc     r23, r19                                ; r23:r22 = ADC_RES + Offset (signed 16-bit)

    ; 3. (ADC_RES + Offset) * Slope
    movw    r18, r20                                ; r19:r18 = Slope
    rcall   MATH_MUL_S_16_32                        ; r25:r22 = (ADC_RES + Offset) * Slope (signed 32-bit)

    ; 4. Rounding: Add 2048 (4096/2) before dividing by 4096
    ldi4    r18, 2048
    add4    r22, r18                                ; r25:r22 += 2048

    ; 5. Divide by 4096 (Shift Right 12)
    ldi     r18, 12
    rcall   MATH_ASR_32                             ; r25:r22 /= 4096

    ; 6. Convert Kelvin to Celsius (K - 273)
    subi    r22, lo8(273)
    sbci    r23, hi8(273)                           ; r23:r22 = Temperature in Celsius

  POP_MANY r21, r20, r25, r24, r19, r18
ENDF HAL_ADC_GET_TEMPERATURE
