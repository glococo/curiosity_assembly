; Helper macros to split 64-bit value
#define lo32(x) ((x) & 0xFFFFFFFF)          ; Bits  0-31
#define hi32(x) (((x) >> 32) & 0xFFFFFFFF)  ; Bits 32-63
#define Q7(i, f)   (((i) * 128) + (((f) * 128) / 1000))
#define Q15(i, f)  (((i) * 32768) + (((f) * 32768) / 1000))
#define LOG2(x) (((x) >> 1) != 0) + (((x) >> 2) != 0) + (((x) >> 3) != 0) + (((x) >> 4) != 0) + \
                 (((x) >> 5) != 0) + (((x) >> 6) != 0) + (((x) >> 7) != 0) + (((x) >> 8) != 0) + \
                 (((x) >> 9) != 0) + (((x) >> 10) != 0) + (((x) >> 11) != 0) + (((x) >> 12) != 0) + \
                 (((x) >> 13) != 0) + (((x) >> 14) != 0) + (((x) >> 15) != 0)


; Function: add2s
; Description: Saturated 16-bit add.
; Inputs:   Ra, Rb - 16-bit value
; Output:   Caps at 0xFFFF on overflow
.macro add2s reg_a, reg_b
    add     \reg_a  , \reg_b
    adc     \reg_a+1, \reg_b+1
    brcc    1f                    ; If no carry, exit
    ldi     \reg_a  , 0xFF        ; If carry, cap at Max
    ldi     \reg_a+1, 0xFF
  1:
.endm
; Function: add4s
; Description: Saturated 32-bit add.
; Inputs:   Ra, Rb - 32-bit value
; Output:   Caps at 0xFFFFFFFF on overflow
.macro add4s reg_a, reg_b
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
.macro  add2  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
.endm
.macro  add2c  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
    adc \dest+2, __zero_reg__
.endm
.macro  add4  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
    adc \dest+2, \reg_start+2
    adc \dest+3, \reg_start+3
.endm
.macro  add4c  dest, reg_start
    add \dest,   \reg_start
    adc \dest+1, \reg_start+1
    adc \dest+2, \reg_start+2
    adc \dest+3, \reg_start+3
    adc \dest+4, __zero_reg__
.endm
; Macro: inc4
; Description: 32-bit addition of a register value to a 32-bit register pair.
.macro inc4 reg_start, value_reg
    add     \reg_start,   \value_reg
    adc     \reg_start+1, __zero_reg__
    adc     \reg_start+2, __zero_reg__
    adc     \reg_start+3, __zero_reg__
.endm
; Macro: dec4
; Description: 32-bit subtraction of a register value from a 32-bit register pair.
.macro dec4 reg_start, value_reg
    sub     \reg_start,   \value_reg
    sbc     \reg_start+1, __zero_reg__
    sbc     \reg_start+2, __zero_reg__
    sbc     \reg_start+3, __zero_reg__
.endm

.macro  sts2  dest, reg_start
    sts \dest,   \reg_start
    sts \dest+1, \reg_start+1
.endm
.macro  sts4  dest, reg_start
    sts \dest,   \reg_start
    sts \dest+1, \reg_start+1
    sts \dest+2, \reg_start+2
    sts \dest+3, \reg_start+3
.endm

.macro  ldi2  reg_start, val
    ldi \reg_start  , lo8( \val )
    ldi \reg_start+1, hi8( \val )
.endm
.macro  ldi4  reg_start, val
    ldi \reg_start  ,  lo8( \val )
    ldi \reg_start+1,  hi8( \val )
    ldi \reg_start+2, hlo8( \val )
    ldi \reg_start+3, hhi8( \val )
.endm
.macro ldi8 reg_start, val
    ldi4 \reg_start,     lo32(\val)      ; lower 32 bits
    ldi4 \reg_start+4,   hi32(\val)      ; upper 32 bits
.endm
.macro  lds2  reg_start, addr
    lds \reg_start, \addr
    lds \reg_start+1, \addr+1
.endm
.macro  lds4  reg_start, addr
    lds \reg_start+0, \addr+0
    lds \reg_start+1, \addr+1
    lds \reg_start+2, \addr+2
    lds \reg_start+3, \addr+3
.endm

.macro  ldd2  reg_start, ptr, offset
    ldd \reg_start, \ptr+\offset
    ldd \reg_start+1, \ptr+\offset+1
.endm

.macro  std2  ptr, offset, reg_start
    std \ptr+\offset, \reg_start
    std \ptr+\offset+1, \reg_start+1
.endm

; Macro: lsli
; Description: Logical shift left immediate
; Inputs:   reg - Register
;           r18 - shift count
.macro  lsli reg, pos
  PUSH r18
    ldi     r18, \pos
  0:
    lsl     \reg                        ; Shift low byte
    dec     r18                         ; Decrement count
    brne    0b                          ; Loop
  1:
  POP r18
.endm
.macro  lsli2 reg, pos
  PUSH r18
    ldi     r18, \pos
  0:
    lsl     \reg                        ; Shift low byte
    rol     \reg+1                      ; Rotate through carry to high byte
    dec     r18                         ; Decrement count
    brne    0b                          ; Loop
  1:
  POP r18
.endm
.macro  lsli4 reg, pos
  PUSH r18
    ldi     r18, \pos
  0:
    lsl     \reg                        ; Shift low byte
    rol     \reg+1                      ; Rotate through carry to hi8 byte
    rol     \reg+2                      ; Rotate through carry to hlo8 byte
    rol     \reg+3                      ; Rotate through carry to hhi8 byte
    dec     r18                         ; Decrement count
    brne    0b                          ; Loop
  1:
  POP r18
.endm

; Function: cp2
; Description: Compare (16-bit).
; Inputs:   Ra, Rb - 16-bit value
; Output:   SREG
.macro cp2 reg_a, reg_b
    cp    \reg_a  , \reg_b
    cpc   \reg_a+1, \reg_b+1
.endm
; Function: cp4
; Description: Compare (32-bit).
; Inputs:   Ra, Rb - 32-bit value
; Output:   SREG
.macro cp4 reg_a, reg_b
    cp    \reg_a  , \reg_b
    cpc   \reg_a+1, \reg_b+1
    cpc   \reg_a+2, \reg_b+2
    cpc   \reg_a+3, \reg_b+3
.endm
; Function: cpi2
; Description: Compare (16-bit).
; Inputs:   Ra, immediate value - 16-bit value
; Output:   SREG
.macro cpi2 reg_a, value
  PUSH r16
    cpi   \reg_a,   lo8( \value )
    ldi   r16,      hi8( \value )
    cpc   \reg_a+1, r16
  POP r16
.endm
; Function: cpi4
; Description: Compare (32-bit).
; Inputs:   Ra, immediate value - 32-bit value
; Output:   SREG
.macro cpi4 reg_a, value
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

; Function: andi2
; Description: AND immediate (16-bit).
; Inputs:   Ra, immediate value - 16-bit value
; Output:   SREG
.macro andi2 reg, value
    andi   \reg,   lo8( \value )
    andi   \reg+1, hi8( \value )
.endm

; Function: ori2
; Description: OR immediate (16-bit).
; Inputs:   Ra, immediate value - 16-bit value
; Output:   SREG
.macro ori2 reg, value
    ori   \reg,   lo8( \value )
    ori   \reg+1, hi8( \value )
.endm

; Function: mov4
; Description: MOV 4 contiguous registers (32-bits)
; Inputs:   reg  - initial register
;           reg2 - destination register
; Output:   SREG
.macro mov4 reg, reg2
    movw  \reg  , \reg2
    movw  \reg+2, \reg2+2
.endm

.macro  tst2  reg_start, reg_scratch=r0
    mov   \reg_scratch, \reg_start+0
    or    \reg_scratch, \reg_start+1
    tst   \reg_scratch
.endm

.macro  tst4  reg_start, reg_scratch=__scratch0__
    mov   \reg_scratch, \reg_start+0
    or    \reg_scratch, \reg_start+1
    or    \reg_scratch, \reg_start+2
    or    \reg_scratch, \reg_start+3
    tst   \reg_scratch
.endm
