; File: Hal/HAL_BOD.S
; Description: Brown-out Detector (BOD) helper library for modern AVR (Dx/Ex/EB).
;              Provides routines for enabling/disabling BOD and VLM.

#define BOD_ACTIVE_DISABLED_bm (0x00<<0)
#define BOD_ACTIVE_ENABLED_bm  (0x01<<0)
#define BOD_ACTIVE_SAMPLED_bm  (0x02<<0)
#define BOD_SLEEP_DISABLED_bm  (0x00<<2)
#define BOD_SLEEP_ENABLED_bm   (0x01<<2)
#define BOD_SLEEP_SAMPLED_bm   (0x02<<2)
#define BOD_LVL_1_75V_bm       (0x00)
#define BOD_LVL_1_90V_bm       (0x01)
#define BOD_LVL_2_60V_bm       (0x02)
#define BOD_LVL_4_30V_bm       (0x03)
#define VLM_VLMLVL_5_bm        (0x00)
#define VLM_VLMLVL_15_bm       (0x01)
#define VLM_VLMLVL_25_bm       (0x02)

; Function: HAL_BOD_CONFIG
; Description: Configures the Brown-out Detector.
;              Note: This writes to CCP protected registers.
; Inputs:  r22 - BOD CTRLA (Mode) e.g., (BOD_ACTIVE_ENABLED_bm | BOD_SLEEP_DISABLED_bm)
;          r23 - BOD CTRLB (Level) e.g., BOD_LVL_2_60V_bm
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

; Function: HAL_BOD_GET_STATUS
; Description: Returns the BOD and VLM status.
; Inputs:  None
; Outputs: r24 - BOD_STATUS register
FUNC HAL_BOD_GET_STATUS
    lds     r24, BOD_STATUS
ENDF HAL_BOD_GET_STATUS
