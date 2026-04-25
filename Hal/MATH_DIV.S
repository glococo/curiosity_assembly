; File: Hal/MATH_DIV.S
; Description: Multi-byte division and modulo routines for 8, 16, and 32-bit integers.
;              Provides both signed and unsigned variants.
;              Note: In these routines, the dividend is replaced by the quotient,
;              and the divisor is replaced by the remainder (modulo).
;
; Example Usage:
;   ldi     r22, 100
;   ldi     r18, 7
;   call   MATH_UDIV_08             ; r22 = 14 (Quotient), r18 = 2 (Remainder)

; Function: MATH_SDIV_32
; Description: Signed 32-bit / 32-bit division and modulo.
; Inputs:  r25:r22 - Dividend (A)
;          r21:r18 - Divisor (B)
; Outputs: r25:r22 - Quotient (A / B)
;          r21:r18 - Remainder (A % B)
FUNC MATH_SDIV_32
  PUSH_MANY r16, r17
    clr     r16                         ; Sign Storage (bit 0: Quot, bit 1: Rem)

    ; 1. Check Dividend Sign
    tst     r25                         ; Check MSB of dividend
    brpl    _check_divisor              ; If positive, skip negation
    ori     r16, 0x03                   ; Set both bit 0 and bit 1

    ; Negate Dividend (Absolute Value)
    com     r25
    com     r24
    com     r23
    neg     r22
    sbci    r23, lo8(-1)
    sbci    r24, lo8(-1)
    sbci    r25, lo8(-1)

  _check_divisor:
    tst     r21                         ; Check MSB of divisor
    brpl    _do_unsigned_div            ; If positive, skip negation
    ldi     r17, 1
    eor     r16, r17                    ; Flip Quotient sign bit

    ; Negate Divisor (Absolute Value)
    com     r21
    com     r20
    com     r19
    neg     r18
    sbci    r19, lo8(-1)
    sbci    r20, lo8(-1)
    sbci    r21, lo8(-1)

  _do_unsigned_div:
    call   MATH_UDIV_32                ; Perform core unsigned division

    ; 2. Correct Quotient Sign
    sbrs    r16, 0                      ; Check if result should be negative
    jmp    _correct_remainder

    ; Negate Quotient
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
    jmp    _sdiv32_done

    ; Negate Remainder
    com     r21
    com     r20
    com     r19
    neg     r18
    sbci    r19, lo8(-1)
    sbci    r20, lo8(-1)
    sbci    r21, lo8(-1)

  _sdiv32_done:
  POP_MANY r17, r16
ENDF MATH_SDIV_32

; Function: MATH_UDIV_32
; Description: Unsigned 32-bit / 32-bit division and modulo.
; Inputs:  r25:r22 - Dividend (A)
;          r21:r18 - Divisor (B)
; Outputs: r25:r22 - Quotient (A / B)
;          r21:r18 - Remainder (A % B)
FUNC MATH_UDIV_32
  PUSH_MANY r17, r26, r27, r28, r29
    clr     r26                         ; Clear temp remainder (r29:r26)
    clr     r27
    clr     r28
    clr     r29
    ldi     r17, 32                     ; Loop counter for 32 bits

  _udiv32_loop:
    lsl     r22                         ; Shift Dividend/Quotient left
    rol     r23
    rol     r24
    rol     r25

    rol     r26                         ; Shift MSB into Temp Remainder
    rol     r27
    rol     r28
    rol     r29

    ; Compare Temp Remainder with Divisor
    cp      r26, r18
    cpc     r27, r19
    cpc     r28, r20
    cpc     r29, r21

    brcs    _udiv32_next                ; If Remainder < Divisor, skip sub

    ; Subtraction: Remainder -= Divisor
    sub     r26, r18
    sbc     r27, r19
    sbc     r28, r20
    sbc     r29, r21
    ori     r22, 1                      ; Set lowest bit of Quotient

  _udiv32_next:
    dec     r17
    brne    _udiv32_loop

    ; Move Remainder into output registers
    mov     r18, r26
    mov     r19, r27
    mov     r20, r28
    mov     r21, r29
  POP_MANY r29, r28, r27, r26, r17
ENDF MATH_UDIV_32

; Function: MATH_SDIV_16
; Description: Signed 16-bit / 16-bit division and modulo.
; Inputs:  r23:r22 - Dividend (A)
;          r19:r18 - Divisor (B)
; Outputs: r23:r22 - Quotient (A / B)
;          r19:r18 - Remainder (A % B)
FUNC MATH_SDIV_16
    PUSH_MANY r20, r21, r24, r25
    mov     r21, r23                    ; Sign Storage
    eor     r21, r19                    ; Quotient Sign
    sbrs    r23, 7                      ; Absolute Dividend
    jmp    d16_16s_1
    com     r23
    com     r22
    subi    r22, lo8(-1)
    sbci    r23, hi8(-1)
  d16_16s_1:
    sbrs    r19, 7                      ; Absolute Divisor
    jmp    d16_16s_2
    com     r19
    com     r18
    subi    r18, lo8(-1)
    sbci    r19, hi8(-1)
  d16_16s_2:
    clr     r24                         ; Clear Remainder
    clr     r25
    ldi     r20, 17                     ; Loop counter (16 bits + 1)
  d16_16s_3:
    rol     r22                         ; Shift dividend
    rol     r23
    dec     r20
    brne    d16_16s_5                   ; Loop until done
    sbrs    r21, 7                      ; Correct Quotient Sign
    jmp    d16_16s_4
    com     r23
    com     r22
    subi    r22, lo8(-1)
    sbci    r23, hi8(-1)
  d16_16s_4:
    movw    r18, r24                    ; Return Remainder
    POP_MANY r25, r24, r21, r20
    ret
  d16_16s_5:
    rol     r24                         ; Shift into remainder
    rol     r25
    sub     r24, r18                    ; Try subtract
    sbc     r25, r19
    brcc    d16_16s_6                   ; If result positive
    add     r24, r18                    ; Else restore
    adc     r25, r19
    clc                                 ; Shift 0 into quotient
    jmp    d16_16s_3
  d16_16s_6:
    sec                                 ; Shift 1 into quotient
    jmp    d16_16s_3
ENDF MATH_SDIV_16

; Function: MATH_UDIV_16
; Description: Unsigned 16-bit / 16-bit division and modulo.
; Inputs:  r23:r22 - Dividend (A)
;          r19:r18 - Divisor (B)
; Outputs: r23:r22 - Quotient (A / B)
;          r19:r18 - Remainder (A % B)
FUNC MATH_UDIV_16
    PUSH_MANY r20, r24, r25
    clr     r24                         ; Clear Remainder
    clr     r25
    ldi     r20, 17                     ; Loop counter
  d16_16u_1:
    rol     r22
    rol     r23
    dec     r20
    brne    d16_16u_2
    movw    r18, r24                    ; Return Remainder
    POP_MANY r25, r24, r20
    ret
  d16_16u_2:
    rol     r24
    rol     r25
    sub     r24, r18
    sbc     r25, r19
    brcc    d16_16u_3
    add     r24, r18
    adc     r25, r19
    clc
    jmp    d16_16u_1
  d16_16u_3:
    sec
    jmp    d16_16u_1
ENDF MATH_UDIV_16

; Function: MATH_UDIV_08
; Description: Unsigned 8-bit / 8-bit division and modulo.
; Inputs:  r22 - Dividend (A)
;          r18 - Divisor (B)
; Outputs: r22 - Quotient (A / B)
;          r18 - Remainder (A % B)
FUNC MATH_UDIV_08
    PUSH_MANY r19, r23
    clr     r23                         ; Clear Remainder
    ldi     r19, 9                      ; Loop counter
  d8_8_1:
    rol     r22
    dec     r19
    brne    d8_8_2
    mov     r18, r23                    ; Return Remainder
    POP_MANY r23, r19
    ret
  d8_8_2:
    rol     r23
    sub     r23, r18
    brcc    d8_8_3
    add     r23, r18
    clc
    jmp    d8_8_1
  d8_8_3:
    sec
    jmp    d8_8_1
ENDF MATH_UDIV_08

; Function: MATH_SDIV_08
; Description: Signed 8-bit / 8-bit division and modulo.
; Inputs:  r22 - Dividend (A)
;          r18 - Divisor (B)
; Outputs: r22 - Quotient (A / B)
;          r18 - Remainder (A % B)
FUNC MATH_SDIV_08
    PUSH_MANY r19, r20, r23
    mov     r20, r22                    ; Sign Storage
    eor     r20, r18
    sbrc    r18, 7                      ; Absolute Divisor
    neg     r18
    sbrc    r22, 7                      ; Absolute Dividend
    neg     r22
    clr     r23                         ; Clear Remainder
    ldi     r19, 9                      ; Loop counter
  d8_8s_1:
    rol     r22
    dec     r19
    brne    d8_8s_2
    sbrc    r20, 7                      ; Correct Quotient Sign
    neg     r22
    mov     r18, r23                    ; Return Remainder
    POP_MANY r23, r20, r19
    ret
  d8_8s_2:
    rol     r23
    sub     r23, r18
    brcc    d8_8s_3
    add     r23, r18
    clc
    jmp    d8_8s_1
  d8_8s_3:
    sec
    jmp    d8_8s_1
ENDF MATH_SDIV_08
