#define   BUF_SIZE, 64              ; 64 bytes
#define   BUF_MASK, (BUF_SIZE-1)    ; 0x3F for 64 bytes
#define   HAL_BUF_UART_SIZE, 64     ;

.section .bss
HAL_BUF_UART      .space (2 + HAL_BUF_UART_SIZE)
HAL_RB_STORAGE:   .space BUF_SIZE
HAL_RB_HEAD:      .space 1
HAL_RB_TAIL:      .space 1

DEFUN HAL_RB_INIT
  HAL_RB_INIT:
    sts   HAL_RB_HEAD, __zero_reg__
    sts   HAL_RB_TAIL, __zero_reg__
  ret
ENDF HAL_RB_INIT

DEFUN HAL_RB_IS_EMPTY         ; Return r18: 1 if empty, otherwise 0
  HAL_RB_IS_EMPTY:
  PUSH_MANY r16, r17
    lds   r16, HAL_RB_HEAD
    lds   r17, HAL_RB_TAIL
    cp    r16, r17
    breq  rb_is_empty
    ldi   r18, 0
    rjmp  rb_is_empty_exit
  rb_is_empty:
    ldi   r18, 1
  rb_is_empty_exit:
  POP_MANY r17, r16
  ret
ENDF HAL_RB_IS_EMPTY

DEFUN HAL_RB_IS_FULL          ; Return r18:1 if (head + 1) % size == tail
  HAL_RB_IS_FULL:
  PUSH_MANY r16, r17
    lds   r16, HAL_RB_HEAD
    lds   r17, HAL_RB_TAIL
    inc   r16
    andi  r16, BUF_MASK
    cp    r16, r17
    breq  rb_is_full
    ldi   r18, 0
    rjmp  rb_is_full_exit
  rb_is_full:
    ldi   r18, 1
  rb_is_full_exit:
  POP_MANY r17, r16
  ret
ENDF HAL_RB_IS_FULL

DEFUN HAL_RB_IN_USE           ; Return size in r18 = (head - tail) % size
  HAL_RB_IN_USE:
  PUSH_MANY r16, r17
    lds   r16, HAL_RB_HEAD
    lds   r17, HAL_RB_TAIL
    sub   r16, r17
    andi  r16, RING_MASK
    mov   r18, r16
  POP_MANY r17, r16
  ret
ENDF HAL_RB_IN_USE

DEFUN HAL_RB_PUSH             ; Value in r22, return r18: 0 success / 1 fail
  HAL_RB_PUSH:
    PUSH_MANY r16, r17, r30, r31
    rcall HAL_RB_IS_FULLL
    tst   r18                 ; if full (r18 != 0), fail
    brne  rpush_fail
    lds   r16, HAL_RB_HEAD
    ldi   r30, lo8( HAL_RB_STORAGE )
    ldi   r31, hi8( HAL_RB_STORAGE )
    add   r30, r16
    adc   r31, __zero_reg__
    st    Z, r22              ; store val at buffer[head]
    inc   r16
    andi  r16, RING_MASK
    sts   HAL_RB_HEAD, r16    ; head = (head + 1) % size
    ldi   r18, 0              ; success
    rjmp  rpush_end
  rpush_fail:
    ldi   r18, 1              ; fail
  rpush_end:
  POP_MANY r31, r30, r17, r16
  ret
ENDF HAL_RB_PUSH

DEFUN HAL_RB_PULL           ; Return value in r22, r18: 0 success / 1 fail
  HAL_RB_PULL:
  PUSH_MANY r18, r30, r31
    rcall HAL_RB_IS_EMPTY
    tst   r18               ; if empty (r18 != 0), fail
    brne  rpull_fail
    lds   r18, HAL_RB_TAIL
    ldi   r30, lo8( HAL_RB_STORAGE )
    ldi   r31, hi8( HAL_RB_STORAGE )
    add   r30, r18
    adc   r31, __zero_reg__
    ld    r22, Z            ; load byte from buffer[tail]
    inc   r18
    andi  r18, RING_MASK
    sts   HAL_RB_TAIL, r18  ; tail = (tail + 1) % size
    ldi   r18, 0            ; success
    rjmp  rpull_end
  rpull_fail:
    ldi   r18, 1            ; fail
  rpull_end:
  POP_MANY r31, r30, r18
  ret
ENDF HAL_RB_PULL
