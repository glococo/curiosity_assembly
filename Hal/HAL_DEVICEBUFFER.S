; File: Hal/HAL_DEVICEBUFFER.S
; Description: High-performance Byte Ring Buffer (Circular Buffer).
;              Uses Power-of-Two sizes (2, 4, 8, ..., 256) for optimized wrapping.
;
; Buffer Structure in SRAM:
; [Offset 0] Head (Write index)
; [Offset 1] Tail (Read index)
; [Offset 2] Mask (Size - 1)
; [Offset 3] Device Address L
; [Offset 4] Device Address H
; [Offset 5] Data... (Size bytes)

#define _DEVBUFFER(name,size,dev)  HAL_DEVBUFFER name, size, dev

; Macro: HAL_DEVBUFFER
; Description: Allocates SRAM space for a ring buffer descriptor and data,
;              and Initializes the ring buffer descriptor.
; Inputs:  name - Name of the buffer
;          size - Buffer size (MUST be power of two)
;          dev  - 16-bit device address (e.g., USART0_ADDR)
.macro HAL_DEVBUFFER name, size, dev
  .pushsection .bss
    \name:
        .byte 0                         ; Head index
        .byte 0                         ; Tail index
        .byte 0                         ; Mask (size-1)
        .word 0                         ; Device Base Address (16-bit)
        .space (\size)                  ; Data storage area
    .set \name\()_SIZE, (\size-1)       ; Assembler constant for mask
    .set \name\()_ADDRL, \dev & 0xFF  ; Assembler constant for addrL
    .set \name\()_ADDRH, (\dev >> 8)  ; Assembler constant for addrH
  .popsection
  PUSH r18
    ldi2  ZL, \name
    st    Z, __zero_reg__               ; Reset Head = 0
    std   Z+1, __zero_reg__             ; Reset Tail = 0
    ldi   r18, \name\()_SIZE
    std   Z+2, r18                      ; Store Mask
    ldi   r18, \name\()_ADDRL
    std   Z+3, r18                      ; Store Device Address L
    ldi   r18, \name\()_ADDRH
    std   Z+4, r18                      ; Store Device Address H
  POP r18
.endm

; Function: HAL_DEVICEBUFFER_PUSH
; Description: Adds a single byte to the buffer.
; Inputs:    Z - Points to Buffer Structure
;          r22 - Value to store
; Outputs:  Carry clear: Full, Carry Set: Success
FUNC HAL_DEVICEBUFFER_PUSH
  PUSH_MANY r24, r25, XL, XH
    ld      r25, Z                      ; r25 = Current Head
    ldd     r26, Z+1                    ; r26 = Current Tail
    ldd     r27, Z+2                    ; r27 = Mask

    mov     r24, r25                    ; Save previous head
    inc     r25                         ; Next Head = (Head + 1)
    and     r25, r27                    ; Next Head &= Mask
    cp      r25, r26                    ; Is it Full? (Next Head == Tail)
    breq    0f                          ; Exit if full (clear carry SREG)

    movw    X, Z
    adiw    X, 5                        ; Offset to Data start
    add     XL, r24                     ; Add Head offset
    adc     XH, __zero_reg__            ; Handle carry
    st      X, r22                      ; Write data to buffer
    st      Z, r25                      ; Update Head in descriptor
    sec                                 ; Set Carry: Success
  0:
  POP_MANY XH, XL, r25, r24
ENDF HAL_DEVICEBUFFER_PUSH

; Function: HAL_DEVICEBUFFER_PULL
; Description: Removes a single byte from the buffer.
; Inputs:    Z - Points to Buffer Structure
; Outputs: r22 - Value retrieved
;          Carry clear: Empty, Carry Set: Success
FUNC HAL_DEVICEBUFFER_PULL
  PUSH_MANY r24, r25, XL, XH
    ld      r26, Z                      ; r26 = Current Head
    ldd     r25, Z+1                    ; r25 = Current Tail
    ldd     r27, Z+2                    ; r27 = Mask

    cp      r26, r25                    ; Is it Empty? (Head == Tail)
    breq    0f                          ; Exit if empty (clear carry SREG)

    mov     r24, r25                    ; Calculate Next Tail
    inc     r24                         ; Next Tail = (Tail + 1)
    and     r24, r27                    ; Next Tail &= Mask

    movw    X, Z
    adiw    X, 5                        ; Offset to Data start
    add     XL, r25                     ; Add Tail offset
    adc     XH, __zero_reg__            ; Handle carry
    ld      r22, X                      ; Read data from buffer
    std     Z+1, r24                    ; Update Tail in descriptor
    sec                                 ; Set Carry: Success
  0:
  POP_MANY XH, XL, r25, r24
ENDF HAL_DEVICEBUFFER_PULL

; Function: HAL_DEVICEBUFFER_IS_EMPTY
; Description: Checks if the buffer has no data.
; Inputs:    Z - Points to Buffer Structure
;          Carry clear: Empty, Carry Set: Success
FUNC HAL_DEVICEBUFFER_IS_EMPTY
  PUSH_MANY r18, r19
    ld      r18, Z                      ; r18 = Head
    ldd     r19, Z+1                    ; r19 = Tail
    cp      r18, r19                    ; Compare Head and Tail
    breq    1f                          ; If Head == Tail, it's empty (clear carry SREG)
    sec
  1:
  POP_MANY r19, r18
ENDF HAL_DEVICEBUFFER_IS_EMPTY

; Function: HAL_DEVICEBUFFER_IS_FULL
; Description: Checks if the buffer is at capacity.
; Inputs:   Z - Points to Buffer Structure
;          Carry clear: Full, Carry Set: not Full
FUNC HAL_DEVICEBUFFER_IS_FULL
  PUSH_MANY r18, r19, r20
    ld      r18, Z                      ; r18 = Head
    ldd     r19, Z+1                    ; r19 = Tail
    ldd     r20, Z+2                    ; r20 = Mask
    inc     r18                         ; Calculate Next Head
    and     r18, r20                    ; Wrap around
    cp      r18, r19                    ; Compare with Tail
    breq    0f                          ; If Next Head == Tail, it's full (clear carry SREG)
    sec                                 ; Otherwise, not full
  0:
  POP_MANY r20, r19, r18
ENDF HAL_DEVICEBUFFER_IS_FULL

; Function: HAL_DEVICEBUFFER_IN_USE
; Description: Calculates how many bytes are currently stored in the buffer.
; Inputs:    Z - Points to Buffer Structure
; Outputs: r18 - Number of bytes used
FUNC HAL_DEVICEBUFFER_IN_USE
  PUSH_MANY r19, r20
    ld      r18, Z                      ; r18 = Head
    ldd     r19, Z+1                    ; r19 = Tail
    ldd     r20, Z+2                    ; r20 = Mask
    sub     r18, r19                    ; Diff = Head - Tail
    and     r18, r20                    ; Apply Mask for wrap-around
  POP_MANY r20, r19
ENDF HAL_DEVICEBUFFER_IN_USE
