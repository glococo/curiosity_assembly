; High-performance Byte Ring Buffer (Circular Buffer) using X Register
; For maximum assembly efficiency, this library use a Power of Two size (e.g., 64, 128, 256).
; This allows use of bitwise AND for wrapping instead of a slow division or comparison.
;
; Define different sized buffers
;   HAL_BBUF_DEFINE UART_TX_BUF, 64
;   HAL_BBUF_DEFINE LOG_BUF, 128
;   HAL_BBUF_DEFINE SENSOR_BUF, 8
;
;   ldi   XL, lo8( SENSOR_BUF )
;   ldi   XH, hi8( SENSOR_BUF )
;   ldi   r18, 8    ; Remember, size always power of 2, max 256 !
;   rcall HAL_BBUF_INIT

.macro HAL_BBUF_DEFINE name, size
    .section .bss
    \name:
        .byte 0                 ; Head
        .byte 0                 ; Tail
        .byte 0                 ; Mask
        .space \size            ; Data storage
    .set \name\()_SIZE, \size   ; Assembler constant
.endm


; Input: r18: size (power of 2), X (r27:r26) points to the Buffer Structure
DEFUN HAL_BBUF_INIT
  HAL_BBUF_INIT:
    st    X+, __zero_reg__
    st    X+, __zero_reg__
    dec   r18
    st    X, r18
    sbiw  X, 2              ; restore X pointer and
    inc   r18               ; r18 input values
  ret
ENDF HAL_BBUF_INIT

; Input: X (r27:r26) points to the Buffer Structure
; Return: r18: 1 if empty, otherwise 0
DEFUN HAL_BBUF_IS_EMPTY
  HAL_BBUF_IS_EMPTY:
  PUSH_MANY r16, r17
    ld      r16, X+         ; r16 = Head
    ld      r17, X          ; r17 = Tail
    sbiw    X, 1            ; Return pointer X intact
    ldi     r18, 1
    cp      r16, r17        ; Check if Empty
    breq    1f
    ldi     r18, 0
  1:
  POP_MANY r17, r16
  ret
ENDF HAL_BBUF_IS_EMPTY

; Input: X (r27:r26) points to the Buffer Structure
; Return: r18: 1 if full, otherwise 0
DEFUN HAL_BBUF_IS_FULL
  HAL_BBUF_IS_FULL:
  PUSH_MANY r16, r17
    ld      r16, X+         ; r16 = Head
    ld      r17, X+         ; r17 = Tail
    ld      r18, X          ; r18 = MASK
    sbiw    X, 2            ; Return pointer X intact

    inc     r16             ; Inc Head
    and     r16, r18        ; Wrap using the stored mask
    ldi     r18, 1          ; r18= 1
    cp      r16, r17        ; If Full
    breq    1f              ;   exit, r18=1
    ldi     r18, 0          ;   else, r18=0
  1:
  POP_MANY r17, r16
  ret
ENDF HAL_BBUF_IS_FULL

; Input: X (r27:r26) points to the Buffer Structure
; Return: r18: size in use
DEFUN HAL_BBUF_IN_USE
  HAL_BBUF_IN_USE:
  PUSH_MANY r16, r17
    ld      r16, X+         ; r16 = Head
    ld      r17, X+         ; r17 = Tail
    ld      r18, X          ; r18 = MASK

    sub     r16, r17
    and     r16, r18
    mov     r18, r16
  POP_MANY r17, r16
  ret
ENDF HAL_BBUF_IN_USE

; Input:  X points to SRAM Buffer, Z points to FLASH .asciz string
; Output: r18 = 0 (Success), 1 (Full)
DEFUN HAL_BBUF_PUSH_FROM_Z
HAL_BBUF_PUSH_FROM_Z:
    PUSH_MANY r16, r17, r19, r20
    ld      r16, X+         ; r16 = Head
    ld      r17, X+         ; r17 = Tail
    ld      r18, X          ; r18 = MASK

    mov     r19, r16        ; Check if full
    inc     r19
    and     r19, r18        ; Wrap using the stored mask
    cp      r19, r17
    breq    1f              ; 1f = Full

    ; Load Z data
    ; Calculate Data Address: (X + 3) + Head
    sbiw     X, 2           ; Go X back -2pos, from MASK to Head
    st       X, r19         ; Update Head
    adiw     X, 3           ; Go X forward +3pos, from Head to DATA
    add     XL, r16         ; Add Head offset
    adc     XH, __zero_reg__
    st       X, r22         ; Store data

    ldi     r18, 0          ; Success
    rjmp    2f
  1:
    ldi     r18, 1          ; Full
  2:
  POP_MANY r19, r17, r16
  ret
ENDF HAL_BBUF_PUSH_FROM_Z

; Input:  X points to Buffer, r22 = Value
; Output: r18 = 0 (Success), 1 (Full)
DEFUN HAL_BBUF_PUSH
HAL_BBUF_PUSH:
    PUSH_MANY r16, r17, r19
    ld      r16, X+         ; r16 = Head
    ld      r17, X+         ; r17 = Tail
    ld      r18, X          ; r18 = MASK

    mov     r19, r16        ; Check if full
    inc     r19
    and     r19, r18        ; Wrap using the stored mask
    cp      r19, r17
    breq    1f              ; 1f = Full

    ; Calculate Data Address: (X + 3) + Head
    sbiw     X, 2           ; Go X back -2pos, from MASK to Head
    st       X, r19         ; Update Head
    adiw     X, 3           ; Go X forward +3pos, from Head to DATA
    add     XL, r16         ; Add Head offset
    adc     XH, __zero_reg__
    st       X, r22         ; Store data

    ldi     r18, 0          ; Success
    rjmp    2f
  1:
    ldi     r18, 1          ; Full
  2:
  POP_MANY r19, r17, r16
  ret
ENDF HAL_BBUF_PUSH

; Input: X points to Buffer
; Output: r22 = Value, r18 = 0 (Success), 1 (Empty)
DEFUN HAL_BBUF_PULL
  HAL_BBUF_PULL:
  PUSH_MANY r16, r17, r19
    ld      r16, X+         ; r16 = Head
    ld      r17, X+         ; r17 = Tail
    ld      r18, X          ; r18 = MASK

    cp      r16, r17        ; Check if Empty
    breq    1f

    mov     r19, r17
    inc     r19             ; Update Tail
    and     r19, r18        ; Wrap using dynamic mask
    sbiw     X, 1           ; Go X back -1pos, from MASK to Tail
    st       X, r19         ; Update Tail

    ; Calculate Data Address: (X + 3) + Tail
    adiw     X, 2           ; Move X pointer from Tail to DATA
    add     XL, r17         ; Add Tail offset
    adc     XH, __zero_reg__
    ld      r22, X          ; Pull byte

    ldi     r18, 0          ; Success
    rjmp    2f

  1:
    ldi     r18, 1          ; Empty
  2:
  POP_MANY r19, r17, r16
  ret
ENDF HAL_BBUF_PULL
