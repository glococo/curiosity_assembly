; ==============================================================================
; Generic Decimal Printing Engine
; ==============================================================================
; Uses a "Divide by 10" algorithm on a byte array (little-endian).
; Supports any size (8, 16, 32, 64 bits etc).
DEFUN Print_Dec_Generic
  Print_Dec_Generic:
    ; Input: X (r27:r26) points to the number (little-endian) r16 is the size in bytes
    PUSH_MANY r16, r17, r28, r29

    mov   r28, r16          ; Preserve size in r28
    clr   r29               ; Digit counter (using YL for convenience, though r29 is YH, let's use r17)
    clr   r17               ; Digit counter

  push_digits_loop:
    rcall ModDiv10_Array    ; Divide number at X by 10. Remainder in r24. Zero-flag in r18.
    subi  r24, -'0'         ; Convert remainder to ASCII
    push  r24               ; Save digit on stack
    inc   r17               ; Count digit

    tst   r18               ; Check if quotient was zero (result of ModDiv10_Array)
    brne  push_digits_loop  ; If not zero, continue
  pop_print_loop:
    pop   r16
    rcall Print_Char
    dec   r17
    brne  pop_print_loop

    POP_MANY r29, r28, r17, r16
    ret
ENDF Print_Dec_Generic

; Helper: Divides the multi-byte number at X by 10.
; Input: X (ptr), r16 (size)
; Output: r24 (Remainder), r18 (Zero flag: 0 if number became 0, !=0 otherwise)

DEFUN ModDiv10_Array
  ModDiv10_Array:
    PUSH_MANY r16, r17, r26, r27, r20, r21, r22, r23, r25
    eor   r1, r1
    add   r26, r16          ; Point to byte AFTER the MSB
    adc   r27, r1           ; (r1 is assumed 0)

    clr   r25               ; Initial remainder (high byte for div)
    clr   r17               ; Accumulator for "is result non-zero"

  div_loop:
    ld    r24, -X           ; Pre-decrement to valid byte, load it.
                            ; Now r25:r24 is (remainder << 8) | byte
    ldi   r22, 10
    ldi   r23, 0

    push  r26               ; Save X around call
    push  r27
    rcall __udivmodhi4      ; r25:r24 = Dividend, r23:r22 = Divisor (10)
                            ; Output: Quotient in r23:r22, Remainder in r25:r24
    pop   r27
    pop   r26

    st    X, r22            ; Store quotient byte back (Low byte of quotient)
    or    r17, r22          ; Accumulate non-zero check

    mov   r25, r24          ; Remainder (Low byte) becomes high byte for next step
    dec   r16
    brne  div_loop

    mov   r24, r25          ; Final remainder to r24 (return value)
    mov   r18, r17          ; Return Zero flag in r18

    POP_MANY r25, r23, r22, r21, r20, r27, r26, r17, r16
    ret
ENDF ModDiv10_Array

; ==============================================================================
; Wrappers for standard integer sizes
; ==============================================================================
DEFUN Print_UInt8
  Print_UInt8:              ; Input: r24
    push  r24

    in    r26, SPL          ; X = Stack Pointer
    in    r27, SPH
    adiw  r26, 1            ; Point to the pushed byte
    ldi   r16, 1            ; Size 1 byte
    rcall Print_Dec_Generic

    pop   r24
    ret
ENDF Print_UInt8

DEFUN Print_UInt16
  Print_UInt16:             ; Input: r25:r24
    push  r25
    push  r24

    in    r26, SPL
    in    r27, SPH
    adiw  r26, 1            ; Point to LSB
    ldi   r16, 2
    rcall Print_Dec_Generic

    pop   r24
    pop   r25
    ret
ENDF Print_UInt16

DEFUN Print_UInt32
  Print_UInt32:             ; Input: r25:r22
    PUSH_MANY r25, r24, r23, r22
    in    r26, SPL
    in    r27, SPH
    adiw  r26, 1
    ldi   r16, 4
    rcall Print_Dec_Generic

    POP_MANY r22, r23, r24, r25
    ret
ENDF Print_UInt32

DEFUN Print_UInt64
  Print_UInt64:             ; Input: r25:r18 (Standard GCC ABI for 64-bit?)
                            ; Actually GCC passes 64-bit in r18..r25 (LSB in r18)
    PUSH_MANY r25, r24, r23, r22, r21, r20, r19, r18
    in    r26, SPL
    in    r27, SPH
    adiw  r26, 1
    ldi   r16, 8
    rcall Print_Dec_Generic

    POP_MANY r18, r19, r20, r21, r22, r23, r24, r25
    ret
ENDF Print_UInt64
