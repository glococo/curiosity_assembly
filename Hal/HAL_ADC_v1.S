; File: Hal/HAL_ADC_v1.S
; Description: Analog-to-Digital Converter (ADC) helper library for modern AVR.
;              Provides routines for initializing, reading, and configuring ADC.

#define _ADC_ENABLE( ... )            HAL_ADC_ENABLE __VA_ARGS__
#define _ADC_ENABLE_VDD()             HAL_ADC_ENABLE_VDD
#define _ADC_READ( ain )              HAL_ADC_READ ain
#define _ADC_BURST( ain, num )        HAL_ADC_BURST ain, num

.macro HAL_ADC_ENABLE_VDD
  #ifdef ADC_REFSEL_VDDREF_gc
    _ADC_ENABLE( ADC_PRESC_DIV16_gc, ADC_REFSEL_VDDREF_gc )
  #else
    _VREF_ADC0_CONFIG( VREF_REFSEL_VDD_gc )
    _ADC_ENABLE()
  #endif
.endm

.macro HAL_ADC_ENABLE prescaler=ADC_PRESC_DIV16_gc, vref=0
  #ifdef ADC_REFSEL_VDDREF_gc
    ldi     r16, \prescaler | \vref
  #else
    ldi     r16, \prescaler
  #endif
    sts     ADC0_CTRLC, r16             ; CTRLC (Prescaler)
    sts     ADC0_CTRLB, __zero_reg__    ; Sampnum reset
    ldi     r16, ADC_ENABLE_bm
    sts     ADC0_CTRLA, r16             ; CTRLA (Enable/FreeRun)
.endm

.macro HAL_ADC_READ ain=0
    ldi     r22, \ain
    ldi     r23, ADC_STCONV_bm
    call   HAL_ADC_READ_POLLING
.endm
.macro HAL_ADC_BURST ain, sampnum
    ldi     r22, \sampnum
    sts     ADC0_CTRLB, r22
    ldi     r22, \ain
    ldi     r23, ADC_STCONV_bm
    call   HAL_ADC_READ_POLLING
.endm

; Function: HAL_ADC_READ_POLLING
; Description: Performs a single conversion on the specified channel.
; Inputs:  r22 - ADC0_MUXPOS (Channel)
;          r23 - Start command
; Outputs: r23:r22 - 16-bit ADC Result
FUNC HAL_ADC_READ_POLLING
    sts     ADC0_MUXPOS, r22                    ; Select Channel
    sts     ADC0_COMMAND, r23                   ; Start Conversion
  0:
    lds     r22, ADC0_INTFLAGS
    sbrs    r22, ADC_RESRDY_bp                  ; Wait for SAMPCIF/RESRDY (bit 0)
    jmp    0b
    sts     ADC0_INTFLAGS, r22                  ; Clear flag
    lds2    r22, ADC0_RES                       ; Read Result
ENDF HAL_ADC_READ_POLLING

FUNC HAL_ADC_GET_TEMPERATURE
  PUSH_MANY r18, r19, r24, r25, r20, r21
    ; 1. Read calibration values (Slope and Offset are 16-bit)
    movw    r24, r22                                ; r25:r24 = ADC_RES
    lds2    r22, SIGROW_TEMPSENSE1                  ; r19:r18 = Offset (signed 16-bit)
    lds2    r18, SIGROW_TEMPSENSE0                  ; r21:r20 = Slope (unsigned 16-bit, but treat as signed for multiplication)

    ; 2. (Offset - ADC_RES)
    sub     r22, r24
    sbc     r23, r25                                ; r19:r18 = Offset - ADC_RES (signed 16-bit)

    ; 3. (Offset - ADC_RES) * Slope
    call   MATH_MUL_16_32                          ; r25:r22 = (Offset - ADC_RES) * Slope (signed 32-bit)

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

