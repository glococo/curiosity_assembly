; File: Hal/HAL_CORE.S
; Description: Core CPU and Clock Control functions.
;
; Example Usage:
;   ldi     r18, 2                      ; Set divisor to /4
;   rcall   HAL_CORE_PRESCALER          ; Apply prescaler and update timing constants

.section .bss
HAL_ONE_MS:                     .byte 0, 0
HAL_CORE_DIVISOR:               .byte 0

; Function: HAL_CORE_PRESCALER
; Description: Sets the CPU clock prescaler and updates the HAL_ONE_MS timing constant.
;              Divisor mapping (DS40002522A p102):
;              0: /1 (PEN=0)
;              1: /2 (PEN=1, PDIV=0)
;              2: /4 (PEN=1, PDIV=1)
;              3: /8 (PEN=1, PDIV=2)
;              4: /16 (PEN=1, PDIV=3)
;              5: /32 (PEN=1, PDIV=4)
;              6: /64 (PEN=1, PDIV=5)
; Inputs:  r18 - Clock divisor index (0-6)
; Outputs: None
FUNC HAL_CORE_PRESCALER
  PUSH_MANY r18, r22, r23
    sts     HAL_CORE_DIVISOR, r18       ; Store current divisor index
    tst     r18                         ; Check if divisor is 0 (/1)
    breq    write_divisor_register      ; If 0, PEN=0
    dec     r18                         ; Adjust for PDIV (PDIV = index - 1)
    lsl     r18                         ; Shift to PDIV position
    ori     r18, 1                      ; Set PEN bit (bit 0)

  write_divisor_register:
    ldi     r22, 0xD8                   ; Unlock CPU_CCP register (Configuration Change Protection)
    sts     CPU_CCP, r22                ; Write unlock key
    sts     CLKCTRL_MCLKCTRLB, r18      ; Update Main Clock Control B register

  update_one_ms:
    ; Update HAL_ONE_MS based on new frequency (BOARD_CLOCK_MAIN / 4 / 2^divisor)
    ldi     r22, lo8( BOARD_CLOCK_MAIN/4 )
    ldi     r23, hi8( BOARD_CLOCK_MAIN/4 )
    lds     r18, HAL_CORE_DIVISOR       ; Load divisor index
    rcall   MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18
    sts     HAL_ONE_MS, r22             ; Store One MS Low Byte
    sts     HAL_ONE_MS+1, r23           ; Store One MS High Byte

  POP_MANY r23, r22, r18
ENDF HAL_CORE_PRESCALER
