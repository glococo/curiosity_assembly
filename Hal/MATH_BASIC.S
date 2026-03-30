; File: Hal/MATH_BASIC.S
; Description: Multi-byte bitwise arithmetic routines.
;              Supports 16, and 32-bit operations.
;
; Example Usage:
;   ldi     r22, lo8(0x1234)
;   ldi     r23, hi8(0x1234)
;   ldi     r18, 4
;   rcall   MATH_LSL_16                 ; 0x1234 << 4 = 0x2340

; Function: MATH_ADD_SATURATED_U16
; Description: Saturated 16-bit add.
; Inputs:   Ra, Rb - 16-bit value
; Output:   Caps at 0xFFFF on overflow
.macro MATH_ADD_SATURATED_U16 reg_a, reg_b
    add     \reg_a  , \reg_b
    adc     \reg_a+1, \reg_b+1
    brcc    1f                    ; If no carry, exit
    ldi     \reg_a  , 0xFF        ; If carry, cap at Max
    ldi     \reg_a+1, 0xFF
  1:
.endm
; Function: MATH_ADD_SATURATED_U32
; Description: Saturated 32-bit add.
; Inputs:   Ra, Rb - 32-bit value
; Output:   Caps at 0xFFFFFFFF on overflow
.macro MATH_ADD_SATURATED_U32 reg_a, reg_b
    add     \reg_a  , \reg_b
    adc     \reg_a+1, \reg_b+1
    adc     \reg_a+2, \reg_b+2
    adc     \reg_a+3, \reg_b+3
    brcc    1f                    ; If no carry, exit
    ldi     \reg_a  , 0xFF        ; If carry, cap at Max
    ldi     \reg_a+1, 0xFF
    ldi     \reg_a+2, 0xFF
    ldi     \reg_a+3, 0xFF
  1:
.endm


; Macro: MATH_INC_32_REG
; Description: 32-bit addition of a register value to a 32-bit register pair.
.macro MATH_INC_32_REG reg_start, value_reg
    add     \reg_start,   \value_reg
    adc     \reg_start+1, __zero_reg__
    adc     \reg_start+2, __zero_reg__
    adc     \reg_start+3, __zero_reg__
.endm

; Macro: MATH_DEC_32_REG
; Description: 32-bit subtraction of a register value from a 32-bit register pair.
.macro MATH_DEC_32_REG reg_start, value_reg
    sub     \reg_start,   \value_reg
    sbc     \reg_start+1, __zero_reg__
    sbc     \reg_start+2, __zero_reg__
    sbc     \reg_start+3, __zero_reg__
.endm
