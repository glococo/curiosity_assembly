; File: Hal/HAL_WDT.S
; Description: Watchdog Timer (WDT) helper library for modern AVR (Dx/Ex/EB).
;              Provides routines for enabling, disabling, and patting the WDT.

#define WDT_PERIOD_OFF_bm      0x00
#define WDT_PERIOD_8CLK_bm     0x01
#define WDT_PERIOD_16CLK_bm    0x02
#define WDT_PERIOD_32CLK_bm    0x03
#define WDT_PERIOD_64CLK_bm    0x04
#define WDT_PERIOD_128CLK_bm   0x05
#define WDT_PERIOD_256CLK_bm   0x06
#define WDT_PERIOD_512CLK_bm   0x07
#define WDT_PERIOD_1KCLK_bm    0x08
#define WDT_PERIOD_2KCLK_bm    0x09
#define WDT_PERIOD_4KCLK_bm    0x0A
#define WDT_PERIOD_8KCLK_bm    0x0B
#define WDT_PERIOD_16KCLK_bm   0x0C
#define WDT_PERIOD_32KCLK_bm   0x0D
#define WDT_PERIOD_64KCLK_bm   0x0E
#define WDT_PERIOD_128KCLK_bm  0x0F

; Function: HAL_WDT_ENABLE
; Description: Enables the Watchdog Timer with a specific period.
;              Note: This writes to the CCP protected CTRLA register.
; Inputs:  r22 - WDT Period (e.g., WDT_PERIOD_1KCLK_bm)
; Outputs: None
FUNC HAL_WDT_ENABLE
  PUSH r18
  0:
    lds     r18, WDT_STATUS
    sbrc    r18, WDT_SYNCBUSY_bp        ; Wait for sync
    rjmp    0b

    ldi     r18, 0xD8                   ; CCP IOREG signature
    out     CPU_CCP, r18
    sts     WDT_CTRLA, r22
  POP r18
ENDF HAL_WDT_ENABLE

; Function: HAL_WDT_DISABLE
; Description: Disables the Watchdog Timer.
; Inputs:  None
; Outputs: None
FUNC HAL_WDT_DISABLE
  PUSH r18
  0:
    lds     r18, WDT_STATUS
    sbrc    r18, WDT_SYNCBUSY_bp
    rjmp    0b

    ldi     r18, 0xD8
    out     CPU_CCP, r18
    ldi     r18, WDT_PERIOD_OFF_bm
    sts     WDT_CTRLA, r18
  POP r18
ENDF HAL_WDT_DISABLE

; Function: HAL_WDT_RESET
; Description: Resets (pats) the Watchdog Timer.
; Inputs:  None
; Outputs: None
FUNC HAL_WDT_RESET
    wdr
ENDF HAL_WDT_RESET
