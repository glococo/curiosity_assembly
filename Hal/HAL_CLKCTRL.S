; File: Hal/HAL_CLKCTRL.S
; Description: Clock Control (CLKCTRL) driver for modern AVR (Dx/Ex).
;              Provides routines for source selection, prescaling, and frequency adjustment.
;

.section .bss
HAL_ONE_MS:                 .word 0       ; 16-bit One millisecond in cycles
HAL_ONE_MS_DELAY:           .word 0       ; 16-bit One millisecond in cycles for hal_delay.S
HAL_CLK_MAIN_KHZ:           .long 0       ; 32-bit MAIN Clock Source
HAL_CLK_MAIN_DIV:           .byte 0       ;  8-bit Current CPU clock divisor

; Function: HAL_CLKCTRL_OSCHF_SET
; Description: Selects the main clock source.
; Inputs:  r22 - FREQ index (e.g., CLKCTRL_FRQSEL_24M_gc)
; Outputs: None
FUNC HAL_CLKCTRL_OSCHF_SET
    ldi     r18, 0xD8                   ; CCP unlock key
    out     CPU_CCP, r18
    sts     CLKCTRL_OSCHFCTRLA, r22
  0:
    lds     r18, CLKCTRL_MCLKSTATUS
    sbrc    r18, 0                      ; SOSC is bit 5 in MCLKSTATUS
    rjmp    0b
ENDF HAL_CLKCTRL_OSCHF_SET

; Function: HAL_CLKCTRL_MAIN_SELECT
; Description: Selects the main clock source.
; Inputs:  r22 - CLKSEL index (e.g., CLKCTRL_CLKSEL_PLL_gc)
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
; Inputs:  r22 - PLLCTRLA value, e.g. (CLKCTRL_SOURCEDIV_DIV1_gc | CLKCTRL_MULFAC_8X_gc)
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
    sts2    HAL_ONE_MS, r22             ; Store One MS
  update_one_ms_for_delay:
    ldi     r18, 2
    rcall   MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18
    sts2    HAL_ONE_MS_DELAY, r22
  update_one_us:
    ldi2    r18, 1000
    lds2    r22, HAL_ONE_MS
    rcall   MATH_UDIV_16                ; r23:r22 /= r19:r18
    ldi2    r24, 500                    ; Check remainder for rounding
    cp2      r18, r24
    brcs    _update_one_us_done
    inc     r22
  _update_one_us_done:
#ifdef CLKCTRL_MCLKTIMEBASE
    andi    r22, 0x1F                   ; MCLKTIMEBASE is 5-bit (0-31)
    sts     CLKCTRL_MCLKTIMEBASE, r22
#endif
  POP_MANY r25, r24, r23, r19, r18
ENDF HAL_CLKCTRL_PRESCALER
