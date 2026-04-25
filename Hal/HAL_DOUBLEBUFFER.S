; File: Hal/HAL_DOUBLEBUFFER.S
; Description: High-performance Double-Buffer (Ping-Pong) Architecture.
;              Provides a "Zero-Copy" path between peripherals and application.
;

; Descriptor Structure (9 bytes):
; [0-1] Active address writing pointer (16-bit)
; [2-3] Base address Active (16-bit)
; [4-5] Base address Spare (16-bit)
; [6]   Buffer Limit/size (8-bit)
; [7]   Bytes written in Active (8-bit)
; [8]   Bytes written in Spare (8-bit)

#define _DOUBLEBUFFER(name, size)   HAL_DOUBLEBUFFER_DEFINE name, size

; Macro: HAL_DOUBLEBUFFER_DEFINE
; Description: Allocates SRAM space for two buffers and a 9-byte descriptor.
; Inputs:  name - Name of the double buffer
;          size - Size of each individual buffer (2 to 256)
.macro HAL_DOUBLEBUFFER_DEFINE name, size
  .pushsection .bss
    \name\()_A:     .space \size        ; Buffer A storage
    \name\()_B:     .space \size        ; Buffer B storage
    \name\():       .space 9            ; Descriptor (Active,Base,Spare,Limit,Bytes in Active,Bytes ready in Spare)
    .set \name\()_SIZE, \size           ; Store size as assembler constant
  .popsection
  PUSH_MANY r21, r22, r23, r24, r25
    ldi2    ZL, \name
    ldi     r21, \size-1
    ldi2    r22, \name\()_A
    ldi2    r24, \name\()_B
    call   HAL_DOUBLEBUFFER_INIT
  POP_MANY r25, r24, r23, r22, r21
.endm

; Function: HAL_DOUBLEBUFFER_INIT
; Description: Initialize Double Buffer Descriptor
; Inputs:       Z - Point to buffer descriptor
;         r23:r22 - A storage
;         r25:r24 - B storage
FUNC HAL_DOUBLEBUFFER_INIT
    std     Z+0, r22                    ; Set Pointer: Active
    std     Z+1, r23                    ; Set Pointer: Active
    std     Z+2, r22                    ; Set A as Active
    std     Z+3, r23                    ; Set A as Active
    std     Z+4, r24                    ; Set B as Spare
    std     Z+5, r25                    ; Set B as Spare
    std     Z+6, r21                    ; Store Size Limit
    std     Z+7, __zero_reg__           ; Bytes Written Active = 0
    std     Z+8, __zero_reg__           ; Bytes Ready Spare = 0
ENDF HAL_DOUBLEBUFFER_INIT

; Function: HAL_DOUBLEBUFFER_PUSH
; Description: Pushes a byte into the active buffer and flips if full
;              (overwrite if both are full)
; Inputs:    Z - Points to Buffer Descriptor
;          r22 - Data byte to push
FUNC HAL_DOUBLEBUFFER_PUSH
  PUSH_MANY r23, XL, XH
    ldd     XL, Z+0                     ; Load current Active Write Ptr
    ldd     XH, Z+1                     ;
    st      X+, r22                     ; Store data and increment pointer
    std     Z+0, XL                     ; Update Active Write Ptr
    std     Z+1, XH                     ;

    ldd     r26, Z+6                    ; Load Buffer Limit
    ldd     r27, Z+7                    ; Load Bytes Written Active
    inc     r27                         ; Increment counter
    cp      r26, r27                    ; Compare counter with limit
    breq    .L_flip
    std     Z+7, r27                    ; Store back
    jmp    0f
  .L_flip:
    std     Z+7, __zero_reg__           ; Bytes Written Active = 0
    std     Z+8, r26                    ; Set Bytes Ready in Spare
    call   HAL_DOUBLEBUFFER_FLIP       ; Buffer full: Perform the Flip
    sec
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

; Function: HAL_DOUBLEBUFFER_PULL
; Description: Reads a byte from the Spare buffer and writes it to target Y.
; Inputs:    Z - Buffer Descriptor
; Outputs: r22 - Data
;           Cf - 0: Success, 1: Empty
FUNC HAL_DOUBLEBUFFER_PULL
    ldd     r22, Z+8                    ; Load Spare bytes remaining
    tst     r22                         ; Check if anything to drain
    brne    1f                          ; If 0, exit
  0:
    sec                                 ; "Set" Carry = Empty
    jmp   2f
  1:
  PUSH_MANY r23, XL, XH
    ldd     XL, Z+4                     ; Load Spare Base Address
    ldd     XH, Z+5                     ;
    ldd     r22, Z+6                    ; Load Limit
    ldd     r23, Z+8                    ; Load Remaining
    sub     r22, r23                    ; Calculate offset (Limit - Remaining)
    add     XL, r22                     ; Add offset to Base
    adc     XH, __zero_reg__            ; Handle carry and "Clear" CARRY flag
    ld      r22, X                      ; Read byte from Spare buffer
    dec     r23                         ; Decrement remaining counter
    std     Z+8, r23                    ; Store back
  POP_MANY XH, XL, r23
  2:
ENDF HAL_DOUBLEBUFFER_WRITE_BYTE

; Function: HAL_DOUBLEBUFFER_WRITE_BYTE
; Description: Reads a byte from the Spare buffer and writes it to target Y.
; Inputs:    Z - Buffer Descriptor
;            Y - Target SRAM location
; Outputs:  Cf - 0: Empty (all bytes sent), 1:Done (more bytes left)
FUNC HAL_DOUBLEBUFFER_WRITE_BYTE
  PUSH_MANY r19, r20, r22, XL, XH
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
    breq    0f                          ; If now 0, exit (status 0)
    sec                                 ; Not empty yet (status 1)
  0:
  POP_MANY XH, XL, r22, r20, r19
ENDF HAL_DOUBLEBUFFER_WRITE_BYTE
