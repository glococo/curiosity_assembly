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
    rjmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT16_(a, b, c)     _ASSERT16 MATH_MUL_16_16   , a, b, c, _STR_U16()
#define _ASSERT16u(a, b, c)     _ASSERT16 MATH_MUL_16_32   , a, b, c, _STR_U32()
#define _ASSERT16s(a, b, c)     _ASSERT16 MATH_MUL_S_16_32 , a, b, c, _STR_S32()
#define _ASSERT16x(a, b, c)     _ASSERT16 MATH_MUL_SU_16_32, a, b, c, _STR_S32()
.macro _ASSERT16 i, a, b, c, ptype
    clr2    r24
    ldi2    r22, \a                           ; Load A
    ldi2    r18, \b                           ; Load B
    rcall   \i                                ; Software multiply 16x16 -> 32-bit
    _STR("  \i 16x16: \a * \b = ")$ \ptype
    cpi4    r22, \c
    brne    0f
    _STR(" _OK\r\n")
    rjmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT16mac16(a, b, c, d)     _ASSERT16mac MATH_MAC_16_16, a, b, c, d, _STR_U16()
#define _ASSERT16mac32(a, b, c, d)     _ASSERT16mac MATH_MAC_16_32, a, b, c, d, _STR_U32()
.macro _ASSERT16mac i, a, b, c, d, ptype
    ldi4    r22, \a                           ; Load A
    ldi2    r20, \b                           ; Load B
    ldi2    r18, \c                           ; Load C
    rcall   \i                                ; Software multiply and accumulate 16x16
    _STR("  \i 16x16: \a + (\b * \c) = ")$ \ptype
    cpi4    r22, \d
    brne    0f
    _STR(" _OK\r\n")
    rjmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT32_(a, b, c)       _ASSERT32 MATH_MUL_32_32, a, b, c, _STR_U32()
.macro _ASSERT32 i, a, b, c, ptype
    ldi4    r22, \a                           ; Load A
    ldi4    r18, \b                           ; Load B
    rcall   \i                                ; Software multiply 32x32 -> 32-bit
    _STR("  \i 32x32: \a * \b = ")$ \ptype
    cpi4    r22, \c
    brne    0f
    _STR(" _OK\r\n")
    rjmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm
#define _ASSERT32mac(a, b, c, d)  _ASSERT32m MATH_MAC_32_32, a, b, c, d, _STR_U32()
.macro _ASSERT32m i, a, b, c, d, ptype
    ldi4    r22, \c                           ; Load C
    ldi4    r18, \b                           ; Load B
    mov4    r14, r18
    ldi4    r18, \a                           ; Load A
    rcall   \i                                ; Software multiply 32x32 -> 32-bit
    _STR("  \i 32x32: \c + (\a * \b) = ")$ \ptype
    cpi4    r22, \d
    brne    0f
    _STR(" _OK\r\n")
    rjmp    1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT32u(a, b, c)     _ASSERT3264 MATH_MUL_32_64   , a, b, c, _STR_U64()
#define _ASSERT32s(a, b, c)     _ASSERT3264 MATH_MUL_S_32_64 , a, b, c, _STR_S64()
#define _ASSERT32x(a, b, c)     _ASSERT3264 MATH_MUL_SU_32_64, a, b, c, _STR_S64()
.macro _ASSERT3264 i, a, b, c, ptype
    ldi4    r22, \a                           ; Load A
    ldi4    r18, \b                           ; Load B
    rcall   \i                                ; Software multiply 32x32 -> 64-bit
    _STR("  \i 32x32: \a * \b = ")$ \ptype
    cpi8    r18, \c
    brne    0f
    _STR(" _OK\r\n")
    rjmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm

#define _ASSERT64u(a, b, c)     _ASSERT64 MATH_MUL_64_64   , a, b, c, _STR_U64()
#define _ASSERT64s(a, b, c)     _ASSERT64 MATH_MUL_S_64_64 , a, b, c, _STR_S64()
#define _ASSERT64x(a, b, c)     _ASSERT64 MATH_MUL_SU_64_64, a, b, c, _STR_S64()
.macro _ASSERT64 i, a, b, c, ptype
    ldi8    r18, \b                           ; Load B
    mov8    r10, r18
    ldi8    r18, \a                           ; Load A
    rcall   \i                                ; Software multiply 64x64 -> 64-bit
    _STR("  \i 64x64: \a * \b = ")$ \ptype
    cpi8    r18, \c
    brne    0f
    _STR(" _OK\r\n")
    rjmp   1f
  0:
    _STR(" _WRONG!\r\n")
  1:
  _STR_FLUSH()
.endm
