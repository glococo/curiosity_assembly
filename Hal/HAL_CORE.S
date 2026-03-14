.section .bss
HAL_ONE_MS:                     .byte 0, 0
HAL_CORE_DIVISOR:               .byte 0

; Receives a new clock divisor (DS40002522A p102) in r16, 0: PEN=0 (prescaler
; disabled, div /1), 1: PEN=1, PDIV=0 (div /2), 2: PEN=1, PDIV=1 (div /4), ...
DEFUN HAL_CORE_PRESCALER
  HAL_CORE_PRESCALER:
  PUSH_MANY r18, r22, r23
    sts     HAL_CORE_DIVISOR, r18           ; Make sure r18 is never higher than 6 (/64 div)
    tst     r18
    breq    write_divisor_register
    dec     r18                         ; enable PEN and set PDIV
    lsl     r18
    ori     r18, 1

  write_divisor_register:
    ldi     r22, 0xD8                   ; Unlock CPU_CCP register
    sts     CPU_CCP, r22
    sts     CLKCTRL_MCLKCTRLB, r18

  update_one_ms:
    ldi     r22, lo8( BOARD_CLOCK_MAIN/4 )
    ldi     r23, hi8( BOARD_CLOCK_MAIN/4 )
    lds     r18, HAL_CORE_DIVISOR
    rcall   MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18 - Logical Shift Right - Result = Input >> Count
    sts     HAL_ONE_MS, r22
    sts     HAL_ONE_MS+1, r23

  POP_MANY r23, r22, r18
  ret
ENDF HAL_CORE_PRESCALER
