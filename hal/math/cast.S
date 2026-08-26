; File: Hal/MATH_CAST.S
; Description: Multi-byte casting routines.
;              Supports 8, 16, 24, and 32-bit operations.
;
; Example Usage:
;   ldi     r22, -5
;   call    _MATH_LSL_16                 ; 0x1234 << 4 = 0x2340
#define _CAST8_16(r)        HAL_CAST_S8_S16 r
#define _CAST8_24(r)        HAL_CAST_S8_S24 r
#define _CAST8_32(r)        HAL_CAST_S8_S32 r

;******************************************************************************
;* HAL_CAST_S8_S16
;* Sign-extends an 8-bit signed value in 'reg' into a 16-bit 'reg+1:reg'
;******************************************************************************
.macro HAL_CAST_S8_S16 reg
    mov     \reg+1, \reg
    lsl     \reg+1
    sbc     \reg+1, \reg+1
.endm
;******************************************************************************
;* HAL_CAST_S8_S24
;* Sign-extends an 8-bit signed value in 'reg' into a 24-bit 'reg+2:reg'
;******************************************************************************
.macro HAL_CAST_S8_S24 reg
    mov     \reg+1, \reg
    lsl     \reg+1
    sbc     \reg+1, \reg+1
    mov     \reg+2, \reg+1
.endm
;******************************************************************************
;* HAL_CAST_S8_S32
;* Sign-extends an 8-bit signed value in 'reg' into a 32-bit 'reg+3:reg'
;******************************************************************************
.macro HAL_CAST_S8_S32 reg
    mov     \reg+1, \reg
    lsl     \reg+1
    sbc     \reg+1, \reg+1
    mov     \reg+2, \reg+1
    mov     \reg+3, \reg+1
.endm
