; File: Hal/HAL_BOD.S
; Description: Brown-out Detector (BOD) helper library for modern AVR (Dx/Ex).
;              Provides routines for enabling/disabling BOD and VLM.

; Function: HAL_BOD_CONFIG
; Description: Configures the Brown-out Detector.
;              Note: This writes to CCP protected registers.
; Inputs:  r22 - BOD CTRLA (Mode) e.g., (BOD_ACTIVE_ENABLED_gc | BOD_SLEEP_DISABLE_gc)
;          r23 - BOD CTRLB (Level) e.g., BOD_LVL_BODLEVEL3_gc
; Outputs: None
FUNC HAL_BOD_CONFIG
  PUSH r18
    ldi     r18, 0xD8                   ; CCP IOREG signature
    out     CPU_CCP, r18
    sts     BOD_CTRLA, r22
    ldi     r18, 0xD8
    out     CPU_CCP, r18
    sts     BOD_CTRLB, r23
  POP r18
ENDF HAL_BOD_CONFIG

; Function: HAL_BOD_VLM_CONFIG
; Description: Configures the Voltage Level Monitor (VLM).
; Inputs:  r22 - VLM Level (VLMCTRLA)
;          r23 - VLM Interrupt Control (INTCTRL)
; Outputs: None
FUNC HAL_BOD_VLM_CONFIG
    sts     BOD_VLMCTRLA, r22
    sts     BOD_INTCTRL, r23
ENDF HAL_BOD_VLM_CONFIG
