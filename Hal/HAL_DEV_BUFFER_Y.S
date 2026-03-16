; File: Hal/HAL_DEV_BUFFER_Y.S
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
;

; Macro: HAL_DEV_BUFFER_Y_NEW
; Description: Allocates SRAM space for a ring buffer.
.macro HAL_DEV_BUFFER_Y_NEW name, size, devID
    .section .bss
    \name:
        .byte 0                     ; Head
        .byte 0                     ; Tail
        .byte 0                     ; Mask
        .byte 0, 0                  ; Device Base Addr
        .space (\size)              ; Data storage
    .set \name\()_SIZE, (\size-1)     ; Assembler constant for size
    .set \name\()_ADDRL, \devID & 0xFF  ; Assembler constant for addrL
    .set \name\()_ADDRH, ( \devID & 0xFF00 )>>8  ; Assembler constant for addrH
.endm

; Macro: HAL_DEV_BUFFER_Y_INIT
; Description: Prepares a ring buffer for use (calculates mask).
; Input: name - Name of the buffer defined with HAL_DEV_BUFFER_Y_NEW.
.macro HAL_DEV_BUFFER_Y_INIT name
  PUSH r18
    ldi   YL, lo8( \name )
    ldi   YH, hi8( \name )
    st    Y, __zero_reg__          ; Reset Head
    std   Y+1, __zero_reg__        ; Reset Tail
    ldi   r18, \name\()_SIZE
    std   Y+2, r18                 ; Store Mask
    ldi   r18, \name\()_ADDRL
    std   Y+3, r18                 ; Store 16bit Device Address Low
    ldi   r18, \name\()_ADDRH
    std   Y+4, r18                 ; Store 16bit Device Address High
  POP r18
.endm

; Function: HAL_DEV_BUFFER_Y_IS_EMPTY
; Description: Checks if the buffer has no data.
; Input:  Y - Points to Buffer Structure.
; Return: r18 - 1 if Empty, 0 otherwise.
FUNC HAL_DEV_BUFFER_Y_IS_EMPTY
  PUSH r19
    ld      r18, Y          ; r18 = Head
    ldd     r19, Y+1        ; r19 = Tail
    cp      r18, r19        ; Compare Head and Tail
    ldi     r18, 1          ; Assume Empty
    breq    1f
    ldi     r18, 0          ; Not Empty
  1:
  POP r19
  ret
ENDF HAL_DEV_BUFFER_Y_IS_EMPTY

; Function: HAL_DEV_BUFFER_Y_IS_FULL
; Description: Checks if the buffer is at capacity.
; Input:  Y - Points to Buffer Structure.
; Return: r18 - 1 if Full, 0 otherwise.
FUNC HAL_DEV_BUFFER_Y_IS_FULL
  PUSH_MANY r19, r20
    ld      r18, Y          ; r18 = Head
    ldd     r19, Y+1        ; r19 = Tail
    ldd     r20, Y+2        ; r20 = Mask
    inc     r18             ; Next Head
    and     r18, r20        ; Wrap
    cp      r18, r19        ; Compare with Tail
    ldi     r18, 1          ; Assume Full
    breq    1f
    ldi     r18, 0          ; Not Full
  1:
  POP_MANY r20, r19
  ret
ENDF HAL_DEV_BUFFER_Y_IS_FULL

; Function: HAL_DEV_BUFFER_Y_IN_USE
; Description: Calculates how many bytes are currently in the buffer.
; Input:  Y - Points to Buffer Structure.
; Return: r18 - Number of bytes used.
FUNC HAL_DEV_BUFFER_Y_IN_USE
  PUSH_MANY r19, r20
    ld      r18, Y          ; r18 = Head
    ldd     r19, Y+1        ; r19 = Tail
    ldd     r20, Y+2        ; r20 = Mask
    sub     r18, r19        ; Diff = Head - Tail
    and     r18, r20        ; Apply Mask for wrap-around
  POP_MANY r20, r19
  ret
ENDF HAL_DEV_BUFFER_Y_IN_USE

; Function: HAL_DEV_BUFFER_Y_PUSH
; Description: Adds a single byte to the buffer.
; Input:  Y - Points to Buffer Structure.
;         r22 - Value to store.
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_DEV_BUFFER_Y_PUSH
  PUSH_MANY r19, r20, r21, YL, YH        ; Preserve Y for the caller
    ld      r18, Y          ; r18 = Current Head
    ldd     r19, Y+1        ; r19 = Tail
    ldd     r20, Y+2        ; r20 = Mask

    mov     r21, r18        ; Calculate New Head
    inc     r21
    and     r21, r20
    cp      r21, r19        ; Is it Full?
    breq    0f

    st      Y, r21          ; Update Head with new value
    adiw    Y, 5            ; Move to Data start
    add     YL, r18         ; Offset to Data[Head]
    adc     YH, __zero_reg__
    st      Y, r22          ; Write data

    ldi     r18, 0          ; Return Success
    rjmp    1f

  0:
    ldi     r18, 1          ; Return Full
  1:
  POP_MANY YH, YL, r21, r20, r19
  ret
ENDF HAL_DEV_BUFFER_Y_PUSH

; Function: HAL_DEV_BUFFER_Y_PULL
; Description: Removes a single byte from the buffer.
; Input:  Y - Points to Buffer Structure.
; Output: r22 - Value retrieved.
;         r18 - 0 (Success), 1 (Empty).
FUNC HAL_DEV_BUFFER_Y_PULL
  PUSH_MANY r19, r20, r21, YL, YH        ; Preserve Y for the caller
    ld      r18, Y          ; r18 = Head
    ldd     r19, Y+1        ; r19 = Tail
    ldd     r20, Y+2        ; r20 = Mask

    cp      r18, r19        ; Is it Empty?
    breq    0f

    mov     r21, r19        ; Calculate New Tail
    inc     r21
    and     r21, r20
    std     Y+1, r21        ; Update Tail with new value

    adiw    Y, 5            ; Move to Data start
    add     YL, r19         ; Offset to Data[Tail]
    adc     YH, __zero_reg__
    ld      r22, Y          ; Read data

    ldi     r18, 0          ; Return Success
    rjmp    1f

  0:
    ldi     r18, 1          ; Return Empty

  1:
  POP_MANY YH, YL, r21, r20, r19
  ret
ENDF HAL_DEV_BUFFER_Y_PULL

; Function: HAL_DEV_BUFFER_Y_PUSH_FROM_Z
; Description: Pushes a null-terminated string from Mapped Flash into the buffer.
; Input:  X - Points to Buffer Structure.
;         Z - Points to Mapped Flash string (.asciz).
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_DEV_BUFFER_Y_PUSH_FROM_Z
  PUSH  r22
  0:
    ld      r22, Z+
    tst     r22
    breq    1f                  ; Found null terminator

    rcall   HAL_DEV_BUFFER_Y_PUSH
    tst     r18
    breq    0b                  ; Continue if push succeeded
  1:                            ; If full, r18 is already 1
  POP  r22
  ret
ENDF HAL_DEV_BUFFER_Y_PUSH_FROM_Z

; Function: HAL_DEV_BUFFER_Y_PUSH_FROM_F
; Description: Pushes a null-terminated string from Flash into the buffer.
; Input:  Y - Points to Buffer Structure.
;         Z - Points to Flash string (.asciz).
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_DEV_BUFFER_Y_PUSH_FROM_F
  PUSH  r22
  0:
    lpm     r22, Z+
    tst     r22
    breq    1f                  ; Found null terminator

    rcall   HAL_DEV_BUFFER_Y_PUSH
    tst     r18
    breq    0b                  ; Continue if push succeeded
  1:                            ; If full, r18 is already 1
  POP  r22
  ret
ENDF HAL_DEV_BUFFER_Y_PUSH_FROM_F
