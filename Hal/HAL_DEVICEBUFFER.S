; File: Hal/HAL_DEVICEBUFFER.S
; Description: High-performance Byte Ring Buffer (Circular Buffer).
;
; This library uses a Power-of-Two size (64, 128, 256) to allow bitwise masking
; for head/tail wrapping, avoiding slow division or conditional branches.
;
; Buffer Structure in SRAM:
; [Offset 0] Head (Write index)
; [Offset 1] Tail (Read index)
; [Offset 2] Mask (Size - 1)
; [Offset 3] Device Address L (USART0_RXDATAL, SPI0_CTRLA, ...)
; [Offset 4] Device Address H (USART0_RXDATAL, SPI0_CTRLA, ...)
; [Offset 5] Data... (Size bytes)

; Macro: HAL_DEVICEBUFFER_DEFINE
; Description: Allocates SRAM space for a ring buffer.
.macro HAL_DEVICEBUFFER_DEFINE name, size, devID
    .section .bss
    \name:
        .byte 0                     ; Head
        .byte 0                     ; Tail
        .byte 0                     ; Mask
        .byte 0, 0                  ; Device Base Addr
        .space (\size)              ; Data storage
    .set \name\()_SIZE, (\size-1)                 ; Assembler constant for size
    .set \name\()_ADDRL, \devID & 0xFF            ; Assembler constant for addrL
    .set \name\()_ADDRH, ( \devID & 0xFF00 )>>8   ; Assembler constant for addrH
.endm

; Macro: HAL_DEVICEBUFFER_INIT
; Description: Prepares a ring buffer for use (calculates mask).
; Input: name - Name of the buffer defined with HAL_DEVICEBUFFER_DEFINE.
.macro HAL_DEVICEBUFFER_INIT name
  PUSH r18
    ldi   ZL, lo8( \name )
    ldi   ZH, hi8( \name )
    st    Z, __zero_reg__          ; Reset Head
    std   Z+1, __zero_reg__        ; Reset Tail
    ldi   r18, \name\()_SIZE
    std   Z+2, r18                 ; Store Mask
    ldi   r18, \name\()_ADDRL
    std   Z+3, r18                 ; Store 16bit Device Address Low
    ldi   r18, \name\()_ADDRH
    std   Z+4, r18                 ; Store 16bit Device Address High
  POP r18
.endm

; Function: HAL_DEVICEBUFFER_PUSH
; Description: Adds a single byte to the buffer.
; Input:    Z - Points to Buffer Structure.
;         r22 - Value to store.
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_DEVICEBUFFER_PUSH
  PUSH_MANY r19, r20, r21, ZL, ZH        ; Preserve Z for the caller
    ld      r20, Z          ; r18 = Current Head
    ldd     r19, Z+1        ; r19 = Tail
    ldd     r18, Z+2        ; r20 = Mask

    mov     r21, r20        ; Calculate New Head
    inc     r21
    and     r21, r18
    cp      r21, r19        ; Is it Full?
    ldi     r18, 1          ; Return full
    breq    0f

    st      Z, r21          ; Update Head with new value
    adiw    Z, 5            ; Move to Data start
    add     ZL, r20         ; Offset to Data[Head]
    adc     ZH, __zero_reg__
    st      Z, r22          ; Write data
    ldi     r18, 0          ; Return Success
  0:
  POP_MANY ZH, ZL, r21, r20, r19
  ret
ENDF HAL_DEVICEBUFFER_PUSH

; Function: HAL_DEVICEBUFFER_PULL
; Description: Removes a single byte from the buffer.
; Input:    Z - Points to Buffer Structure.
; Output: r22 - Value retrieved.
;         r18 - 0 (Success), 1 (Empty).
FUNC HAL_DEVICEBUFFER_PULL
  PUSH_MANY r19, r20, r21, ZL, ZH        ; Preserve Z for the caller
    ld      r18, Z          ; r18 = Head
    ldd     r19, Z+1        ; r19 = Tail
    ldd     r20, Z+2        ; r20 = Mask

    cp      r18, r19        ; Is it Empty?
    ldi     r18, 1          ; Return Empty
    breq    0f

    mov     r21, r19        ; Calculate New Tail
    inc     r21
    and     r21, r20
    std     Z+1, r21        ; Update Tail with new value

    adiw    Z, 5            ; Move to Data start
    add     ZL, r19         ; Old Offset to Data[Tail]
    adc     ZH, __zero_reg__
    ld      r22, Z          ; Read data

    ldi     r18, 0          ; Return Success
  0:
  POP_MANY ZH, ZL, r21, r20, r19
  ret
ENDF HAL_DEVICEBUFFER_PULL





; Function: HAL_DEVICEBUFFER_IS_EMPTY
; Description: Checks if the buffer has no data.
; Input:  Z - Points to Buffer Structure.
; Return: r18 - 1 if Empty, 0 otherwise.
FUNC HAL_DEVICEBUFFER_IS_EMPTY
  PUSH r19
    ld      r18, Z          ; r18 = Head
    ldd     r19, Z+1        ; r19 = Tail
    cp      r18, r19        ; Compare Head and Tail
    ldi     r18, 1          ; Assume Empty
    breq    1f
    ldi     r18, 0          ; Not Empty
  1:
  POP r19
  ret
ENDF HAL_DEVICEBUFFER_IS_EMPTY

; Function: HAL_DEVICEBUFFER_IS_FULL
; Description: Checks if the buffer is at capacity.
; Input:  Z - Points to Buffer Structure.
; Return: r18 - 1 if Full, 0 otherwise.
FUNC HAL_DEVICEBUFFER_IS_FULL
  PUSH_MANY r19, r20
    ld      r18, Z          ; r18 = Head
    ldd     r19, Z+1        ; r19 = Tail
    ldd     r20, Z+2        ; r20 = Mask
    inc     r18             ; Next Head
    and     r18, r20        ; Wrap
    cp      r18, r19        ; Compare with Tail
    ldi     r18, 1          ; Assume Full
    breq    1f
    ldi     r18, 0          ; Not Full
  1:
  POP_MANY r20, r19
  ret
ENDF HAL_DEVICEBUFFER_IS_FULL

; Function: HAL_DEVICEBUFFER_IN_USE
; Description: Calculates how many bytes are currently in the buffer.
; Input:  Z - Points to Buffer Structure.
; Return: r18 - Number of bytes used.
FUNC HAL_DEVICEBUFFER_IN_USE
  PUSH_MANY r19, r20
    ld      r18, Z          ; r18 = Head
    ldd     r19, Z+1        ; r19 = Tail
    ldd     r20, Z+2        ; r20 = Mask
    sub     r18, r19        ; Diff = Head - Tail
    and     r18, r20        ; Apply Mask for wrap-around
  POP_MANY r20, r19
  ret
ENDF HAL_DEVICEBUFFER_IN_USE
