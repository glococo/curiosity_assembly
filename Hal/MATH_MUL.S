; File: Hal/MATH_MUL.S
; Description: Multi-byte multiplication and Multiply-Accumulate (MAC) routines.
;              Supports 16, 32, and 64-bit operations, including signed and unsigned variants.
;
; Example Usage:
;   ldi     r18, 10
;   ldi     r22, 20
;   call   MATH_MUL_16_16              ; r23:r22 = 10 * 20 = 200
;
;   ; 32x32 to 64-bit signed multiplication
;   ; r25:r22 (A) * r21:r18 (B) -> r25:r18 (Result)
;   call   MATH_MUL_S_32_64

; Macro: MATH_MADD
; Description: Multiply-Add with Carry Propagation.
;              Multiplies two registers and adds the result to a register pair,
;              propagating the carry up to a specified limit register.
; Inputs:  off   - Starting register index for the result (e.g., 18 for r18)
;          a, b  - Registers to multiply
;          limit - Highest register index to propagate carry to (e.g., 25 for r25)
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

; Macro: MATH_SIGN_ADJUST
; Description: Helper macro for signed adjustment of multiplication results.
;              If sign_reg is negative, subtract val_regs from res_regs.
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
    .set _j, \res_start + \count
    .if \limit >= _j
        .rept \limit - _j + 1
            sbc _j, __zero_reg__
            .set _j, _j + 1
        .endr
    .endif
.L_done_\@:
.endm

; Aliases for same-size products where signed/unsigned logic is identical
#define MATH_MUL_S_64_64   MATH_MUL_64_64
#define MATH_MUL_SU_64_64  MATH_MUL_64_64

; Function: MATH_MUL_64_64
; Description: 64-bit x 64-bit -> 64-bit Unsigned Multiply (Truncated).
; Inputs:  r25:r18 - 64-bit multiplicand (A)
;          r17:r10 - 64-bit multiplier (B)
; Outputs: r25:r18 - 64-bit product (A * B)
FUNC MATH_MUL_64_64
  PUSH_MANY r4, r5, r6, r7, r8, r9, r26, r27
    mov4    r4, r18                    ; r4-r9 = r18-r23
    movw    r8, r22
    movw    r26, r24                   ; r26-r27 = r24-r25
    clr8    r18                        ; Clear accumulator

    ; Partial products
    MATH_MADD 18, r4, r10, 25
    MATH_MADD 19, r5, r10, 25
    MATH_MADD 19, r4, r11, 25
    MATH_MADD 20, r6, r10, 25
    MATH_MADD 20, r5, r11, 25
    MATH_MADD 20, r4, r12, 25
    MATH_MADD 21, r7, r10, 25
    MATH_MADD 21, r6, r11, 25
    MATH_MADD 21, r5, r12, 25
    MATH_MADD 21, r4, r13, 25
    MATH_MADD 22, r8, r10, 25
    MATH_MADD 22, r7, r11, 25
    MATH_MADD 22, r6, r12, 25
    MATH_MADD 22, r5, r13, 25
    MATH_MADD 22, r4, r14, 25
    MATH_MADD 23, r9, r10, 25
    MATH_MADD 23, r8, r11, 25
    MATH_MADD 23, r7, r12, 25
    MATH_MADD 23, r6, r13, 25
    MATH_MADD 23, r5, r14, 25
    MATH_MADD 23, r4, r15, 25
    MATH_MADD 24, r26, r10, 25
    MATH_MADD 24, r9, r11, 25
    MATH_MADD 24, r8, r12, 25
    MATH_MADD 24, r7, r13, 25
    MATH_MADD 24, r6, r14, 25
    MATH_MADD 24, r5, r15, 25
    MATH_MADD 24, r4, r16, 25
    MATH_MADD 25, r27, r10, 25
    MATH_MADD 25, r26, r11, 25
    MATH_MADD 25, r9, r12, 25
    MATH_MADD 25, r8, r13, 25
    MATH_MADD 25, r7, r14, 25
    MATH_MADD 25, r6, r15, 25
    MATH_MADD 25, r5, r16, 25
    MATH_MADD 25, r4, r17, 25
  POP_MANY r27, r26, r9, r8, r7, r6, r5, r4
ENDF MATH_MUL_64_64

; Function: MATH_MAC_32_64
; Description: 32-bit x 32-bit -> 64-bit Unsigned Multiply-Accumulate.
; Inputs:  r25:r18 - 64-bit Accumulator
;          r13:r10 - 32-bit Multiplicand (B)
;          r09:r06 - 32-bit Multiplier (A)
; Outputs: r25:r18 - Result (Accum += A * B)
FUNC MATH_MAC_32_64
    MATH_MADD 18, r10, r06, 25
    MATH_MADD 19, r11, r06, 25
    MATH_MADD 19, r10, r07, 25
    MATH_MADD 20, r12, r06, 25
    MATH_MADD 20, r11, r07, 25
    MATH_MADD 20, r10, r08, 25
    MATH_MADD 21, r13, r06, 25
    MATH_MADD 21, r12, r07, 25
    MATH_MADD 21, r11, r08, 25
    MATH_MADD 21, r10, r09, 25
    MATH_MADD 22, r13, r07, 25
    MATH_MADD 22, r12, r08, 25
    MATH_MADD 22, r11, r09, 25
    MATH_MADD 23, r13, r08, 25
    MATH_MADD 23, r12, r09, 25
    MATH_MADD 24, r13, r09, 25
ENDF MATH_MAC_32_64

; Function: MATH_MAC_SU_32_64
; Description: Signed 32-bit x Unsigned 32-bit -> 64-bit Multiply-Accumulate.
; Inputs:  r25:r18 - 64-bit Accumulator
;          r09:r06 - 32-bit Signed Multiplier (A)
;          r13:r10 - 32-bit Unsigned Multiplicand (B)
; Outputs: r25:r18 - Result
FUNC MATH_MAC_SU_32_64
    call   MATH_MAC_32_64
    MATH_SIGN_ADJUST r13, 22, 06, 4, 25
ENDF MATH_MAC_SU_32_64

; Function: MATH_MAC_S_32_64
; Description: Signed 32-bit x Signed 32-bit -> 64-bit Multiply-Accumulate.
; Inputs:  r25:r18 - 64-bit Accumulator
;          r13:r10 - 32-bit Signed Multiplicand (A)
;          r09:r06 - 32-bit Signed Multiplier (B)
; Outputs: r25:r18 - Result
FUNC MATH_MAC_S_32_64
    call   MATH_MAC_32_64
    MATH_SIGN_ADJUST r13, 22, 06, 4, 25
    MATH_SIGN_ADJUST r09, 22, 10, 4, 25
ENDF MATH_MAC_S_32_64

; Function: MATH_MUL_32_64
; Description: 32-bit x 32-bit -> 64-bit Unsigned Multiply.
; Inputs:  r25:r22 - 32-bit Multiplier (A)
;          r21:r18 - 32-bit Multiplicand (B)
; Outputs: r25:r18 - 64-bit Product
FUNC MATH_MUL_32_64
  PUSH_MANY r06, r07, r08, r09, r10, r11, r12, r13
    mov4    r6, r18               ; Copy B to r09:r06
    mov4    r10, r22              ; Copy A to r13:r10
    clr8    r18                   ; Clear result
    call   MATH_MAC_32_64
  POP_MANY r13, r12, r11, r10, r09, r08, r07, r06
ENDF MATH_MUL_32_64

; Function: MATH_MUL_SU_32_64
; Description: Signed 32-bit x Unsigned 32-bit -> 64-bit Multiply.
FUNC MATH_MUL_SU_32_64
  PUSH_MANY r06, r07, r08, r09, r10, r11, r12, r13
    mov4      r6, r18               ; B (Unsigned)
    mov4      r10, r22              ; A (Signed)
    clr8      r18
    call     MATH_MAC_SU_32_64
  POP_MANY r13, r12, r11, r10, r09, r08, r07, r06
ENDF MATH_MUL_SU_32_64

; Function: MATH_MUL_S_32_64
; Description: Signed 32-bit x Signed 32-bit -> 64-bit Multiply.
FUNC MATH_MUL_S_32_64
  PUSH_MANY r06, r07, r08, r09, r10, r11, r12, r13
    mov4      r6, r18               ; B (Signed)
    mov4      r10, r22              ; A (Signed)
    clr8      r18
    call     MATH_MAC_S_32_64
  POP_MANY r13, r12, r11, r10, r09, r08, r07, r06
ENDF MATH_MUL_S_32_64

; Function: MATH_MUL_32_32
; Description: 32-bit x 32-bit -> 32-bit Unsigned Multiply (Truncated).
; Inputs:  r25:r22 - 32-bit A
;          r21:r18 - 32-bit B
; Outputs: r25:r22 - 32-bit Product
FUNC MATH_MUL_32_32
  PUSH_MANY r14, r15, r16, r17
    mov4      r14, r22
    clr4      r22
    MATH_MADD 22, r14, r18, 25
    MATH_MADD 23, r15, r18, 25
    MATH_MADD 23, r14, r19, 25
    MATH_MADD 24, r16, r18, 25
    MATH_MADD 24, r15, r19, 25
    MATH_MADD 24, r14, r20, 25
    MATH_MADD 25, r17, r18, 25
    MATH_MADD 25, r16, r19, 25
    MATH_MADD 25, r15, r20, 25
    MATH_MADD 25, r14, r21, 25
  POP_MANY r17, r16, r15, r14
ENDF MATH_MUL_32_32

#define MATH_MUL_S_32_32  MATH_MUL_32_32
#define MATH_MUL_SU_32_32 MATH_MUL_32_32

; Function: MATH_MAC_32_32
; Description: 32-bit x 32-bit -> 32-bit Unsigned Multiply-Accumulate.
; Inputs:  r25:r22 - Accumulator
;          r21:r18 - A
;          r17:r14 - B
; Outputs: r25:r22 - Result
FUNC MATH_MAC_32_32
    MATH_MADD 22, r18, r14, 25
    MATH_MADD 23, r19, r14, 25
    MATH_MADD 23, r18, r15, 25
    MATH_MADD 24, r20, r14, 25
    MATH_MADD 24, r19, r15, 25
    MATH_MADD 24, r18, r16, 25
    MATH_MADD 25, r21, r14, 25
    MATH_MADD 25, r20, r15, 25
    MATH_MADD 25, r19, r16, 25
    MATH_MADD 25, r18, r17, 25
ENDF MATH_MAC_32_32

; Function: MATH_MUL_16_16
; Description: 16-bit x 16-bit -> 16-bit Unsigned Multiply.
; Inputs:  r23:r22 - A
;          r19:r18 - B
; Outputs: r23:r22 - Product
FUNC MATH_MUL_16_16
  PUSH_MANY r20, r21
    movw    r20, r22
    mul     r20, r18                    ; al*bl
    movw    r22, r0
    mul     r20, r19                    ; al*bh
    add     r23, r0
    mul     r21, r18                    ; ah*bl
    add     r23, r0
  POP_MANY r21, r20
ENDF MATH_MUL_16_16

; Function: MATH_MAC_16_16
; Description: 16-bit x 16-bit -> 16-bit Multiply-Accumulate.
; Inputs:  r21:r20 - A
;          r19:r18 - B
; Outputs: r23:r22 - Product
FUNC MATH_MAC_16_16
    MATH_MADD 22, r20, r18, 23
    MATH_MADD 23, r21, r18, 23
    MATH_MADD 23, r20, r19, 23
ENDF MATH_MAC_16_16

; Function: MATH_MUL_16_32
; Description: 16-bit x 16-bit -> 32-bit Unsigned Multiply.
; Inputs:  r23:r22 - A
;          r19:r18 - B
; Outputs: r25:r22 - 32-bit Product
FUNC MATH_MUL_16_32
  PUSH_MANY r20, r21
    movw      r20, r22
    clr2      r24
    mul       r20, r18
    movw      r22, r0
    MATH_MADD 23, r21, r18, 25
    MATH_MADD 23, r20, r19, 25
    MATH_MADD 24, r21, r19, 25
  POP_MANY r21, r20
ENDF MATH_MUL_16_32

; Function: MATH_MUL_SU_16_32
; Description: Signed 16-bit (A) x Unsigned 16-bit (B) -> 32-bit Multiply.
; Inputs:  r23:r22 - A
;          r19:r18 - B
; Outputs: r25:r22 - Product
FUNC MATH_MUL_SU_16_32
  PUSH_MANY r20, r21
    movw    r20, r22                    ; r21:r20 = A (signed)
                                        ; r19:r18 = B (unsigned)

    mul     r20, r18                    ; al * bl (un*un)
    movw    r22, r0                     ; r23:r22 = result

    mulsu   r21, r19                    ; ah * bh (si*un)
    movw    r24, r0                     ; r25:r24 = result

    mulsu   r21, r18                    ; ah * bl (si*un)
    sbc     r25, __zero_reg__           ; Sign extend
    add     r23, r0
    adc     r24, r1
    adc     r25, __zero_reg__
    mul     r20, r19                    ; al * bh (un*un)
    add     r23, r0
    adc     r24, r1
    adc     r25, __zero_reg__
  POP_MANY r21, r20
ENDF MATH_MUL_SU_16_32

; Function: MATH_MUL_S_16_32
; Description: Signed 16-bit (A) x Signed 16-bit (B) -> 32-bit Multiply.
; Inputs:  r23:r22 - A
;          r19:r18 - B
; Outputs: r23:r22 - Product
FUNC MATH_MUL_S_16_32
  PUSH_MANY r20, r21
    movw    r20, r22                    ; r21:r20 = A (signed)
                                        ; r19:r18 = B (signed)
    mul     r20, r18                    ; al * bl (un*un)
    movw    r22, r0                     ; Byte 1:0

    muls    r21, r19                    ; ah * bh (si*si)
    movw    r24, r0                     ; Byte 3:2

    mulsu   r21, r18                    ; ah * bl (si*un)
    sbc     r25, __zero_reg__           ; Sign extend
    add     r23, r0
    adc     r24, r1
    adc     r25, __zero_reg__

    mulsu   r19, r20                    ; bh * al (si*un)
    sbc     r25, __zero_reg__           ; Sign extend
    add     r23, r0
    adc     r24, r1
    adc     r25, __zero_reg__
  POP_MANY r21, r20
ENDF MATH_MUL_S_16_32

; Function: MATH_MAC_16_32
; Description: 16-bit x 16-bit -> 32-bit Multiply-Accumulate.
; Inputs:  r21:r20 - A
;          r19:r18 - B
; Outputs: r25:r22 - Product
FUNC MATH_MAC_16_32
  PUSH_MANY r20, r21
    MATH_MADD 22, r20, r18, 25
    MATH_MADD 23, r21, r18, 25
    MATH_MADD 23, r20, r19, 25
    MATH_MADD 24, r21, r19, 25
  POP_MANY r21, r20
ENDF MATH_MAC_16_32
