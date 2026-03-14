; File: Hal/HAL_BYTE_BUFFER.S
; Description: High-performance Byte Ring Buffer (Circular Buffer).
;
; This library uses a Power-of-Two size (64, 128, 256) to allow bitwise masking
; for head/tail wrapping, avoiding slow division or conditional branches.
;
; Buffer Structure in SRAM:
; [Offset 0] Head (Write index)
; [Offset 1] Tail (Read index)
; [Offset 2] Mask (Size - 1)
; [Offset 3] Data... (Size bytes)
;

; Macro: HAL_BBUF_DEFINE
; Description: Allocates SRAM space for a ring buffer.
.macro HAL_BBUF_DEFINE name, size
    .section .bss
    \name:
        .byte 0                   ; Head
        .byte 0                   ; Tail
        .byte 0                   ; Mask
        .space (\size-1)          ; Data storage
    .set \name\()_SIZE, (\size-1) ; Assembler constant for size
.endm

; Macro: HAL_BBUF_INITIALIZE
; Description: Prepares a ring buffer for use (calculates mask).
; Input: name - Name of the buffer defined with HAL_BBUF_DEFINE.
.macro HAL_BBUF_INITIALIZE name
    ldi   XL, lo8( \name )
    ldi   XH, hi8( \name )
    ldi   r18, \name\()_SIZE
    rcall HAL_BBUF_INIT
.endm

; Function: HAL_BBUF_INIT
; Description: Initializes the buffer metadata.
; Input:  X (r27:r26) - Points to Buffer Structure.
;         r18 - Buffer size (MUST be power of 2).
DEFUN HAL_BBUF_INIT
  HAL_BBUF_INIT:
    st    X+, __zero_reg__  ; Reset Head
    st    X+, __zero_reg__  ; Reset Tail
;    dec   r18               ; Create Mask (Size - 1)
    st    X, r18            ; Store Mask
    sbiw  X, 2              ; Restore X to point to Head
;    inc   r18               ; Restore r18 input value
  ret
ENDF HAL_BBUF_INIT

; Function: HAL_BBUF_IS_EMPTY
; Description: Checks if the buffer has no data.
; Input:  X - Points to Buffer Structure.
; Return: r18 - 1 if Empty, 0 otherwise.
DEFUN HAL_BBUF_IS_EMPTY
  HAL_BBUF_IS_EMPTY:
  PUSH r19
    ld      r18, X+         ; r18 = Head
    ld      r19, X          ; r19 = Tail
    sbiw    X, 1            ; Restore X
    cp      r18, r19        ; Compare Head and Tail
    ldi     r18, 1          ; Assume Empty
    breq    1f
    ldi     r18, 0          ; Not Empty
  1:
  POP r19
  ret
ENDF HAL_BBUF_IS_EMPTY

; Function: HAL_BBUF_IS_FULL
; Description: Checks if the buffer is at capacity.
; Input:  X - Points to Buffer Structure.
; Return: r18 - 1 if Full, 0 otherwise.
DEFUN HAL_BBUF_IS_FULL
  HAL_BBUF_IS_FULL:
  PUSH_MANY r19, r20
    ld      r18, X+         ; r18 = Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask
    sbiw    X, 2            ; Restore X
    inc     r18             ; Next Head
    and     r18, r20        ; Wrap
    cp      r18, r19        ; Compare with Tail
    ldi     r18, 1          ; Assume Full
    breq    1f
    ldi     r18, 0          ; Not Full
  1:
  POP_MANY r20, r19
  ret
ENDF HAL_BBUF_IS_FULL

; Function: HAL_BBUF_IN_USE
; Description: Calculates how many bytes are currently in the buffer.
; Input:  X - Points to Buffer Structure.
; Return: r18 - Number of bytes used.
DEFUN HAL_BBUF_IN_USE
  HAL_BBUF_IN_USE:
  PUSH_MANY r19, r20
    ld      r18, X+         ; r18 = Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask
    sbiw    X, 2            ; Restore X
    sub     r18, r19        ; Diff = Head - Tail
    and     r18, r20        ; Apply Mask for wrap-around
  POP_MANY r20, r19
  ret
ENDF HAL_BBUF_IN_USE

; Function: HAL_BBUF_PUSH
; Description: Adds a single byte to the buffer.
; Input:  X - Points to Buffer Structure.
;         r22 - Value to store.
; Output: r18 - 0 (Success), 1 (Full).
DEFUN HAL_BBUF_PUSH
HAL_BBUF_PUSH:
  PUSH_MANY r19, r20, r21, XL, XH        ; Preserve X for the caller
    ld      r18, X+         ; r18 = Current Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask

    mov     r21, r18        ; Calculate New Head
    inc     r21
    and     r21, r20
    cp      r21, r19        ; Is it Full?
    breq    .L_bbuf_full

    sbiw    X, 2            ; Back to Head offset
    st      X, r21          ; Update Head with new value
    adiw    X, 3            ; Move to Data start
    add     XL, r18         ; Offset to Data[Head]
    adc     XH, __zero_reg__
    st      X, r22          ; Write data

    ldi     r18, 0          ; Return Success
    rjmp    .L_bbuf_push_done

  .L_bbuf_full:
    ldi     r18, 1          ; Return Full

  .L_bbuf_push_done:
  POP_MANY XH, XL, r21, r20, r19
  ret
ENDF HAL_BBUF_PUSH

; Function: HAL_BBUF_PULL
; Description: Removes a single byte from the buffer.
; Input:  X - Points to Buffer Structure.
; Output: r22 - Value retrieved.
;         r18 - 0 (Success), 1 (Empty).
DEFUN HAL_BBUF_PULL
  HAL_BBUF_PULL:
  PUSH_MANY r19, r20, r21, XL, XH        ; Preserve X for the caller
    ld      r18, X+         ; r18 = Head
    ld      r19, X+         ; r19 = Tail
    ld      r20, X          ; r20 = Mask

    cp      r18, r19        ; Is it Empty?
    breq    .L_bbuf_empty

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
    rjmp    .L_bbuf_pull_done

  .L_bbuf_empty:
    ldi     r18, 1          ; Return Empty

  .L_bbuf_pull_done:
  POP_MANY XH, XL, r21, r20, r19
  ret
ENDF HAL_BBUF_PULL

; Function: HAL_BBUF_PUSH_FROM_Z
; Description: Pushes a null-terminated string from Flash into the buffer.
; Input:  X - Points to Buffer Structure.
;         Z - Points to Flash string (.asciz).
; Output: r18 - 0 (Success), 1 (Full).
DEFUN HAL_BBUF_PUSH_FROM_Z
HAL_BBUF_PUSH_FROM_Z:
  PUSH_MANY  r22
  .L_push_loop:
    lpm     r22, Z+
    tst     r22
    breq    .L_push_done    ; Found null terminator

    rcall   HAL_BBUF_PUSH
    tst     r18
    breq    .L_push_loop    ; Continue if push succeeded
    ; If full, r18 is already 1
  .L_push_done:
  POP_MANY  r22
  ret
ENDF HAL_BBUF_PUSH_FROM_Z
