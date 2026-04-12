; File: Hal/HAL_TCE.S
; Description: TCE - Timer Counter E
;              16-Bit Timer/Counter helper library for AVR-EB/LA families.
;
#define _TCE0_CMPBUF( cmp0, cmp1, cmp2, cmp3 )  HAL_TCE0_CMPxBUF cmp0, cmp1, cmp2, cmp3
#define _TCE0_PERBUF(per)                       HAL_TCE0_PERBUF per

.macro HAL_TCE0_PERBUF per
    ldi2    r22, \per
    sts2    TCE0_PERBUF, r22
.endm
.macro HAL_TCE0_CMPxBUF cmp0, cmp1, cmp2, cmp3
    ldi2    r22, \cmp0
    sts2    TCE0_CMP0BUF, r22
    ldi2    r22, \cmp1
    sts2    TCE0_CMP1BUF, r22
    ldi2    r22, \cmp2
    sts2    TCE0_CMP2BUF, r22
    ldi2    r22, \cmp3
    sts2    TCE0_CMP3BUF, r22
.endm

