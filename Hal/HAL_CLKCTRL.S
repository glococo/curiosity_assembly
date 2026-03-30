; File: Hal/HAL_CLKCTRL.S
; Description: Clock Control (CLKCTRL) driver for modern AVR (Dx/Ex).
;              Provides routines for source selection, prescaling, and frequency adjustment.
;
; Example Usage:
;   ldi     r22, HAL_CLKCTRL_FREQ_20MHZ
;   rcall   HAL_CLKCTRL_OSCHF_SET       ; Set Internal High Frequency Oscillator
;
;   ldi     r22, HAL_CLKCTRL_DIV_4
;   rcall   HAL_CLKCTRL_PRESCALER       ; Apply /4 prescaler and update timing
;
;   ldi     r22, HAL_CLKCTRL_SRC_OSCHF
;   rcall   HAL_CLKCTRL_MAIN_SELECT     ; Switch to OSCHF as main clock

; Constants for OSCHF Frequency Selection (OSCHFCTRLA.FRQSEL)
.set HAL_CLKCTRL_FREQ_1MHZ,   0x00
.set HAL_CLKCTRL_FREQ_2MHZ,   0x01<<2
.set HAL_CLKCTRL_FREQ_3MHZ,   0x02<<2
.set HAL_CLKCTRL_FREQ_4MHZ,   0x03<<2
.set HAL_CLKCTRL_FREQ_8MHZ,   0x05<<2
.set HAL_CLKCTRL_FREQ_12MHZ,  0x06<<2
.set HAL_CLKCTRL_FREQ_16MHZ,  0x07<<2
.set HAL_CLKCTRL_FREQ_20MHZ,  0x08<<2
.set HAL_CLKCTRL_FREQ_24MHZ,  0x09<<2

; Constants for Main Clock Selection (MCLKCTRLA.CLKSEL)
.set HAL_CLKCTRL_SRC_OSCHF,   0x00
.set HAL_CLKCTRL_SRC_OSC32K,  0x01
.set HAL_CLKCTRL_SRC_XOSC32K, 0x02
.set HAL_CLKCTRL_SRC_EXTCLK,  0x03
.set HAL_CLKCTRL_SRC_PLL,     0x04

; Constants for PLL Configuration (PLLCTRLA)
.set HAL_CLKCTRL_PLL_MUL_0,      0x00
.set HAL_CLKCTRL_PLL_MUL_4,      0x01
.set HAL_CLKCTRL_PLL_MUL_8,      0x02
.set HAL_CLKCTRL_PLL_MUL_16,     0x03
.set HAL_CLKCTRL_PLL_SRC_OSCHF,  0x00
.set HAL_CLKCTRL_PLL_SRC_EXTCLK, 0x01
.set HAL_CLKCTRL_PLL_DIV_0,      0x00<<3
.set HAL_CLKCTRL_PLL_DIV_2,      0x01<<3
.set HAL_CLKCTRL_PLL_DIV_4,      0x02<<3
.set HAL_CLKCTRL_PLL_DIV_6,      0x03<<3

.section .bss
HAL_ONE_MS:                 .word 0       ; 16-bit One millisecond in cycles
HAL_ONE_MS_DELAY:           .word 0       ; 16-bit One millisecond in cycles for hal_delay.S
HAL_CLK_MAIN_KHZ:           .long 0       ; 32-bit MAIN Clock Source
HAL_CLK_MAIN_DIV:           .byte 0       ;  8-bit Current CPU clock divisor

; Function: HAL_CLKCTRL_MAIN_SELECT
; Description: Selects the main clock source.
; Inputs:  r22 - CLKSEL index (e.g., HAL_CLKCTRL_SRC_OSCHF)
; Outputs: None
FUNC HAL_CLKCTRL_MAIN_SELECT
    ldi     r18, 0xD8                   ; CCP unlock key
    out     CPU_CCP, r18
    sts     CLKCTRL_MCLKCTRLA, r22
  0:
    lds     r18, CLKCTRL_MCLKSTATUS
    sbrc    r18, 0                      ; SOSC is bit 5 in MCLKSTATUS
    rjmp    0b
ENDF HAL_CLKCTRL_MAIN_SELECT

; Function: HAL_CLKCTRL_PLL_SET
; Description: Configures the Phase-Locked Loop (PLL).
; Inputs:  r22 - PLLCTRLA value, e.g. (HAL_CLKCTRL_PLL_DIV_2 | HAL_CLKCTRL_PLL_MUL_8)
; Outputs: None
FUNC HAL_CLKCTRL_PLL_SET
  PUSH r18
    ldi     r18, 0xD8                   ; CCP unlock key
    out     CPU_CCP, r18
    sts     CLKCTRL_PLLCTRLA, r22
  POP r18
ENDF HAL_CLKCTRL_PLL_SET

; Function: HAL_CLKCTRL_PRESCALER
; Description: Sets the CPU clock prescaler and updates timing constants.
;              Automatically calculates bitmask for MCLKCTRLB.
; Inputs:  r22 - Divisor index
; Outputs: None
FUNC HAL_CLKCTRL_PRESCALER
  PUSH_MANY r18, r19, r23, r24, r25
    sts     HAL_CLK_MAIN_DIV, r22       ; Save raw register value
    tst     r22
    breq    write_reg

    dec     r22                         ; index 1 -> PDIV 0
    lsl     r22                         ; Shift to PDIV position
    ori     r22, 0x01                   ; Set PEN
  write_reg:
    ldi     r18, 0xD8
    out     CPU_CCP, r18
    sts     CLKCTRL_MCLKCTRLB, r22

  update_one_ms:
    lds     r18, HAL_CLK_MAIN_DIV   ; Load divisor index
    lds4    r22, HAL_CLK_MAIN_KHZ

    rcall   MATH_LSR_32                 ; r25:r22 = r25:r22 >> r18
    stsw    HAL_ONE_MS, r22             ; Store One MS
  update_one_ms_for_delay:
    ldi     r18, 2
    rcall   MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18
    stsw    HAL_ONE_MS_DELAY, r22
  update_one_us:
    ldiw    r18, 1000
    ldsw    r22, HAL_ONE_MS
    rcall   MATH_UDIV_16                ; r23:r22 /= r19:r18
    ldiw    r24, 500                    ; Check remainder for rounding
    cpw      r18, r24
    brcs    _update_one_us_done
    inc     r22
  _update_one_us_done:
    andi    r22, 0x1F                   ; MCLKTIMEBASE is 5-bit (0-31)
    sts     CLKCTRL_MCLKTIMEBASE, r22
  POP_MANY r25, r24, r23, r19, r18
ENDF HAL_CLKCTRL_PRESCALER
