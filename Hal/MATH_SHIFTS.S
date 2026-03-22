; File: Hal/MATH_SHIFTS.S
; Description: Multi-byte bitwise shift and arithmetic routines.
;              Supports 16, 24, and 32-bit operations.
;
; Example Usage:
;   ldi     r22, lo8(0x1234)
;   ldi     r23, hi8(0x1234)
;   ldi     r18, 4
;   rcall   MATH_LSL_16                 ; 0x1234 << 4 = 0x2340

; Comparisons (Returning Flags)
#define MATH_CMP_32       __cmpsi2       ; Compare (Signed) r25:r22 with r21:r18
#define MATH_UCMP_32      __ucmpsi2      ; Compare (Unsigned) r25:r22 with r21:r18

; Miscellaneous Helpers
#define MATH_FFS_16       __ffshi2       ; Find First Set Bit in r25:r24
#define MATH_CLZ_16       __clzhi2       ; Count Leading Zeros in r25:r24
#define MATH_CTZ_16       __ctzhi2       ; Count Trailing Zeros in r25:r24
#define MATH_POPCOUNT_16  __popcounthi2  ; Population Count (bit count) in r25:r24

; Macro: INC_32_REG
; Description: 32-bit addition of a register value to a 32-bit register pair.
.macro INC_32_REG reg_start, value_reg
    add     \reg_start,   \value_reg
    adc     \reg_start+1, __zero_reg__
    adc     \reg_start+2, __zero_reg__
    adc     \reg_start+3, __zero_reg__
.endm

; Macro: DEC_32_REG
; Description: 32-bit subtraction of a register value from a 32-bit register pair.
.macro DEC_32_REG reg_start, value_reg
    sub     \reg_start,   \value_reg
    sbc     \reg_start+1, __zero_reg__
    sbc     \reg_start+2, __zero_reg__
    sbc     \reg_start+3, __zero_reg__
.endm

; Function: MATH_LSL_16
; Description: Logical Shift Left (16-bit).
; Inputs:  r23:r22 - 16-bit value
;          r18     - Shift count
; Outputs: r23:r22 - Result
FUNC MATH_LSL_16
    tst     r18                         ; Check if count is zero
    breq    1f                          ; Exit if 0
  0:
    lsl     r22                         ; Shift low byte
    rol     r23                         ; Rotate through carry to high byte
    dec     r18                         ; Decrement count
    brne    0b                          ; Loop
  1:
ENDF MATH_LSL_16

; Function: MATH_LSL_24
; Description: Logical Shift Left (24-bit).
; Inputs:  r24:r22 - 24-bit value
;          r18     - Shift count
; Outputs: r24:r22 - Result
FUNC MATH_LSL_24
    tst     r18
    breq    1f
  0:
    lsl     r22
    rol     r23
    rol     r24
    dec     r18
    brne    0b
  1:
ENDF MATH_LSL_24

; Function: MATH_LSL_32
; Description: Logical Shift Left (32-bit).
; Inputs:  r25:r22 - 32-bit value
;          r18     - Shift count
; Outputs: r25:r22 - Result
FUNC MATH_LSL_32
    tst     r18
    breq    1f
  0:
    lsl     r22
    rol     r23
    rol     r24
    rol     r25
    dec     r18
    brne    0b
  1:
ENDF MATH_LSL_32

; Function: MATH_LSR_16
; Description: Logical Shift Right (16-bit).
; Inputs:  r23:r22 - 16-bit value
;          r18     - Shift count
; Outputs: r23:r22 - Result
FUNC MATH_LSR_16
    tst     r18
    breq    1f
  0:
    lsr     r23                         ; Shift high byte
    ror     r22                         ; Rotate through carry to low byte
    dec     r18
    brne    0b
  1:
ENDF MATH_LSR_16

; Function: MATH_LSR_24
; Description: Logical Shift Right (24-bit).
; Inputs:  r24:r22 - 24-bit value
;          r18     - Shift count
; Outputs: r24:r22 - Result
FUNC MATH_LSR_24
    tst     r18
    breq    1f
  0:
    lsr     r24
    ror     r23
    ror     r22
    dec     r18
    brne    0b
  1:
ENDF MATH_LSR_24

; Function: MATH_LSR_32
; Description: Logical Shift Right (32-bit).
; Inputs:  r25:r22 - 32-bit value
;          r18     - Shift count
; Outputs: r25:r22 - Result
FUNC MATH_LSR_32
    tst     r18
    breq    1f
  0:
    lsr     r25
    ror     r24
    ror     r23
    ror     r22
    dec     r18
    brne    0b
  1:
ENDF MATH_LSR_32

; Function: MATH_ASR_16
; Description: Arithmetic Shift Right (16-bit). Preserves sign bit.
; Inputs:  r23:r22 - 16-bit signed value
;          r18     - Shift count
; Outputs: r23:r22 - Result
FUNC MATH_ASR_16
    tst     r18
    breq    1f
  0:
    asr     r23                         ; Arithmetic shift high byte (preserves bit 7)
    ror     r22                         ; Rotate through carry
    dec     r18
    brne    0b
  1:
ENDF MATH_ASR_16

; Function: MATH_ASR_24
; Description: Arithmetic Shift Right (24-bit). Preserves sign bit.
; Inputs:  r24:r22 - 24-bit signed value
;          r18     - Shift count
; Outputs: r24:r22 - Result
FUNC MATH_ASR_24
    tst     r18
    breq    1f
  0:
    asr     r24
    ror     r23
    ror     r22
    dec     r18
    brne    0b
  1:
ENDF MATH_ASR_24

; Function: MATH_ASR_32
; Description: Arithmetic Shift Right (32-bit). Preserves sign bit.
; Inputs:  r25:r22 - 32-bit signed value
;          r18     - Shift count
; Outputs: r25:r22 - Result
FUNC MATH_ASR_32
    tst     r18
    breq    1f
  0:
    asr     r25
    ror     r24
    ror     r23
    ror     r22
    dec     r18
    brne    0b
  1:
ENDF MATH_ASR_32
