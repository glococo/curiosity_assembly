.macro HAL_DELAY_MS milliseconds
  PUSH_MANY r22, r23
  ldi   r22, lo8( \milliseconds )
  ldi   r23, hi8( \milliseconds )
  rcall HAL_SOFT_DELAY_MS
  POP_MANY  r23, r22
.endm

DEFUN HAL_SOFT_DELAY_MS         ; Receives a 16bit millisecond number in r23:r22
  HAL_SOFT_DELAY_MS:
  PUSH_MANY r24, r25

  outer_loop:
    lds   r24, HAL_ONE_MS       ; 3c
    lds   r25, HAL_ONE_MS+1     ; 3c

  inner_loop:
    sbiw  r24, 1                ; 2c
    brne inner_loop             ; 2c/1c

    subi  r22, 1                ; 1c
    sbci  r23, 0                ; 1c
    brne  outer_loop            ; 2c/1c

  POP_MANY r25, r24
  ret
ENDF HAL_SOFT_DELAY_MS
