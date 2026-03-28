; File: Hal/HAL_ADC.S
; Description: Analog-to-Digital Converter (ADC) helper library for modern AVR (Dx/Ex).
;              Provides routines for initializing, reading, and configuring ADC.

#define ADC_RESSEL_12BIT_bm    (0x00<<3)
#define ADC_RESSEL_10BIT_bm    (0x01<<3)

#define ADC_REFSEL_VDD_bm     (0x00<<0)
#define ADC_REFSEL_VREFA_bm   (0x02<<0)
#define ADC_REFSEL_1V024_bm   (0x04<<0)
#define ADC_REFSEL_2V048_bm   (0x05<<0)
#define ADC_REFSEL_4V096_bm   (0x06<<0)
#define ADC_REFSEL_2V500_bm   (0x07<<0)

#define ADC_PRESC_DIV2_bm      (0x00)
#define ADC_PRESC_DIV4_bm      (0x01)
#define ADC_PRESC_DIV6_bm      (0x02)
#define ADC_PRESC_DIV8_bm      (0x03)
#define ADC_PRESC_DIV10_bm     (0x04)
#define ADC_PRESC_DIV12_bm     (0x05)
#define ADC_PRESC_DIV14_bm     (0x06)
#define ADC_PRESC_DIV16_bm     (0x07)
#define ADC_PRESC_DIV20_bm     (0x08)
#define ADC_PRESC_DIV24_bm     (0x09)
#define ADC_PRESC_DIV28_bm     (0x0A)
#define ADC_PRESC_DIV32_bm     (0x0B)
#define ADC_PRESC_DIV40_bm     (0x0C)
#define ADC_PRESC_DIV48_bm     (0x0D)
#define ADC_PRESC_DIV56_bm     (0x0E)
#define ADC_PRESC_DIV64_bm     (0x0F)

#define ADC_SAMPNUM_NONE_bm       (0x00)
#define ADC_SAMPNUM_ACC2_bm       (0x01)
#define ADC_SAMPNUM_ACC4_bm       (0x02)
#define ADC_SAMPNUM_ACC8_bm       (0x03)
#define ADC_SAMPNUM_ACC16_bm      (0x04)
#define ADC_SAMPNUM_ACC32_bm      (0x05)
#define ADC_SAMPNUM_ACC64_bm      (0x06)
#define ADC_SAMPNUM_ACC128_bm     (0x07)
#define ADC_SAMPNUM_ACC256_bm     (0x08)
#define ADC_SAMPNUM_ACC512_bm     (0x09)
#define ADC_SAMPNUM_ACC1024_bm    (0x0A)

#define ADC_MODE_SINGLE_8bit_bm     (0x00)
#define ADC_MODE_SINGLE_12bit_bm    (0x10)
#define ADC_MODE_SERIES_bm          (0x20)
#define ADC_MODE_SERIES_SCALING_bm  (0x30)
#define ADC_MODE_BURST_bm           (0x40)
#define ADC_MODE_BURST_SCALING_bm   (0x50)


; Function: HAL_ADC_INIT
; Description: Initializes the ADC.
; Inputs:  r22 - CTRLC (Reference and Prescaler)
;          r23 - CTRLA (Resolution and Enable)
; Outputs: None
FUNC HAL_ADC_INIT
    sts     ADC0_CTRLC, r22
    sts     ADC0_CTRLA, r23
ENDF HAL_ADC_INIT

; Function: HAL_ADC_VREF_SET
; Description: Configures the internal voltage reference.
; Inputs:  r22 - ADC_REFSEL_bm (e.g., ADC_REFSEL_1V024_bm)
; Outputs: None
FUNC HAL_ADC_VREF_SET
    sts     ADC0_CTRLC, r22
ENDF HAL_ADC_VREF_SET

; Function: HAL_ADC_POLL_READ
; Description: Performs a single conversion on the specified channel.
; Inputs:  r22 - ADC0_MUXPOS (Channel)
; Outputs: r23:r22 - 16-bit ADC Result
FUNC HAL_ADC_POLL_READ
    sts     ADC0_MUXPOS, r22            ; Select Channel
    ldi     r22, ADC_START_0_bm
    sts     ADC0_COMMAND, r22           ; Start Conversion
  0:
    lds     r22, ADC0_INTFLAGS
    sbrs    r22, 0                      ; Wait for SAMPCIF/RESRDY (bit 0 usually)
    rjmp    0b
    sts     ADC0_INTFLAGS, r22          ; Clear flag
    ldsw    r22, ADC0_RESULT0           ; Read Result
ENDF HAL_ADC_POLL_READ
