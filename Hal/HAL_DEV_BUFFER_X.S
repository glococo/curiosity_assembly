; File: Hal/HAL_DEV_BUFFER_X.S
; Description: High-performance Byte Ring Buffer (Circular Buffer).
;
; This library uses a Power-of-Two size (64, 128, 256) to allow bitwise masking
; for head/tail wrapping, avoiding slow division or conditional branches.
;
; Buffer Structure in SRAM:
; [Offset 0] Device Address L (USART0_RXDATAL, SPI0_CTRLA, ...)
; [Offset 1] Device Address H (USART0_RXDATAL, SPI0_CTRLA, ...)
; [Offset 2] Head (Write index)
; [Offset 3] Tail (Read index)
; [Offset 4] Mask (Size - 1)
; [Offset 5] Data... (Size bytes)
;

; Macro: HAL_DEV_BUFFER_X_NEW
; Description: Allocates SRAM space for a ring buffer.
.macro HAL_DEV_BUFFER_X_NEW name, size, devID
    .section .bss
    \name:
        .byte 0, 0                ; Device Base Addr
        .byte 0                   ; Head
        .byte 0                   ; Tail
        .byte 0                   ; Mask
        .space (\size)            ; Data storage
    .set \name\()_SIZE, (\size-1) ; Assembler constant for size
    .set \name\()_ADDRL, \devID & 0xFF  ; Assembler constant for addrL
    .set \name\()_ADDRH, ( \devID & 0xFF00 )>>8  ; Assembler constant for addrH
.endm

; Macro: HAL_DEV_BUFFER_X_INIT
; Description: Prepares a ring buffer for use (calculates mask).
; Input: name - Name of the buffer defined with HAL_DEV_BUFFER_X_NEW.
.macro HAL_DEV_BUFFER_X_INIT name
  PUSH r18
    ldi   XL, lo8( \name )
    ldi   XH, hi8( \name )
    ldi   r18, \name\()_ADDRL
    st    X+, r18                 ; Store 16bit Device Address Low
    ldi   r18, \name\()_ADDRH
    st    X+, r18                 ; Store 16bit Device Address High
    st    X+, __zero_reg__        ; Reset Head
    st    X+, __zero_reg__        ; Reset Tail
    ldi   r18, \name\()_SIZE
    st    X, r18                  ; Store Mask
    sbiw  X, 4                    ; Restore X to point to Head
  POP r18
.endm

; Function: HAL_DEV_BUFFER_IS_EMPTY
; Description: Checks if the buffer has no data.
; Input:  X - Points to Buffer Structure.
; Return: r18 - 1 if Empty, 0 otherwise.
FUNC HAL_DEV_BUFFER_X_IS_EMPTY
  PUSH r19
    adiw    X, 2            ; Skip Dev Base Addr
    ld      r18, X+         ; r18 = Head
    ld      r19, X          ; r19 = Tail
    sbiw    X, 3            ; Restore X
    cp      r18, r19        ; Compare Head and Tail
    ldi     r18, 1          ; Assume Empty
    breq    1f
    ldi     r18, 0          ; Not Empty
  1:
  POP r19
  ret
ENDF HAL_DEV_BUFFER_X_IS_EMPTY

; Function: HAL_DEV_BUFFER_X_IS_FULL
; Description: Checks if the buffer is at capacity.
; Input:  X - Points to Buffer Structure.
; Return: r18 - 1 if Full, 0 otherwise.
FUNC HAL_DEV_BUFFER_X_IS_FULL
  PUSH_MANY r19, r20
    adiw    X, 2            ; Skip Dev Base Addr
    ld      r18, X+         ; r18 = Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask
    sbiw    X, 4            ; Restore X
    inc     r18             ; Next Head
    and     r18, r20        ; Wrap
    cp      r18, r19        ; Compare with Tail
    ldi     r18, 1          ; Assume Full
    breq    1f
    ldi     r18, 0          ; Not Full
  1:
  POP_MANY r20, r19
  ret
ENDF HAL_DEV_BUFFER_X_IS_FULL

; Function: HAL_DEV_BUFFER_X_IN_USE
; Description: Calculates how many bytes are currently in the buffer.
; Input:  X - Points to Buffer Structure.
; Return: r18 - Number of bytes used.
FUNC HAL_DEV_BUFFER_X_IN_USE
  PUSH_MANY r19, r20
    adiw    X, 2            ; Skip Dev Base Addr
    ld      r18, X+         ; r18 = Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask
    sbiw    X, 4            ; Restore X
    sub     r18, r19        ; Diff = Head - Tail
    and     r18, r20        ; Apply Mask for wrap-around
  POP_MANY r20, r19
  ret
ENDF HAL_DEV_BUFFER_X_IN_USE

; Function: HAL_DEV_BUFFER_X_PUSH
; Description: Adds a single byte to the buffer.
; Input:  X - Points to Buffer Structure.
;         r22 - Value to store.
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_DEV_BUFFER_X_PUSH
  PUSH_MANY r19, r20, r21, XL, XH        ; Preserve X for the caller
    adiw    X, 2            ; Skip Dev Base Addr
    ld      r18, X+         ; r18 = Current Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask

    mov     r21, r18        ; Calculate New Head
    inc     r21
    and     r21, r20
    cp      r21, r19        ; Is it Full?
    breq    0f

    sbiw    X, 2            ; Back to Head offset
    st      X, r21          ; Update Head with new value
    adiw    X, 3            ; Move to Data start
    add     XL, r18         ; Offset to Data[Head]
    adc     XH, __zero_reg__
    st      X, r22          ; Write data

    ldi     r18, 0          ; Return Success
    rjmp    1f

  0:
    ldi     r18, 1          ; Return Full
  1:
  POP_MANY XH, XL, r21, r20, r19
  ret
ENDF HAL_DEV_BUFFER_X_PUSH

; Function: HAL_DEV_BUFFER_X_PULL
; Description: Removes a single byte from the buffer.
; Input:  X - Points to Buffer Structure.
; Output: r22 - Value retrieved.
;         r18 - 0 (Success), 1 (Empty).
FUNC HAL_DEV_BUFFER_X_PULL
  PUSH_MANY r19, r20, r21, XL, XH        ; Preserve X for the caller
    adiw    X, 2            ; Skip Dev Base Addr
    ld      r18, X+         ; r18 = Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask

    cp      r18, r19        ; Is it Empty?
    breq    0f

    mov     r21, r19        ; Calculate New Tail
    inc     r21
    and     r21, r20
    sbiw    X, 1            ; Back to Tail offset
    st      X, r21          ; Update Tail with new value

    adiw    X, 2            ; Move to Data start
    add     XL, r19         ; Offset to Data[Tail]
    adc     XH, __zero_reg__
    ld      r22, X          ; Read data

    ldi     r18, 0          ; Return Success
    rjmp    1f

  0:
    ldi     r18, 1          ; Return Empty

  1:
  POP_MANY XH, XL, r21, r20, r19
  ret
ENDF HAL_DEV_BUFFER_X_PULL

; Function: HAL_DEV_BUFFER_X_PUSH_FROM_Z
; Description: Pushes a null-terminated string from Mapped Flash into the buffer.
; Input:  X - Points to Buffer Structure.
;         Z - Points to Mapped Flash string (.asciz).
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_DEV_BUFFER_X_PUSH_FROM_Z
  PUSH  r22
  0:
    ld      r22, Z+
    tst     r22
    breq    1f                  ; Found null terminator

    rcall   HAL_DEV_BUFFER_X_PUSH
    tst     r18
    breq    0b                  ; Continue if push succeeded
  1:                            ; If full, r18 is already 1
  POP  r22
  ret
ENDF HAL_DEV_BUFFER_X_PUSH_FROM_Z

; Function: HAL_DEV_BUFFER_X_PUSH_FROM_F
; Description: Pushes a null-terminated string from Flash into the buffer.
; Input:  X - Points to Buffer Structure.
;         Z - Points to Flash string (.asciz).
; Output: r18 - 0 (Success), 1 (Full).
FUNC HAL_DEV_BUFFER_X_PUSH_FROM_F
  PUSH  r22
  0:
    lpm     r22, Z+
    tst     r22
    breq    1f              ; Found null terminator

    rcall   HAL_DEV_BUFFER_X_PUSH
    tst     r18
    breq    0b              ; Continue if push succeeded
  1:                        ; If full, r18 is already 1
  POP  r22
  ret
ENDF HAL_DEV_BUFFER_X_PUSH_FROM_F
