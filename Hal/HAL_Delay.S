DEFUN HAL_SOFT_DELAY_MS         ; Receives a 16bit millisecond number in r19:r18
  HAL_SOFT_DELAY_MS:
  PUSH_MANY r24, r25

  outer_loop:
    lds   r24, HAL_ONE_MS       ; 3c
    lds   r25, HAL_ONE_MS+1     ; 3c

  inner_loop:
    sbiw  r24, 1                ; 2c
    brne inner_loop             ; 2c/1c

    subi  r18, 1                ; 1c
    sbci  r19, 0                ; 1c
    brne  outer_loop            ; 2c/1c

  POP_MANY r25, r24
  ret
ENDF HAL_SOFT_DELAY_MS
