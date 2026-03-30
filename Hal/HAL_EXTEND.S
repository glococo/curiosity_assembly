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

.macro  lsli  pos
  PUSH r18
    ldi     r18, \pos
  0:
    lsl     r22                         ; Shift low byte
    dec     r18                         ; Decrement count
    brne    0b                          ; Loop
  1:
  POP r18
.endm
.macro  lsliw  pos
  PUSH r18
    ldi     r18, \pos
  0:
    lsl     r22                         ; Shift low byte
    rol     r23                         ; Rotate through carry to high byte
    dec     r18                         ; Decrement count
    brne    0b                          ; Loop
  1:
  POP r18
.endm
.macro  lslil  pos
  PUSH r18
    ldi     r18, \pos
  0:
    lsl     r22                         ; Shift low byte
    rol     r23                         ; Rotate through carry to hi8 byte
    rol     r24                         ; Rotate through carry to hlo8 byte
    rol     r25                         ; Rotate through carry to hhi8 byte
    dec     r18                         ; Decrement count
    brne    0b                          ; Loop
  1:
  POP r18
.endm

; Function: cpw
; Description: Compare (16-bit).
; Inputs:   Ra, Rb - 16-bit value
; Output:   SREG
.macro cpw reg_a, reg_b
    cp    \reg_a  , \reg_b
    cpc   \reg_a+1, \reg_b+1
.endm
; Function: cpl
; Description: Compare (32-bit).
; Inputs:   Ra, Rb - 32-bit value
; Output:   SREG
.macro cpl reg_a, reg_b
    cp    \reg_a  , \reg_b
    cpc   \reg_a+1, \reg_b+1
    cpc   \reg_a+2, \reg_b+2
    cpc   \reg_a+3, \reg_b+3
.endm
; Function: cpiw
; Description: Compare (16-bit).
; Inputs:   Ra, immediate value - 16-bit value
; Output:   SREG
.macro cpiw reg_a, value
  PUSH r16
    cpi   \reg_a,   lo8( \value )
    ldi   r16,      hi8( \value )
    cpc   \reg_a+1, r16
  POP r16
.endm
; Function: cpil
; Description: Compare (32-bit).
; Inputs:   Ra, immediate value - 32-bit value
; Output:   SREG
.macro cpil reg_a, value
  PUSH r16
    cpi   \reg_a,   lo8( \value )
    ldi   r16,      hi8( \value )
    cpc   \reg_a+1, r16
    ldi   r16,      hlo8( \value )
    cpc   \reg_a+2, r16
    ldi   r16,      hhi8( \value )
    cpc   \reg_a+3, r16
  POP r16
.endm
