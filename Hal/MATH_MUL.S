; MATH_MADD: Multiply-Add with Carry Propagation
; @param off: Starting register index for the result (e.g., 18 for r18)
; @param a, b: Registers to multiply
; @param limit: Highest register index to propagate carry to (e.g., 25 for r25)
.macro MATH_MADD off, a, b, limit
    mul     \a, \b
    add     \off, r0
    .if \limit >= \off + 1
        adc     (\off+1), r1
    .endif
    .if \limit >= \off + 2
        adc (\off+2), __zero_reg__
    .endif
    .if \limit >= \off + 3
        adc (\off+3), __zero_reg__
    .endif
    .if \limit >= \off + 4
        adc (\off+4), __zero_reg__
    .endif
    .if \limit >= \off + 5
        adc (\off+5), __zero_reg__
    .endif
    .if \limit >= \off + 6
        adc (\off+6), __zero_reg__
    .endif
    .if \limit >= \off + 7
        adc (\off+7), __zero_reg__
    .endif
.endm

; Helper macro for signed adjustment of multiplication results
; If sign_reg < 0, subtract val_regs from res_regs
.macro MATH_SIGN_ADJUST sign_reg, res_start, val_start, count, limit
    tst     \sign_reg
    brpl    .L_done_\@
    sub     \res_start, \val_start
    .set _i, 1
    .rept \count - 1
        sbc \res_start + _i, \val_start + _i
        .set _i, _i + 1
    .endr
    ; Propagate carry
    .rept \limit - (\res_start + \count - 1)
        sbc \res_start + _i, __zero_reg__
        .set _i, _i + 1
    .endr
.L_done_\@:
.endm

; Alias for same-size products where signed/unsigned are identical
#define MATH_MUL_S_64_64  MATH_MUL_64_64
#define MATH_MUL_SU_64_64 MATH_MUL_64_64
; --- 64-bit (Double Precision) ---
; MATH_MUL_64_64    ; r25:r18 *= r17:r10 - Product is 64-bit
DEFUN MATH_MUL_64_64
  MATH_MUL_64_64:
    PUSH_MANY r4, r5, r6, r7, r8, r9, r26, r27
    ; Save initial r25:r18 into r9:r4 and r27:r26
    MOVW_BLOCK r4, r18, 3    ; r4-r9 = r18-r23
    movw r26, r24            ; r26-r27 = r24-r25
    ; Clear r25:r18 for accumulation
    CLR_BLOCK r18, 8

    ; Offset 0
    MATH_MADD 18, r4, r10, 25
    ; Offset 1
    MATH_MADD 19, r5, r10, 25
    MATH_MADD 19, r4, r11, 25
    ; Offset 2
    MATH_MADD 20, r6, r10, 25
    MATH_MADD 20, r5, r11, 25
    MATH_MADD 20, r4, r12, 25
    ; Offset 3
    MATH_MADD 21, r7, r10, 25
    MATH_MADD 21, r6, r11, 25
    MATH_MADD 21, r5, r12, 25
    MATH_MADD 21, r4, r13, 25
    ; Offset 4
    MATH_MADD 22, r8, r10, 25
    MATH_MADD 22, r7, r11, 25
    MATH_MADD 22, r6, r12, 25
    MATH_MADD 22, r5, r13, 25
    MATH_MADD 22, r4, r14, 25
    ; Offset 5
    MATH_MADD 23, r9, r10, 25
    MATH_MADD 23, r8, r11, 25
    MATH_MADD 23, r7, r12, 25
    MATH_MADD 23, r6, r13, 25
    MATH_MADD 23, r5, r14, 25
    MATH_MADD 23, r4, r15, 25
    ; Offset 6
    MATH_MADD 24, r26, r10, 25
    MATH_MADD 24, r9, r11, 25
    MATH_MADD 24, r8, r12, 25
    MATH_MADD 24, r7, r13, 25
    MATH_MADD 24, r6, r14, 25
    MATH_MADD 24, r5, r15, 25
    MATH_MADD 24, r4, r16, 25
    ; Offset 7
    MATH_MADD 25, r27, r10, 25
    MATH_MADD 25, r26, r11, 25
    MATH_MADD 25, r9, r12, 25
    MATH_MADD 25, r8, r13, 25
    MATH_MADD 25, r7, r14, 25
    MATH_MADD 25, r6, r15, 25
    MATH_MADD 25, r5, r16, 25
    MATH_MADD 25, r4, r17, 25

    POP_MANY r27, r26, r9, r8, r7, r6, r5, r4
    ret
ENDF MATH_MUL_64_64

DEFUN MATH_MAC_32_64        ; r25:r18 += r29:r26 * r13:r10
  MATH_MAC_32_64:
    ; Offset 0
    MATH_MADD 18, r10, r26, 25
    ; Offset 1
    MATH_MADD 19, r11, r26, 25
    MATH_MADD 19, r10, r27, 25
    ; Offset 2
    MATH_MADD 20, r12, r26, 25
    MATH_MADD 20, r11, r27, 25
    MATH_MADD 20, r10, r28, 25
    ; Offset 3
    MATH_MADD 21, r13, r26, 25
    MATH_MADD 21, r12, r27, 25
    MATH_MADD 21, r11, r28, 25
    MATH_MADD 21, r10, r29, 25
    ; Offset 4
    MATH_MADD 22, r13, r27, 25
    MATH_MADD 22, r12, r28, 25
    MATH_MADD 22, r11, r29, 25
    ; Offset 5
    MATH_MADD 23, r13, r28, 25
    MATH_MADD 23, r12, r29, 25
    ; Offset 6
    MATH_MADD 24, r13, r29, 25
    ret
ENDF MATH_MAC_32_64

DEFUN MATH_MAC_SU_32_64     ; r25:r18 += r29:r26 (S) * r13:r10 (U)
  MATH_MAC_SU_32_64:
    rcall   MATH_MAC_32_64
    ; Adjustment: if A < 0, res_high -= B
    MATH_SIGN_ADJUST r29, 22, 10, 4, 25
    ret
ENDF MATH_MAC_SU_32_64

DEFUN MATH_MAC_S_32_64      ; r25:r18 += r29:r26 (S) * r13:r10 (S)
  MATH_MAC_S_32_64:
    rcall   MATH_MAC_32_64
    ; Adjustment: if A < 0, res_high -= B; if B < 0, res_high -= A
    MATH_SIGN_ADJUST r29, 22, 10, 4, 25
    MATH_SIGN_ADJUST r13, 22, 26, 4, 25
    ret
ENDF MATH_MAC_S_32_64

DEFUN MATH_MUL_32_64        ; r25:r18 = r25:r22 * r21:r18
  MATH_MUL_32_64:
    PUSH_MANY r10, r11, r12, r13, r26, r27, r28, r29
    MOVW_BLOCK r26, r18, 2
    MOVW_BLOCK r10, r22, 2
    CLR_BLOCK r18, 8
    rcall   MATH_MAC_32_64
    POP_MANY r29, r28, r27, r26, r13, r12, r11, r10
  ret
ENDF MATH_MUL_32_64

DEFUN MATH_MUL_SU_32_64     ; r25:r18 = r25:r22 (S) * r21:r18 (U)
  MATH_MUL_SU_32_64:
    PUSH_MANY r10, r11, r12, r13, r26, r27, r28, r29
    MOVW_BLOCK r26, r18, 2   ; B (U)
    MOVW_BLOCK r10, r22, 2   ; A (S)
    CLR_BLOCK r18, 8
    rcall   MATH_MAC_SU_32_64
    POP_MANY r29, r28, r27, r26, r13, r12, r11, r10
  ret
ENDF MATH_MUL_SU_32_64

DEFUN MATH_MUL_S_32_64      ; r25:r18 = r25:r22 (S) * r21:r18 (S)
  MATH_MUL_S_32_64:
    PUSH_MANY r10, r11, r12, r13, r26, r27, r28, r29
    MOVW_BLOCK r26, r18, 2   ; B (S)
    MOVW_BLOCK r10, r22, 2   ; A (S)
    CLR_BLOCK r18, 8
    rcall   MATH_MAC_S_32_64
    POP_MANY r29, r28, r27, r26, r13, r12, r11, r10
  ret
ENDF MATH_MUL_S_32_64

DEFUN MATH_MUL_32_32        ; r25:r22 *= r21:r18
  MATH_MUL_32_32:
    PUSH_MANY r26, r27, r28, r29
    MOVW_BLOCK r26, r22, 2
    CLR_BLOCK r22, 4
    ; Partial products capped at r25
    MATH_MADD 22, r26, r18, 25
    MATH_MADD 23, r27, r18, 25
    MATH_MADD 23, r26, r19, 25
    MATH_MADD 24, r28, r18, 25
    MATH_MADD 24, r27, r19, 25
    MATH_MADD 24, r26, r20, 25
    MATH_MADD 25, r29, r18, 25
    MATH_MADD 25, r28, r19, 25
    MATH_MADD 25, r27, r20, 25
    MATH_MADD 25, r26, r21, 25
    POP_MANY r29, r28, r27, r26
  ret
ENDF MATH_MUL_32_32

#define MATH_MUL_S_32_32  MATH_MUL_32_32
#define MATH_MUL_SU_32_32 MATH_MUL_32_32

DEFUN MATH_MAC_32_32        ; r25:r22 += r21:r18 * r29:r26
  MATH_MAC_32_32:
    MATH_MADD 22, r18, r26, 25
    MATH_MADD 23, r19, r26, 25
    MATH_MADD 23, r18, r27, 25
    MATH_MADD 24, r20, r26, 25
    MATH_MADD 24, r19, r27, 25
    MATH_MADD 24, r18, r28, 25
    MATH_MADD 25, r21, r26, 25
    MATH_MADD 25, r20, r27, 25
    MATH_MADD 25, r19, r28, 25
    MATH_MADD 25, r18, r29, 25
    ret
ENDF MATH_MAC_32_32

DEFUN MATH_MUL_16_16        ; r23:r22 *= r19:r18
  MATH_MUL_16_16:
  PUSH_MANY r20, r21
    movw    r20, r22
    mul     r20, r18        ; al*bl
    movw    r22,  r0
    mul     r20, r19        ; al*bh
    add     r23,  r0
    mul     r21, r18        ; ah*bl
    add     r23,  r0
  POP_MANY r21, r20
  ret
ENDF MATH_MUL_16_16

DEFUN MATH_MAC_16_16        ; r23:r22 += r21:r20 * r19:r18
  MATH_MAC_16_16:
    MATH_MADD 22, r20, r18, 23
    MATH_MADD 23, r21, r18, 23
    MATH_MADD 23, r20, r19, 23
    ret
ENDF MATH_MAC_16_16

DEFUN MATH_MUL_16_32        ; r25:r22 *= r19:r18
  MATH_MUL_16_32:
  PUSH_MANY r20, r21
    movw    r20, r22
    CLR_BLOCK r22, 4
    MATH_MADD 22, r20, r18, 25
    MATH_MADD 23, r21, r18, 25
    MATH_MADD 23, r20, r19, 25
    MATH_MADD 24, r21, r19, 25
  POP_MANY r21, r20
  ret
ENDF MATH_MUL_16_32

DEFUN MATH_MUL_SU_16_32     ; r25:r22 *= r19:r18
  MATH_MUL_SU_16_32:
  PUSH_MANY r20, r21
    movw    r20, r22
    mul     r20, r18        ; al*bl
    movw    r22,  r0
    mulsu   r21, r19        ; ah*bh
    movw    r24,  r0
    mul     r20, r19        ; al*bh
    add     r23,  r0
    adc     r24,  r1
    adc     r25, __zero_reg__
    mulsu   r21, r18        ; ah*bl
    sbc     r25, __zero_reg__
    add     r23,  r0
    adc     r24,  r1
    adc     r25, __zero_reg__
  POP_MANY r21, r20
  ret
ENDF MATH_MUL_SU_16_32

DEFUN MATH_MUL_S_16_32      ; r25:r22 *= r19:r18 - Push/Pop r21:r20
  MATH_MUL_S_16_32:
  PUSH_MANY r20, r21
    movw    r20, r22
    mul     r20, r18        ; al*bl
    movw    r22,  r0
    muls    r21, r19        ; ah*bh
    movw    r24,  r0
    mulsu   r19, r20        ; bh*al
    sbc     r25, __zero_reg__
    add     r23,  r0
    adc     r24,  r1
    adc     r25, __zero_reg__
    mulsu   r21, r18        ; ah*bl
    sbc     r25, __zero_reg__
    add     r23,  r0
    adc     r24,  r1
    adc     r25, __zero_reg__
  POP_MANY r21, r20
  ret
ENDF MATH_MUL_S_16_32

DEFUN MATH_MAC_16_32        ; r25:r22 += r21:r20 * r19:r18 - Push/Pop r21:r20
  MATH_MAC_16_32:
  PUSH_MANY r20, r21
    MATH_MADD 22, r20, r18, 25
    MATH_MADD 23, r21, r18, 25
    MATH_MADD 23, r20, r19, 25
    MATH_MADD 24, r21, r19, 25
  POP_MANY r21, r20
  ret
ENDF MATH_MAC_16_32
