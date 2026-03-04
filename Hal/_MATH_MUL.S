; --- 64-bit (Double Precision) ---
#define MATH_MUL_64_64    __muldi3       ; r25:r18 *= r17:r10

; MATH_MUL_16_16        ; r23:r22 *= r19:r18 - Push/Pop r21:r20
; MATH_MUL_16_32        ; r25:r22 *= r19:r18 - Push/Pop r21:r20
; MATH_MUL_S_16_32      ; r25:r22 *= r19:r18 - Push/Pop r21:r20
; MATH_MUL_SU_16_32     ; r25:r22 *= r19:r18 - Push/Pop r21:r20
; MATH_MUL_32_32        ; r25:r22 *= r21:r18 - Push/Pop r29:r28:r27:r26
; MATH_MUL_32_64        ; r25:r18  = r25:r22 * r21:r18 - Push/Pop r29:r28:r27:r26:r13:r12:r11:r10
; MATH_MAC_16_32        ; r25:r22 += r21:r20 * r19:r18
; MATH_MAC_32_64        ; r25:r18 += r29:r26 * r13:r10


DEFUN MATH_MAC_32_64        ; r25:r18 += r29:r26 * r13:r10
  MATH_MAC_32_64:
        ; -= byte 0 & 1 =-
    mul     r10, r26    ; A0*B0
    add     r18,  r0
    adc     r19,  r1
    adc     r20, r15
    adc     r21, r15
    adc     r22, r15
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
    mul     r11, r26    ; A1*B0
    add     r19,  r0
    adc     r20,  r1
    adc     r21, r15
    adc     r22, r15
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
    mul     r10, r27    ; A0*B1
    add     r19,  r0
    adc     r20,  r1
    adc     r21, r15
    adc     r22, r15
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
        ; -= byte 2 =-
    mul     r11, r27    ; A1*B1
    add     r20,  r0
    adc     r21,  r1
    adc     r22, r15
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
    mul     r12, r26    ; A2*B0
    add     r20,  r0
    adc     r21,  r1
    adc     r22, r15
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
    mul     r10, r28    ; A0*B2
    add     r20,  r0
    adc     r21,  r1
    adc     r22, r15
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
        ; -= byte 3 =-
    mul     r13, r26    ; A3*B0
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
    mul     r10, r29    ; A0*B3
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
    mul     r12, r27    ; A2*B1
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
    mul     r11, r28    ; A1*B2
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
    adc     r25, r15
        ; -= byte 4 =-
    mul     r13, r27    ; A3*B1
    add     r22,  r0
    adc     r23,  r1
    adc     r24, r15
    adc     r25, r15
    mul     r12, r28    ; A2*B2
    add     r22,  r0
    adc     r23,  r1
    adc     r24, r15
    adc     r25, r15
    mul     r11, r29    ; A1*B3
    add     r22,  r0
    adc     r23,  r1
    adc     r24, r15
    adc     r25, r15
        ; -= byte 5 & 6 =-
    mul     r13, r28    ; A3*B2
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15
    mul     r12, r29    ; A2*B3
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15
        ; -= byte 7 =-
    mul     r13, r29
    add     r24,  r0
    adc     r25,  r1

  ret
ENDF MATH_MAC_32_64

DEFUN MATH_MUL_32_64        ; r25:r18 = r25:r22 * r21:r18 - Push/Pop r29:r28:r27:r26:r13:r12:r11:r10
  MATH_MUL_32_64:
    PUSH_MANY r10, r11, r12, r13, r26, r27, r28, r29
    movw    r26, r18        ; mov -> r25:r18 = r13:r10 * r29:r26
    movw    r28, r20        ; and start writing the multiplication right on the return registers
    movw    r10, r22
    movw    r12, r24
    clr          r20
    clr          r21
    clr          r22
    clr          r23
    clr          r24
    clr          r25
        ; -= byte 0 & 1 =-
    mul     r10, r26    ; A0*B0
    movw    r18,  r0
    mul     r11, r26    ; A1*B0
    add     r19,  r0
    adc     r20,  r1
    mul     r10, r27    ; A0*B1
    add     r19,  r0
    adc     r20,  r1
    adc     r21, r15
        ; -= byte 2 =-
    mul     r11, r27    ; A1*B1
    add     r20,  r0
    adc     r21,  r1
    adc     r22, r15
    mul     r12, r26    ; A2*B0
    add     r20,  r0
    adc     r21,  r1
    adc     r22, r15
    mul     r10, r28    ; A0*B2
    add     r20,  r0
    adc     r21,  r1
    adc     r22, r15
        ; -= byte 3 =-
    mul     r13, r26    ; A3*B0
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
    mul     r10, r29    ; A0*B3
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
    mul     r12, r27    ; A2*B1
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
    mul     r11, r28    ; A1*B2
    add     r21,  r0
    adc     r22,  r1
    adc     r23, r15
    adc     r24, r15
        ; -= byte 4 =-
    mul     r13, r27    ; A3*B1
    add     r22,  r0
    adc     r23,  r1
    adc     r24, r15
    adc     r25, r15
    mul     r12, r28    ; A2*B2
    add     r22,  r0
    adc     r23,  r1
    adc     r24, r15
    adc     r25, r15
    mul     r11, r29    ; A1*B3
    add     r22,  r0
    adc     r23,  r1
    adc     r24, r15
    adc     r25, r15
        ; -= byte 5 & 6 =-
    mul     r13, r28    ; A3*B2
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15
    mul     r12, r29    ; A2*B3
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15
        ; -= byte 7 =-
    mul     r13, r29
    add     r24,  r0
    adc     r25,  r1

    POP_MANY r29, r28, r27, r26, r13, r12, r11, r10
  ret
ENDF MATH_MUL_32_64

DEFUN MATH_MUL_32_32        ; r25:r22 *= r21:r18 - Push/Pop r29:r28:r27:r26
  MATH_MUL_32_32:
    PUSH_MANY r26, r27, r28, r29
    movw    r26, r22
    movw    r28, r24

        ; byte 0 - A0*B0
    mul     r26, r18
    movw    r22,  r0
        ; byte 1 - A1*B0
    mul     r27, r18
    add     r23,  r0
    mov     r24,  r1
        ; byte 1 - A0*B1
    mul     r26, r19
    add     r23,  r0
    adc     r24,  r1
    clr          r25
    adc     r25, r15
        ; byte 2 - A1*B1
    mul     r27, r19
    add     r24,  r0
    adc     r25,  r1
    adc     r25, r15
        ; byte 2 - A2*B0
    mul     r28, r18
    add     r24,  r0
    adc     r25,  r1
    adc     r25, r15
        ; byte 2 - A0*B2
    mul     r26, r20
    add     r24,  r0
    adc     r25,  r1
    adc     r25, r15
        ; byte 3 (Lower bytes)
    mul     r29, r18    ; A3*B0
    add     r25,  r0
    mul     r22, r21    ; A0*B3
    add     r25,  r0
    mul     r27, r19    ; A2*B1
    add     r25,  r0
    mul     r27, r20    ; A1*B2
    add     r25,  r0

    POP_MANY r29, r28, r27, r26
  ret
ENDF MATH_MUL_32_32

DEFUN MATH_MUL_16_16        ; r23:r22 *= r19:r18 - Push/Pop r21:r20
  MATH_MUL_16_16:
  PUSH_MANY r20, r21
    mov     r20, r22

    mul     r20, r18        ; al*bl
    movw    r22,  r0
    mul     r20, r19        ; al*bh
    add     r23,  r0
    mul     r21, r18        ; ah*bl
    add     r23,  r0
  POP_MANY r21, r20
  ret
ENDF MATH_MUL_16_16

DEFUN MATH_MUL_16_32        ; r25:r22 *= r19:r18 - Push/Pop r21:r20
  MATH_MUL_16_32:
  PUSH_MANY r20, r21
    movw    r20, r22

    mul     r20, r18        ; al*bl
    movw    r22,  r0
    mul     r21, r19        ; ah*bh
    movw    r24,  r0

    mul     r20, r19        ; al*bh
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15

    mul     r21, r18        ; ah*bl
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15
  POP_MANY r21, r20
  ret
ENDF MATH_MUL_16_32

DEFUN MATH_MUL_SU_16_32     ; r25:r22 *= r19:r18 - Push/Pop r21:r20
  MATH_MUL_SU_16_32:
  PUSH_MANY r20, r21
    movw    r20, r22

    mul     r20, r18        ; al*bl
    movw    r22,  r0
    mulsu   r21, r19        ; ah*bh
    movw    r24,  r0

    mul     r20, r19        ; al*bh
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15

    mulsu   r21, r18        ; ah*bl
    sbc     r25, r15
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15

  POP_MANY r21, r20
  ret
ENDF MATH_MUL_SU_16_32

DEFUN MATH_MUL_S_16_32      ; r25:r22 *= r19:r18 - Push/Pop r21:r20
  MATH_MUL_S_16_32:
  PUSH_MANY r20, r21
    movw    r20, r22

    mul     r20, r18        ; al*bl
    movw    r22,  r0
    muls    r21, r19        ; ah*bh
    movw    r24,  r0

    mulsu   r19, r20        ; bh*al
    sbc     r25, r15
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15

    mulsu   r21, r18        ; ah*bl
    sbc     r25, r15
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15

  POP_MANY r21, r20
  ret
ENDF MATH_MUL_S_16_32

DEFUN MATH_MAC_16_32        ; r25:r22 += r21:r20 * r19:r18 - Push/Pop r21:r20
  MATH_MAC_16_32:
  PUSH_MANY r20, r21
    mul     r20, r18        ; al*bl
    add     r22,  r0
    adc     r23,  r1
    adc     r24, r15
    adc     r25, r15
    mul     r21, r19        ; ah*bh
    add     r24,  r0
    adc     r25,  r1

    mul     r20, r19        ; al*bh
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15

    mul     r21, r18        ; ah*bl
    add     r23,  r0
    adc     r24,  r1
    adc     r25, r15

  POP_MANY r21, r20
  ret
ENDF MATH_MAC_16_32
