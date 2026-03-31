; File: Hal/HAL_WDT.S
; Description: Watchdog Timer (WDT) helper library for modern AVR (Dx/Ex/EB).
;              Provides routines for enabling, disabling, and patting the WDT.

#define HAL_WDT_RESET  wdr

; Function: HAL_WDT_ENABLE
; Description: Enables the Watchdog Timer with a specific period.
;              Note: This writes to the CCP protected CTRLA register.
; Inputs:  r22 - WDT Period (e.g., WDT_PERIOD_8KCLK_gc)
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
