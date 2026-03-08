; Comparisons (Returning Flags)
; These are used when you need to compare 32-bit values for branches.
#define MATH_CMP_32       __cmpsi2       ; Compare (Signed) r25:r22 with r21:r18
#define MATH_UCMP_32      __ucmpsi2      ; Compare (Unsigned) r25:r22 with r21:r18

; Miscellaneous Helpers
#define MATH_FFS_16       __ffshi2       ; Find First Set Bit in r25:r24
#define MATH_CLZ_16       __clzhi2       ; Count Leading Zeros in r25:r24
#define MATH_CTZ_16       __ctzhi2       ; Count Trailing Zeros in r25:r24
#define MATH_POPCOUNT_16  __popcounthi2  ; Population Count (bit count) in r25:r24

;******************************************************************************
;* @macro INC_32_REG
;* @brief 32-bit addition/increment using registers
;* @param @0 Target Register LSB (e.g., 22 for r22)
;* @param @1 Value Register (The amount to add, e.g., r18)
;******************************************************************************
.macro INC_32_REG
    add     @0,   @1
    adc     @0+1, __zero_reg__
    adc     @0+2, __zero_reg__
    adc     @0+3, __zero_reg__
.endm

;******************************************************************************
;* @macro DEC_32_REG
;* @brief 32-bit substract/decrement using registers
;* @param @0 Target Register LSB (e.g., 22 for r22)
;* @param @1 Value Register (The amount to substract, e.g., r18)
;******************************************************************************
.macro DEC_32_REG
    sub     @0,   @1
    sbc     @0+1, __zero_reg__
    sbc     @0+2, __zero_reg__
    sbc     @0+3, __zero_reg__
.endm

; MATH_LSL_16           ; r23:r22 = r23:r22 << r18 - Logical Shift Left - Result = Input << Count
; MATH_LSL_24           ; r24:r22 = r24:r22 << r18
; MATH_LSL_32           ; r25:r22 = r25:r22 << r18
; MATH_LSR_16           ; r23:r22 = r23:r22 >> r18 - Logical Shift Right - Result = Input >> Count
; MATH_LSR_24           ; r24:r22 = r24:r22 >> r18
; MATH_LSR_32           ; r25:r22 = r25:r22 >> r18
; Arithmetic Shift Right: Result = (signed)Input >> Count. It preserves the sign bit (MSB)
; MATH_ASR_16           ; r23:r22 = r23:r22 >> r18 (Sign extended)
; MATH_ASR_24           ; r24:r22 = r24:r22 >> r18 (Sign extended)
; MATH_ASR_32           ; r25:r22 = r25:r22 >> r18 (Sign extended)

DEFUN MATH_LSL_16       ; r23:r22 << r18
  MATH_LSL_16:
    tst     r18
    breq    exit_lsl_16
  loop_lsl_16:
    lsl     r22
    rol     r23
    dec     r18
    brne    loop_lsl_16
  exit_lsl_16:
    ret
ENDF MATH_LSL_16
DEFUN MATH_LSL_24       ; r24:r22 << r18
  MATH_LSL_24:
    tst     r18
    breq    exit_lsl_24
  loop_lsl_24:
    lsl     r22
    rol     r23
    rol     r24
    dec     r18
    brne    loop_lsl_24
  exit_lsl_24:
    ret
ENDF MATH_LSL_24
DEFUN MATH_LSL_32       ; r25:r22 << r18
  MATH_LSL_32:
    tst     r18
    breq    exit_lsl_32
  loop_lsl_32:
    lsl     r22
    rol     r23
    rol     r24
    rol     r25
    dec     r18
    brne    loop_lsl_32
  exit_lsl_32:
    ret
ENDF MATH_LSL_32
DEFUN MATH_LSR_16       ; r23:r22 >> r18
  MATH_LSR_16:
    tst     r18
    breq    exit_lsr_16
  loop_lsr_16:
    lsr     r23
    ror     r22
    dec     r18
    brne    loop_lsr_16
  exit_lsr_16:
    ret
ENDF MATH_LSR_16
DEFUN MATH_LSR_24       ; r24:r22 >> r18
  MATH_LSR_24:
    tst     r18
    breq    exit_lsr_24
  loop_lsr_24:
    lsr     r24
    ror     r23
    ror     r22
    dec     r18
    brne    loop_lsr_24
  exit_lsr_24:
    ret
ENDF MATH_LSR_24
DEFUN MATH_LSR_32       ; r25:r22 >> r18
  MATH_LSR_32:
    tst     r18
    breq    exit_lsr_32
  loop_lsr_32:
    lsr     r25
    ror     r24
    ror     r23
    ror     r22
    dec     r18
    brne    loop_lsr_32
  exit_lsr_32:
    ret
ENDF MATH_LSR_32

DEFUN MATH_ASR_16       ; r23:r22 >> r18
  MATH_ASR_16:
    tst     r18
    breq    exit_asr_16
  loop_asr_16:
    asr     r23
    ror     r22
    dec     r18
    brne    loop_asr_16
  exit_asr_16:
    ret
ENDF MATH_ASR_16
DEFUN MATH_ASR_24       ; r24:r22 >> r18
  MATH_ASR_24:
    tst     r18
    breq    exit_asr_24
  loop_asr_24:
    asr     r24
    ror     r23
    ror     r22
    dec     r18
    brne    loop_asr_24
  exit_asr_24:
    ret
ENDF MATH_ASR_24
DEFUN MATH_ASR_32       ; r25:r22 >> r18
  MATH_ASR_32:
    tst     r18
    breq    exit_asr_32
  loop_asr_32:
    asr     r25
    ror     r24
    ror     r23
    ror     r22
    dec     r18
    brne    loop_asr_32
  exit_asr_32:
    ret
ENDF MATH_ASR_32
