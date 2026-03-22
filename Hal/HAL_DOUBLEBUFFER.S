; File: Hal/HAL_DOUBLEBUFFER.S
; Description: High-performance Double-Buffer (Ping-Pong) Architecture.
;              Provides a "Zero-Copy" path between peripherals and application.
;
; Example Usage:
;   HAL_DOUBLEBUFFER_DEFINE  my_dbuf, 16
;   HAL_DOUBLEBUFFER_INIT    my_dbuf
;
;   ldi     ZL, lo8(my_dbuf)
;   ldi     ZH, hi8(my_dbuf)
;   ldi     r22, 'X'
;   rcall   HAL_DOUBLEBUFFER_PUSH       ; Returns r18=1 when buffer is full/flipped
;
; Descriptor Structure (9 bytes):
; [0-1] Active address writing pointer (16-bit)
; [2-3] Base address Active (16-bit)
; [4-5] Base address Spare (16-bit)
; [6]   Buffer Limit/size (8-bit)
; [7]   Bytes written in Active (8-bit)
; [8]   Bytes written in Spare (8-bit)

; Macro: HAL_DOUBLEBUFFER_DEFINE
; Description: Allocates SRAM space for two buffers and a 9-byte descriptor.
; Inputs:  name - Name of the double buffer
;          size - Size of each individual buffer (2 to 256)
; Outputs: None
.macro HAL_DOUBLEBUFFER_DEFINE name, size
    .section .bss
    \name\()_A:     .space \size        ; Buffer A storage
    \name\()_B:     .space \size        ; Buffer B storage
    \name:          .space 9            ; Descriptor storage
    .set \name\()_SIZE, \size           ; Store size as assembler constant
.endm

; Macro: HAL_DOUBLEBUFFER_INIT
; Description: Links buffers to the descriptor and sets initial state.
; Inputs:  name - Name of the buffer defined with HAL_DOUBLEBUFFER_DEFINE
; Outputs: None
.macro HAL_DOUBLEBUFFER_INIT name
    ldi     ZL, lo8( \name )
    ldi     ZH, hi8( \name )
    ldi     r18, lo8(\name\()_A)        ; Load Buffer A start address
    ldi     r19, hi8(\name\()_A)
    std     Z+0, r18                    ; Set Active Write Ptr L
    std     Z+1, r19                    ; Set Active Write Ptr H
    std     Z+2, r18                    ; Set Base Active L
    std     Z+3, r19                    ; Set Base Active H
    ldi     r18, lo8(\name\()_B)        ; Load Buffer B start address
    ldi     r19, hi8(\name\()_B)
    std     Z+4, r18                    ; Set Base Spare L
    std     Z+5, r19                    ; Set Base Spare H
    ldi     r18, (\name\()_SIZE)-1      ; Limit = size - 1
    std     Z+6, r18                    ; Store Size Limit
    std     Z+7, __zero_reg__           ; Reset Bytes Written Active = 0
    std     Z+8, __zero_reg__           ; Reset Bytes Ready Spare = 0
.endm

; Function: HAL_DOUBLEBUFFER_PUSH
; Description: Pushes a byte into the active buffer and flips if full.
; Inputs:  Z   - Points to Buffer Descriptor
;          r22 - Data byte to push
; Outputs: r18 - 0: Not full, 1: Buffer full and flipped
FUNC HAL_DOUBLEBUFFER_PUSH
  PUSH_MANY r23, XL, XH
    ldi     r18, 0                      ; Default return status: Not full
    ldd     XL, Z+0                     ; Load current Active Write Ptr
    ldd     XH, Z+1                     ;
    st      X+, r22                     ; Store data and increment pointer
    std     Z+0, XL                     ; Update Active Write Ptr
    std     Z+1, XH                     ;

    ldd     r22, Z+7                    ; Load Bytes Written Active
    inc     r22                         ; Increment counter
    std     Z+7, r22                    ; Store back
    ldd     r23, Z+6                    ; Load Buffer Limit
    cp      r22, r23                    ; Compare counter with limit
    brne    0f                          ; Not full yet, exit

    rcall   HAL_DOUBLEBUFFER_FLIP       ; Buffer full: Perform the Flip
    std     Z+7, __zero_reg__           ; Reset Bytes Written Active = 0
    std     Z+8, r22                    ; Set Bytes Ready in Spare
    ldi     r18, 1                      ; Return status: Full/Ready
  0:
  POP_MANY XH, XL, r23
ENDF HAL_DOUBLEBUFFER_PUSH

; Function: HAL_DOUBLEBUFFER_FLIP
; Description: Swaps Active and Spare buffer pointers.
; Inputs:  Z   - Points to Buffer Descriptor
; Outputs: None
FUNC HAL_DOUBLEBUFFER_FLIP
    ldd     XL, Z+4                     ; Swap: Load Spare Base
    ldd     XH, Z+5                     ;
    std     Z+0, XL                     ; Set as new Active Write Ptr
    std     Z+1, XH                     ;

    ldd     XL, Z+2                     ; Load filled Active Base
    ldd     XH, Z+3                     ;
    std     Z+4, XL                     ; Set as new Spare (to be drained)
    std     Z+5, XH                     ;

    ldd     XL, Z+0                     ; Load new Active Write Ptr
    ldd     XH, Z+1                     ;
    std     Z+2, XL                     ; Update Active Base pointer
    std     Z+3, XH                     ;
ENDF HAL_DOUBLEBUFFER_FLIP

; Function: HAL_DOUBLEBUFFER_WRITE_BYTE
; Description: Reads a byte from the Spare buffer and writes it to a target.
; Inputs:  Z   - Points to Buffer Descriptor
;          Y   - Points to Target SRAM location
; Outputs: r18 - 0: Done (more bytes left), 1: Empty (all bytes sent)
FUNC HAL_DOUBLEBUFFER_WRITE_BYTE
  PUSH_MANY r19, r20, r22, XL, XH
    ldi     r18, 1                      ; Default return status: Empty
    ldd     r19, Z+8                    ; Load Spare bytes remaining
    tst     r19                         ; Check if anything to drain
    breq    0f                          ; If 0, exit

    ldd     XL, Z+4                     ; Load Spare Base Address
    ldd     XH, Z+5                     ;
    ldd     r22, Z+6                    ; Load Limit
    ldd     r23, Z+8                    ; Load Remaining
    sub     r22, r23                    ; Calculate offset (Limit - Remaining)
    add     XL, r22                     ; Add offset to Base
    adc     XH, __zero_reg__            ; Handle carry
    ld      r22, X                      ; Read byte from Spare buffer
    st      Y, r22                      ; Write byte to Target (e.g., USART TX)
    dec     r23                         ; Decrement remaining counter
    std     Z+8, r23                    ; Store back
    breq    0f                          ; If now 0, exit (status 1)
    ldi     r18, 0                      ; Not empty yet (status 0)
  0:
  POP_MANY XH, XL, r22, r20, r19
ENDF HAL_DOUBLEBUFFER_WRITE_BYTE
