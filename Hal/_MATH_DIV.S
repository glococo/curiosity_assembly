; Division and Modulo: The dividend is replaced by the remainder, and the divisor is usually replaced by the quotient.
; MATH_UDIV_08_08       ; r22 /= r18 - Remainder on Divisor (r18)
; MATH_SDIV_08_08       ; r22 /= r18 - Remainder on Divisor (r18)
; MATH_UDIV_16_16       ; r23:r22 /= r19:r18 - Remainder on Divisor (r18)
; MATH_SDIV_16_16       ; r23:r22 /= r19:r18 - Remainder on Divisor (r18)


; #define MATH_UDIV_08_08 __udivmodqi4    ;     r24=Rem,     r25=Quot =     r24 / r22
#define MATH_UDIV_24_24 __udivmodpsi4   ; r25:r23=Rem, r22:r20=Quot = r25:r23 / r22:r20
#define MATH_UDIV_32_32 __udivmodsi4    ; r25:r22=Rem, r21:r18=Quot = r25:r22 / r21:r18

; Division and Modulo (Signed): These handle two's complement signed integers
#define MATH_SDIV_24_24   __divmodpsi4  ; r25:r23=Rem, r22:r20=Quot = r25:r23 / r22:r20 (Signed)
#define MATH_SDIV_32_32   __divmodsi4   ; r25:r22=Rem, r21:r18=Quot = r25:r22 / r21:r18 (Signed)

DEFUN MATH_SDIV_16_16       ; r23:r22 /= r19:r18 - Remainder on Divisor
  MATH_SDIV_16_16:
    PUSH_MANY r20, r21, r24, r25
    mov     r21, r23        ;move dividend High to sign register
    eor     r21, r19        ;xor divisor High with sign register
    sbrs    r23, 7          ;if MSB in dividend set
    rjmp    d16_16s_1
    com     r23             ;    change sign of dividend
    com     r22
    subi    r22, lo8(-1)
    sbci    r22, hi8(-1)
  d16_16s_1:
    sbrs    r19, 7          ;if MSB in divisor set
    rjmp    d16_16s_2
    com     r19             ;    change sign of divisor
    com     r18
    subi    r18, lo8(-1)
    sbci    r19, hi8(-1)
  d16_16s_2:
    clr     r24             ;clear remainder Low byte
    sub     r25, r25        ;clear remainder High byte and carry
    ldi     r20, 17         ;init loop counter
  d16_16s_3:
    rol     r22             ;shift left dividend
    rol     r23
    dec     r20             ;decrement counter
    brne    d16_16s_5       ;if done
    sbrs    r21, 7          ;    if MSB in sign register set
    rjmp    d16_16s_4
    com     r23             ;        change sign of result
    com     r22
    subi    r22, lo8(-1)
    sbci    r23, hi8(-1)
  d16_16s_4:
    movw    r18, r24
    POP_MANY r25, r24, r21, r20
    ret                     ;    return
  d16_16s_5:
    rol     r24             ;shift dividend into remainder
    rol     r25
    sub     r24, r18        ;remainder = remainder - divisor
    sbc     r25, r19        ;
    brcc    d16_16s_6       ;if result negative
    add     r24, r18        ;    restore remainder
    adc     r25, r19
    clc                     ;    clear carry to be shifted into result
    rjmp    d16_16s_3       ;else
  d16_16s_6:
    sec                     ;    set carry to be shifted into result
    rjmp    d16_16s_3
ENDF MATH_SDIV_16_16

DEFUN MATH_UDIV_16_16       ; r23:r22 /= r19:r18 - Remainder on Divisor
  MATH_UDIV_16_16:
    PUSH_MANY r20, r24, r25
    clr     r24             ;clear remainder Low byte
    sub     r25, r25        ;clear remainder High byte and carry
    ldi     r20, 17         ;init loop counter
  d16_16u_1:
    rol     r22             ;shift left dividend
    rol     r23
    dec     r20             ;decrement counter
    brne    d16_16u_2       ;if done
    movw    r18, r24        ;(move remainder to divisor)
    POP_MANY r25, r24, r20
    ret                     ;    return
  d16_16u_2:
    rol     r24             ;shift dividend into remainder
    rol     r25
    sub     r24, r18        ;remainder = remainder - divisor
    sbc     r25, r19        ;
    brcc    d16_16u_3       ;if result negative
    add     r24, r18        ;    restore remainder
    adc     r25, r19
    clc                     ;    clear carry to be shifted into result
    rjmp    d16_16u_1       ;else
  d16_16u_3:
    sec                     ;    set carry to be shifted into result
    rjmp    d16_16u_1
ENDF MATH_UDIV_16_16

DEFUN MATH_UDIV_08_08       ; r22 /= r18 - Remainder on r18
  MATH_UDIV_08_08:
    PUSH_MANY r19, r23
    sub     r23, r23        ; clear remainder and carry
    ldi     r19, 9          ; init loop counter
  d8_8_1:
    rol     r22             ; shift left dividend
    dec     r19             ; decrement counter
    brne    d8_8_2          ; if done
    mov     r18, r23
    POP_MANY r23, r19
    ret                     ;    return
  d8_8_2:
    rol     r23             ; shift dividend into remainder
    sub     r23,r18         ; remainder = remainder - divisor
    brcc    d8_8_3          ; if result negative
    add     r23, r18        ;    restore remainder
    clc                     ;    clear carry to be shifted into result
    rjmp    d8_8_1          ; else
  d8_8_3:
    sec                     ;    set carry to be shifted into result
    rjmp    d8_8_1
ENDF MATH_UDIV_08_08

DEFUN MATH_SDIV_08_08       ; r22 /= r18 - Remainer on r18 Destroy r20, r19
  MATH_SDIV_08_08:
    PUSH_MANY r19, r20, r23
    mov     r20, r22        ;move dividend to sign register
    eor     r20, r18        ;xor sign with divisor
    sbrc    r18, 7          ;if MSB of divisor set
    neg     r18             ;    change sign of divisor
    sbrc    r22, 7          ;if MSB of dividend set
    neg     r22             ;    change sign of divisor
    sub     r23, r23        ;clear remainder and carry
    ldi     r19, 9          ;init loop counter
  d8_8s_1:
    rol     r22             ;shift left dividend
    dec     r19             ;decrement counter
    brne    d8_8s_2         ;if done
    sbrc    r20, 7          ;    if MSB of sign register set
    neg     r22             ;        change sign of result
    mov     r18, r23
    POP_MANY r23, r20, r19
    ret                     ;    return
  d8_8s_2:
    rol     r23             ;shift dividend into remainder
    sub     r23, r18        ;remainder = remainder - divisor
    brcc    d8_8s_3         ;if result negative
    add     r23, r18        ;    restore remainder
    clc                     ;    clear carry to be shifted into result
    rjmp    d8_8s_1         ;else
  d8_8s_3:
    sec                     ;    set carry to be shifted into result
    rjmp    d8_8s_1
ENDF MATH_SDIV_08_08
