; ==============================================================================
; PRINT functions
; These functions send characters to X/Z-Pointer Buffer
; ==============================================================================

.macro PRINT_STR str:vararg
    .pushsection .progmem.rodata
    str_\@: .asciz \str
    .popsection
    PRINT_STR_X str_\@
.endm

.macro PRINT_STR_X ascii_str
    ldi     XL, lo8( MAPPED_PROGMEM_START + (\ascii_str) )
    ldi     XH, hi8( MAPPED_PROGMEM_START + (\ascii_str) )
    rcall   HAL_PRINT_STR
.endm

; Push "\r\n" to Dev-Buffer
FUNC HAL_PRINT_NEW_LINE
  PUSH r22
    ldi   r22, '\n'
    rcall HAL_DEVICEBUFFER_PUSH
    ldi   r22, '\r'
    rcall HAL_DEVICEBUFFER_PUSH
  POP r22
ENDF HAL_PRINT_NEW_LINE

; Function: HAL_PRINT_STR
; Description: Pushes a null-terminated string into the Dev-buffer.
; Input:  Z - Points to Buffer Structure.
;         X - Points to Memory string (.asciz).
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_PRINT_STR
  PUSH  r22
  0:
    ld      r22, X+
    tst     r22
    breq    1f                  ; Found null terminator
    rcall   HAL_DEVICEBUFFER_PUSH
    tst     r18
    breq    0b                  ; Continue if push succeeded
  1:                            ; If full, r18 is already 1
  POP  r22
ENDF HAL_PRINT_STR

; ==============================================================================
; Register-Based Decimal Printing (Unsigned)
; ==============================================================================
; Inputs: Value in r25:18 (64-bits), r25:r22 (32-bit), r23:r22 (16-bit), r22 (8-bit)
; Callee-Saved: All used Registers preserved

FUNC HAL_PRINT_UINT8_REG
    PUSH_MANY r14, r18, r22
    clr   r14                   ; Digit count
  1:
    ldi   r18, 10
    rcall MATH_UDIV_08_08       ; r22 /= 10, rem in r18
    subi  r18, -'0'
    push  r18
    inc   r14
    tst   r22
    brne  1b
  2:                            ; Print loop (MSD first)
    pop   r22
    rcall HAL_DEVICEBUFFER_PUSH
    dec   r14
    brne  2b
  POP_MANY r22, r18, r14
ENDF HAL_PRINT_UINT8_REG

FUNC HAL_PRINT_UINT16_REG
    PUSH_MANY r14, r16, r18, r19, r22, r23
    clr   r14
  1:
    ldi   r18, 10
    clr   r19
    rcall MATH_UDIV_16_16       ; r23:r22 /= 10, rem in r18
    subi  r18, -'0'
    push  r18
    inc   r14
    mov   r16, r22
    or    r16, r23
    brne  1b
  2:                            ; Print loop (MSD first)
    pop   r22
    rcall HAL_DEVICEBUFFER_PUSH
    dec   r14
    brne  2b
  POP_MANY r23, r22, r19, r18, r16, r14
ENDF HAL_PRINT_UINT16_REG

FUNC HAL_PRINT_UINT32_REG
    PUSH_MANY r14, r16, r18, r19, r20, r21, r22, r23, r24, r25
    clr   r14
  1:
    ldi   r18, 10
    clr   r19 $ clr r20 $ clr r21
    rcall MATH_UDIV_32_32       ; r25:r22 /= 10, rem in r18
    subi  r18, -'0'
    push  r18
    inc   r14
    mov   r16, r22 $ or r16, r23 $ or r16, r24 $ or r16, r25
    brne  1b
  2:                            ; Print loop (MSD first)
    pop   r22
    rcall HAL_DEVICEBUFFER_PUSH
    dec   r14
    brne  2b
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18, r16, r14
ENDF HAL_PRINT_UINT32_REG

FUNC HAL_PRINT_UINT64_REG
    PUSH_MANY r14, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25
    clr   r14
  1:
    clr   r16                   ; Remainder accumulator
    ldi   r17, 64               ; 64 bits
  2:
    lsl   r18 $ rol r19 $ rol r20 $ rol r21
    rol   r22 $ rol r23 $ rol r24 $ rol r25
    rol   r16
    cpi   r16, 10
    brcs  3f
    subi  r16, 10
    ori   r18, 1
  3:
    dec   r17
    brne  2b

    subi  r16, -'0'
    push  r16
    inc   r14
    ; Check if quotient is zero
    mov   r16, r18 $ or r16, r19 $ or r16, r20 $ or r16, r21
    or    r16, r22 $ or r16, r23 $ or r16, r24 $ or r16, r25
    brne  1b
  2:                            ; Print loop (MSD first)
    pop   r22
    rcall HAL_DEVICEBUFFER_PUSH
    dec   r14
    brne  2b
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18, r17, r16, r14
ENDF HAL_PRINT_UINT64_REG

; ==============================================================================
; Register-Based Decimal Printing (Signed)
; ==============================================================================

FUNC HAL_PRINT_INT8_REG
    sbrs  r22, 7
    rjmp  HAL_PRINT_UINT8_REG
    PUSH  r22
    ldi   r22, '-'
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    neg   r22
    rjmp  HAL_PRINT_UINT8_REG
ENDF HAL_PRINT_INT8_REG

FUNC HAL_PRINT_INT16_REG
    sbrs  r23, 7
    rjmp  HAL_PRINT_UINT16_REG
    PUSH  r22
    ldi   r22, '-'
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    com   r23
    neg   r22
    sbci  r23, -1
    rjmp  HAL_PRINT_UINT16_REG
ENDF HAL_PRINT_INT16_REG

FUNC HAL_PRINT_INT32_REG
    sbrs  r25, 7
    rjmp  HAL_PRINT_UINT32_REG
    PUSH  r22
    ldi   r22, '-'
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    com   r25 $ com r24 $ com r23
    neg   r22
    sbci  r23, -1 $ sbci r24, -1 $ sbci r25, -1
    rjmp  HAL_PRINT_UINT32_REG
ENDF HAL_PRINT_INT32_REG

FUNC HAL_PRINT_INT64_REG
    sbrs  r25, 7
    rjmp  HAL_PRINT_UINT64_REG
    PUSH  r22
    ldi   r22, '-'
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    com r25 $ com r24 $ com r23 $ com r22 $ com r21 $ com r20 $ com r19
    neg r18
    sbci r19, -1 $ sbci r20, -1 $ sbci r21, -1 $ sbci r22, -1
    sbci r23, -1 $ sbci r24, -1 $ sbci r25, -1
    rjmp  HAL_PRINT_UINT64_REG
ENDF HAL_PRINT_INT64_REG
