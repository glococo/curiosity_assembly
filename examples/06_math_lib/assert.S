#define _ASSERT8u(a, b, c)     _ASSERT8 mul  , a, b, c, _STR_U16()
#define _ASSERT8s(a, b, c)     _ASSERT8 muls , a, b, c, _STR_S16()
#define _ASSERT8x(a, b, c)     _ASSERT8 mulsu, a, b, c, _STR_S16()
.macro _ASSERT8 i, a, b, c, ptype
    ldi     r22, \a                           ; Load A
    ldi     r18, \b                           ; Load B
    \i      r22, r18                          ; Hardware multiply
    movw    r22, r0
    _STR("  \i 8x8: \a * \b = ")$ \ptype
    cpi2    r22, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT16_(a, b, c)     _ASSERT16 _MUL16_16  , a, b, c, _STR_U16()
#define _ASSERT16u(a, b, c)     _ASSERT16 _MUL16_32  , a, b, c, _STR_U32()
#define _ASSERT16s(a, b, c)     _ASSERT16 _MUL16S_32 , a, b, c, _STR_S32()
#define _ASSERT16x(a, b, c)     _ASSERT16 _MUL16SU_32, a, b, c, _STR_S32()
.macro _ASSERT16 i, a, b, c, ptype
    clr2    r24
    ldi2    r22, \a                           ; Load A
    ldi2    r18, \b                           ; Load B
    call    \i                                ; Software multiply 16x16 -> 32-bit
    _STR("  \i 16x16: \a * \b = ")$ \ptype
    cpi4    r22, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT16mac16(a, b, c, d)     _ASSERT16mac _MAC16_16, a, b, c, d, _STR_U16()
#define _ASSERT16mac32(a, b, c, d)     _ASSERT16mac _MAC16_32, a, b, c, d, _STR_U32()
.macro _ASSERT16mac i, a, b, c, d, ptype
    ldi4    r22, \a                           ; Load A
    ldi2    r20, \b                           ; Load B
    ldi2    r18, \c                           ; Load C
    call    \i                                ; Software multiply and accumulate 16x16
    _STR("  \i 16x16: \a + (\b * \c) = ")$ \ptype
    cpi4    r22, \d
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT32_(a, b, c)       _ASSERT32 _MUL32_32, a, b, c, _STR_U32()
.macro _ASSERT32 i, a, b, c, ptype
    ldi4    r22, \a                           ; Load A
    ldi4    r18, \b                           ; Load B
    call    \i                                ; Software multiply 32x32 -> 32-bit
    _STR("  \i 32x32: \a * \b = ")$ \ptype
    cpi4    r22, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm
#define _ASSERT32mac(a, b, c, d)  _ASSERT32m _MAC32_32, a, b, c, d, _STR_U32()
.macro _ASSERT32m i, a, b, c, d, ptype
    ldi4    r22, \c                           ; Load C
    ldi4    r18, \b                           ; Load B
    mov4    r14, r18
    ldi4    r18, \a                           ; Load A
    call    \i                                ; Software multiply 32x32 -> 32-bit
    _STR("  \i 32x32: \c + (\a * \b) = ")$ \ptype
    cpi4    r22, \d
    brne    0f
    _STR(" _OK\r\n")
    jmp    1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT32u(a, b, c)     _ASSERT3264 _MUL32_64  , a, b, c, _STR_U64()
#define _ASSERT32s(a, b, c)     _ASSERT3264 _MUL32S_64 , a, b, c, _STR_S64()
#define _ASSERT32x(a, b, c)     _ASSERT3264 _MUL32SU_64, a, b, c, _STR_S64()
.macro _ASSERT3264 i, a, b, c, ptype
    ldi4    r22, \a                           ; Load A
    ldi4    r18, \b                           ; Load B
    call    \i                                ; Software multiply 32x32 -> 64-bit
    _STR("  \i 32x32: \a * \b = ")$ \ptype
    cpi8    r18, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT64u(a, b, c)     _ASSERT64 _MUL64_64  , a, b, c, _STR_U64()
#define _ASSERT64s(a, b, c)     _ASSERT64 _MUL64S_64 , a, b, c, _STR_S64()
#define _ASSERT64x(a, b, c)     _ASSERT64 _MUL64SU_64, a, b, c, _STR_S64()
.macro _ASSERT64 i, a, b, c, ptype
    ldi8    r18, \b                           ; Load B
    mov8    r10, r18
    ldi8    r18, \a                           ; Load A
    call    \i                                ; Software multiply 64x64 -> 64-bit
    _STR("  \i 64x64: \a * \b = ")$ \ptype
    cpi8    r18, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT_D8U(a, b, c)     _ASSERTD8 _DIV8 , a, b, c, _STR_U8()
#define _ASSERT_D8S(a, b, c)     _ASSERTD8 _DIV8S, a, b, c, _STR_S8()
.macro _ASSERTD8 i, a, b, c, ptype
    ldi     r22, \a                           ; Load A Dividend
    ldi     r18, \b                           ; Load B divisor
    call    \i                                ; Software divide 8/8 -> 8-bit
    _STR("  \i 8/8: \a / \b = ")$ \ptype
    cpi     r22, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT_D16U(a, b, c)     _ASSERTD16 _DIV16 , a, b, c, _STR_U16()
#define _ASSERT_D16S(a, b, c)     _ASSERTD16 _DIV16S, a, b, c, _STR_S16()
.macro _ASSERTD16 i, a, b, c, ptype
    ldi2    r22, \a                           ; Load A Dividend
    ldi2    r18, \b                           ; Load B divisor
    call    \i                                ; Software divide 16/16 -> 16-bit
    _STR("  \i 16/16: \a / \b = ")$ \ptype
    cpi2    r22, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT_D32U(a, b, c)     _ASSERTD32 _DIV32 , a, b, c, _STR_U32()
#define _ASSERT_D32S(a, b, c)     _ASSERTD32 _DIV32S, a, b, c, _STR_S32()
.macro _ASSERTD32 i, a, b, c, ptype
    ldi4    r22, \a                           ; Load A Dividend
    ldi4    r18, \b                           ; Load B divisor
    call    \i                                ; Software divide 32/32 -> 32-bit
    _STR("  \i 32/32: \a / \b = ")$ \ptype
    cpi4    r22, \c
    brne    0f
    _STR(" _OK\r\n")
    jmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm
