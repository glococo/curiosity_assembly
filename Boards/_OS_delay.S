DEFUN OS_SOFT_DELAY_MS                  ; Receives a 16bit millisecond number in r19:r18
  OS_SOFT_DELAY_MS:
  PUSH_MANY r18, r19, r20, r21

  outer_loop:
    lds   r20, ONE_MS               ; 3c
    lds   r21, ONE_MS+1             ; 3c
    rcall OS_SOFT_DELAY_1MS         ; 2c
    subi  r18, 1                    ; 1c
    sbci  r19, 0                    ; 1c
    brne  outer_loop                ; 2c/1c

  POP_MANY r21, r20, r19, r18
  ret
ENDF OS_SOFT_DELAY_MS

DEFUN OS_SOFT_DELAY_1MS             ; 1ms delay loop, ONE_MS*4c + ret.4c
  OS_SOFT_DELAY_1MS:
    subi r20, 1                     ; 1c
    sbci r21, 0                     ; 1c
    brne OS_SOFT_DELAY_1MS          ; 2c/1c
    ret                             ; 4c
ENDF OS_SOFT_DELAY_1MS
