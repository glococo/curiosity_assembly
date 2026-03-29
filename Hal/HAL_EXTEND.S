.macro  addw  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
.endm
.macro  addwc  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
    adc \dest+2, __reg_zero__
.endm
.macro  addl  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
    adc \dest+2, \reg_start+2
    adc \dest+3, \reg_start+3
.endm
.macro  addlc  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
    adc \dest+2, \reg_start+2
    adc \dest+3, \reg_start+3
    adc \dest+4, __reg_zero__
.endm

.macro  stsw  dest, reg_start
    sts \dest,   \reg_start
    sts \dest+1, \reg_start+1
.endm
.macro  sts4  dest, reg_start
    sts \dest,   \reg_start
    sts \dest+1, \reg_start+1
    sts \dest+2, \reg_start+2
    sts \dest+3, \reg_start+3
.endm

.macro  ldiw  reg_start, val
    ldi \reg_start  , lo8( \val )
    ldi \reg_start+1, hi8( \val )
.endm
.macro  ldi4  reg_start, val
    ldi \reg_start  ,  lo8( \val )
    ldi \reg_start+1,  hi8( \val )
    ldi \reg_start+2, hlo8( \val )
    ldi \reg_start+3, hhi8( \val )
.endm

.macro  ldsw  reg_start, addr
    lds \reg_start, \addr
    lds \reg_start+1, \addr+1
.endm
.macro  lds4  reg_start, addr
    lds \reg_start+0, \addr+0
    lds \reg_start+1, \addr+1
    lds \reg_start+2, \addr+2
    lds \reg_start+3, \addr+3
.endm

.macro  lddw  reg_start, ptr, offset
    ldd \reg_start, \ptr+\offset
    ldd \reg_start+1, \ptr+\offset+1
.endm

.macro  stdw  ptr, offset, reg_start
    std \ptr+\offset, \reg_start
    std \ptr+\offset+1, \reg_start+1
.endm
