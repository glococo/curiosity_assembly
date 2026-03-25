; File: Hal/HAL_DEVICEBUFFER.S
; Description: High-performance Byte Ring Buffer (Circular Buffer).
;              Uses Power-of-Two sizes (2, 4, 8, ..., 256) for optimized wrapping.
;
; Example Usage:
;   HAL_DEVICEBUFFER_DEFINE  my_buf, 64, USART0_ADDR
;   HAL_DEVICEBUFFER_INIT    my_buf
;
;   ldi     ZL, lo8(my_buf)
;   ldi     ZH, hi8(my_buf)
;   ldi     r22, 'A'
;   rcall   HAL_DEVICEBUFFER_PUSH       ; Push 'A' to buffer
;
; Buffer Structure in SRAM:
; [Offset 0] Head (Write index)
; [Offset 1] Tail (Read index)
; [Offset 2] Mask (Size - 1)
; [Offset 3] Device Address L
; [Offset 4] Device Address H
; [Offset 5] Data... (Size bytes)

; Macro: HAL_DEVICEBUFFER_DEFINE
; Description: Allocates SRAM space for a ring buffer descriptor and data.
; Inputs:  name  - Name of the buffer
;          size  - Buffer size (MUST be power of two)
;          devID - 16-bit device address (e.g., USART0_ADDR)
; Outputs: None
.macro HAL_DEVICEBUFFER_DEFINE name, size, devID
    .section .bss
    \name:
        .byte 0                         ; Head index
        .byte 0                         ; Tail index
        .byte 0                         ; Mask (size-1)
        .word 0                         ; Device Base Address (16-bit)
        .space (\size)                  ; Data storage area
    .set \name\()_SIZE, (\size-1)       ; Assembler constant for mask
    .set \name\()_ADDRL, \devID & 0xFF  ; Assembler constant for addrL
    .set \name\()_ADDRH, (\devID >> 8)  ; Assembler constant for addrH
.endm

; Macro: HAL_DEVICEBUFFER_INIT
; Description: Initializes the ring buffer descriptor.
; Inputs:  name - Name of the buffer defined with HAL_DEVICEBUFFER_DEFINE
; Outputs: None
.macro HAL_DEVICEBUFFER_INIT name
  PUSH r18
    ldi   ZL, lo8( \name )
    ldi   ZH, hi8( \name )
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
; Inputs:  Z   - Points to Buffer Structure
;          r22 - Value to store
; Outputs: r18 - 0: Success, 1: Buffer Full
FUNC HAL_DEVICEBUFFER_PUSH
  PUSH_MANY r19, r20, r21, ZL, ZH
    ld      r20, Z                      ; r20 = Current Head
    ldd     r19, Z+1                    ; r19 = Current Tail
    ldd     r18, Z+2                    ; r18 = Mask

    mov     r21, r20                    ; Calculate Next Head
    inc     r21                         ; Next Head = (Head + 1)
    and     r21, r18                    ; Next Head &= Mask
    cp      r21, r19                    ; Is it Full? (Next Head == Tail)
    ldi     r18, 1                      ; Pre-load return status "Full"
    breq    0f                          ; Exit if full

    st      Z, r21                      ; Update Head in descriptor
    adiw    Z, 5                        ; Offset to Data start
    add     ZL, r20                     ; Add Head offset
    adc     ZH, __zero_reg__            ; Handle carry
    st      Z, r22                      ; Write data to buffer
    ldi     r18, 0                      ; Return status "Success"
  0:
  POP_MANY ZH, ZL, r21, r20, r19
ENDF HAL_DEVICEBUFFER_PUSH

; Function: HAL_DEVICEBUFFER_PULL
; Description: Removes a single byte from the buffer.
; Inputs:  Z   - Points to Buffer Structure
; Outputs: r22 - Value retrieved
;          r18 - 0: Success, 1: Buffer Empty
FUNC HAL_DEVICEBUFFER_PULL
  PUSH_MANY r19, r20, r21, ZL, ZH
    ld      r18, Z                      ; r18 = Current Head
    ldd     r19, Z+1                    ; r19 = Current Tail
    ldd     r20, Z+2                    ; r20 = Mask

    cp      r18, r19                    ; Is it Empty? (Head == Tail)
    ldi     r18, 1                      ; Pre-load return status "Empty"
    breq    0f                          ; Exit if empty

    mov     r21, r19                    ; Calculate Next Tail
    inc     r21                         ; Next Tail = (Tail + 1)
    and     r21, r20                    ; Next Tail &= Mask
    std     Z+1, r21                    ; Update Tail in descriptor

    adiw    Z, 5                        ; Offset to Data start
    add     ZL, r19                     ; Add Tail offset
    adc     ZH, __zero_reg__            ; Handle carry
    ld      r22, Z                      ; Read data from buffer
    ldi     r18, 0                      ; Return status "Success"
  0:
  POP_MANY ZH, ZL, r21, r20, r19
ENDF HAL_DEVICEBUFFER_PULL

; Function: HAL_DEVICEBUFFER_IS_EMPTY
; Description: Checks if the buffer has no data.
; Inputs:  Z   - Points to Buffer Structure
; Outputs: r18 - 1: Empty, 0: Not Empty
FUNC HAL_DEVICEBUFFER_IS_EMPTY
  PUSH r19
    ld      r18, Z                      ; r18 = Head
    ldd     r19, Z+1                    ; r19 = Tail
    cp      r18, r19                    ; Compare Head and Tail
    ldi     r18, 1                      ; Assume Empty
    breq    1f                          ; If Head == Tail, it's empty
    ldi     r18, 0                      ; Otherwise, not empty
  1:
  POP r19
ENDF HAL_DEVICEBUFFER_IS_EMPTY

; Function: HAL_DEVICEBUFFER_IS_FULL
; Description: Checks if the buffer is at capacity.
; Inputs:  Z   - Points to Buffer Structure
; Outputs: r18 - 1: Full, 0: Not Full
FUNC HAL_DEVICEBUFFER_IS_FULL
  PUSH_MANY r19, r20
    ld      r18, Z                      ; r18 = Head
    ldd     r19, Z+1                    ; r19 = Tail
    ldd     r20, Z+2                    ; r20 = Mask
    inc     r18                         ; Calculate Next Head
    and     r18, r20                    ; Wrap around
    cp      r18, r19                    ; Compare with Tail
    ldi     r18, 1                      ; Assume Full
    breq    1f                          ; If Next Head == Tail, it's full
    ldi     r18, 0                      ; Otherwise, not full
  1:
  POP_MANY r20, r19
ENDF HAL_DEVICEBUFFER_IS_FULL

; Function: HAL_DEVICEBUFFER_IN_USE
; Description: Calculates how many bytes are currently stored in the buffer.
; Inputs:  Z   - Points to Buffer Structure
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
