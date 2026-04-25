; File: Hal/HAL_ADC_v2.S
; Description: Analog-to-Digital Converter (ADC) helper library for modern AVR (Ex).
;              Provides routines for initializing, reading, and configuring ADC.
.section .progmem.rodata
ADC_DIV_TABLE:  .byte 2, 4, 6, 8, 10, 12, 14, 16, 20, 24, 28, 32, 40, 48, 56, 64

#define _ADC_ENABLE_VDD()             HAL_ADC_ENABLE_VDD
#define _ADC_ENABLE( ... )            HAL_ADC_ENABLE __VA_ARGS__
#define _ADC_READ( ain )              HAL_ADC_READ ain
#define _ADC_BURST( ain, num )        HAL_ADC_BURST ain, num

.macro HAL_ADC_ENABLE_VDD
  _ADC_ENABLE( ADC_PRESC_DIV16_gc )
.endm

.macro HAL_ADC_READ ain
    ldi     r22, \ain
  #ifdef ADC_MODE_SINGLE_12BIT_gc
    ldi     r23, (ADC_START_IMMEDIATE_gc | ADC_MODE_SINGLE_12BIT_gc)
  #elif defined ADC_MODE_SINGLE_10BIT_gc
    ldi     r23, (ADC_START_IMMEDIATE_gc | ADC_MODE_SINGLE_10BIT_gc)
  #else
    .error  "ADC_READ not defined"
  #endif
    call   HAL_ADC_READ_POLLING
.endm
.macro HAL_ADC_BURST ain, sampnum
    ldi     r22, \sampnum
    sts     ADC0_CTRLF, r22
    ldi     r22, \ain
    ldi     r23, (ADC_START_IMMEDIATE_gc | ADC_MODE_BURST_gc)
    call   HAL_ADC_READ_POLLING
.endm

.macro HAL_ADC_ENABLE prescaler=ADC_PRESC_DIV16_gc, vref=0, t_sampdur=5
    ldi     r25, \t_sampdur
    ldi     r24, \vref
    ldi     r23, \prescaler
    ldi     r22, ADC_ENABLE_bm
    sts     ADC0_CTRLF, __zero_reg__    ; CTRLF Sampnum reset
    call   HAL_ADC_SETUP
.endm
; Function: HAL_ADC_SETUP (EA/EB series)
; Description: Initializes the ADC and calculate SAMPDUR.
; Inputs:  r22 - CTRLA (Enable)
;          r23 - CTRLB (Prescaler)
;          r24 - CTRLC (V_reference)
;          r25 - CTRLE (t_sampdur in us)
FUNC HAL_ADC_SETUP
  PUSH_MANY r18, r19, r20, r21, XL, XH
    sts     ADC0_CTRLC, r24     ; CTRLC (V_reference)
    sts     ADC0_CTRLB, r23     ; CTRLB (Prescaler)
    sts     ADC0_CTRLA, r22     ; CTRLA (Enable)

    ; Save prescaler index and target sample time
    mov     r21, r23            ; r21 = Prescaler index (CTRLB)
    mov     r20, r25            ; r20 = Target SampleTime (us)

    ; Get Actual Divisor from Table
    ldi2    XL, MAPPED_PROGMEM_START + ADC_DIV_TABLE
    add     XL, r21
    adc     XH, __zero_reg__
    ld      r18, X              ; r18 = Actual Divisor

    ; Calculate Total CPU Cycles = SampleTime_us * f_MHz
    lds     r22, CLKCTRL_MCLKTIMEBASE
    andi    r22, 0x1F           ; MCLKTIMEBASE is 5-bit
    mul     r22, r20            ; r1:r0 = Total CPU Cycles (16-bit)

    ; Calculate ADC Clock Cycles (Ceiling) = (TotalCycles + Divisor - 1) / Divisor
    movw    r22, r0             ; r23:r22 = Total cycles
    mov     r19, r18
    dec     r19                 ; r19 = Divisor - 1
    add     r22, r19            ; Dividend += Divisor - 1
    adc     r23, __zero_reg__

    clr     r19                 ; r19:r18 = Divisor (16-bit)
    call   MATH_UDIV_16        ; r23:r22 = Quotient (Total cycles / Prescaler)

    ; SAMPDUR = (ADC Clock Cycles) - 2
    subi    r22, 2
    sbci    r23, 0

    ; Clamp to 0 (minimum possible value)
    brpl    1f
    clr     r22
    jmp    2f
  1:
    ; Clamp to 255 (maximum possible 8-bit value)
    tst     r23
    breq    2f
    ldi     r22, 255
  2:
    sts     ADC0_CTRLE, r22

  wait_busy:
    lds     r22, ADC0_STATUS
    sbrc    r22, ADC_ADCBUSY_bp                 ; Wait for ADCBUSY (bit 0)
    jmp    wait_busy
  POP_MANY XH, XL, r21, r20, r19, r18
ENDF HAL_ADC_SETUP

; Function: HAL_ADC_READ_POLLING
; Description: Performs a single conversion on the specified channel.
; Inputs:  r22 - ADC0_MUXPOS (Channel)
; Outputs: r25:r22 - 32-bit ADC Result or 16-bit ADC result
FUNC HAL_ADC_READ_POLLING
    sts     ADC0_MUXPOS, r22                    ; Select Channel
    sts     ADC0_COMMAND, r23                   ; Start Conversion
  0:
    lds     r22, ADC0_INTFLAGS
    sbrs    r22, ADC_RESRDY_bp                  ; Wait for SAMPCIF/RESRDY (bit 0)
    jmp    0b
    sts     ADC0_INTFLAGS, r22                  ; Clear flag
  #ifdef ADC0_RESULT3
    lds4    r22, ADC0_RESULT                    ; 32-bit Read Result
  #else
    lds2    r22, ADC0_RESULT                    ; 16-bit Read Result
  #endif
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
    call   MATH_MUL_S_16_32                        ; r25:r22 = (ADC_RES + Offset) * Slope (signed 32-bit)

    ; 4. Rounding: Add 2048 (4096/2) before dividing by 4096
    ldi4    r18, 2048
    add4    r22, r18                                ; r25:r22 += 2048

    ; 5. Divide by 4096 (Shift Right 12)
    ldi     r18, 12
    call   MATH_ASR_32                             ; r25:r22 /= 4096

    ; 6. Convert Kelvin to Celsius (K - 273)
    subi    r22, lo8(273)
    sbci    r23, hi8(273)                           ; r23:r22 = Temperature in Celsius

  POP_MANY r21, r20, r25, r24, r19, r18
ENDF HAL_ADC_GET_TEMPERATURE
