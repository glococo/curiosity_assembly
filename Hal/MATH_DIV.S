; Division and Modulo: The dividend is replaced by the remainder, and the divisor is usually replaced by the quotient.
; MATH_UDIV_08_08       ; r22 /= r18 - Remainder on Divisor (r18)
; MATH_SDIV_08_08       ; r22 /= r18 - Remainder on Divisor (r18)
; MATH_UDIV_16_16       ; r23:r22 /= r19:r18 - Remainder/Modulo on Divisor
; MATH_SDIV_16_16       ; r23:r22 /= r19:r18 - Remainder/Modulo on Divisor
; MATH_UDIV_32_32       ; r25:r22 /= r21:r18 - Remainder/Modulo on Divisor
; MATH_SDIV_32_32       ; r25:r22 /= r21:r18 - Remainder/Modulo on Divisor

; Previously linked lib-gcc functions
; #define MATH_UDIV_24_24 __udivmodpsi4   ; r25:r23=Rem, r22:r20=Quot = r25:r23 / r22:r20
; #define MATH_UDIV_32_32 __udivmodsi4    ; r25:r22=Rem, r21:r18=Quot = r25:r22 / r21:r18
; Division and Modulo (Signed): These handle two's complement signed integers
; #define MATH_SDIV_24_24   __divmodpsi4  ; r25:r23=Rem, r22:r20=Quot = r25:r23 / r22:r20 (Signed)
; #define MATH_SDIV_32_32   __divmodsi4   ; r25:r22=Rem, r21:r18=Quot = r25:r22 / r21:r18 (Signed)

DEFUN MATH_SDIV_32_32       ; r25:r22 /= r21:r18 - Remainder/Modulo on Divisor
  MATH_SDIV_32_32:
  PUSH_MANY r16, r17
    clr     r16             ; Sign Storage
    ; bit 0: Final Quotient Sign (Dividend Sign XOR Divisor Sign)
    ; bit 1: Final Remainder Sign (Matches Dividend Sign)

    ; 1. Check Dividend Sign
    tst     r25
    brpl    _check_divisor
    ori     r16, 0x03       ; Set both bit 0 and bit 1

    ; Negate Dividend (r25:r22) to get Absolute Value
    com     r25
    com     r24
    com     r23
    neg     r22
    sbci    r23, lo8(-1)
    sbci    r24, lo8(-1)
    sbci    r25, lo8(-1)

  _check_divisor:
    tst     r21
    brpl    _do_unsigned_div
    ldi     r17, 1
    eor     r16, r17        ; Flip Quotient sign bit

    ; Negate Divisor (r21:r18) to get Absolute Value
    com     r21
    com     r20
    com     r19
    neg     r18
    sbci    r19, lo8(-1)
    sbci    r20, lo8(-1)
    sbci    r21, lo8(-1)

  _do_unsigned_div:
    rcall   MATH_UDIV_32_32 ; Run your core 32/32 engine

    ; 2. Correct Quotient Sign
    sbrs    r16, 0
    rjmp    _correct_remainder

    ; Negate Quotient (r25:r22)
    com     r25
    com     r24
    com     r23
    neg     r22
    sbci    r23, lo8(-1)
    sbci    r24, lo8(-1)
    sbci    r25, lo8(-1)

  _correct_remainder:
    ; 3. Correct Remainder Sign (Matches Dividend)
    sbrs    r16, 1
    ret

    ; Negate Remainder (r21:r18)
    com     r21
    com     r20
    com     r19
    neg     r18
    sbci    r19, lo8(-1)
    sbci    r20, lo8(-1)
    sbci    r21, lo8(-1)
  POP_MANY r17, r16
  ret
ENDF MATH_SDIV_32_32

DEFUN MATH_UDIV_32_32       ; r25:r22 /= r21:r18 - Remainder/Modulo on Divisor
  MATH_UDIV_32_32:
  PUSH_MANY r17, r26, r27, r28, r29
    clr     r26             ; Clear temp remainder (Low to High)
    clr     r27
    clr     r28
    clr     r29
    ldi     r17, 32         ; Set loop counter for 32 bits

  _udiv32_loop:
    ; 1. Shift Dividend/Quotient left. MSB goes into Carry.
    lsl     r22
    rol     r23
    rol     r24
    rol     r25

    ; 2. Shift Carry into the Temp Remainder
    rol     r26
    rol     r27
    rol     r28
    rol     r29

    ; 3. Compare Temp Remainder with Divisor (r29:r26 vs r21:r18)
    cp      r26, r18
    cpc     r27, r19
    cpc     r28, r20
    cpc     r29, r21

    ; 4. If Remainder < Divisor, skip subtraction
    brcs    _udiv32_next

    ; 5. Subtraction: Remainder = Remainder - Divisor
    sub     r26, r18
    sbc     r27, r19
    sbc     r28, r20
    sbc     r29, r21

    ; 6. Set the lowest bit of the Quotient (which is in r22)
    ori     r22, 1

  _udiv32_next:
    dec     r17
    brne    _udiv32_loop

    ; 7. Move the Remainder into the requested Divisor registers
    mov     r18, r26
    mov     r19, r27
    mov     r20, r28
    mov     r21, r29
  POP_MANY r29, r28, r27, r26, r17
  ret
ENDF MATH_UDIV_32_32

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
