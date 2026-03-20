; File: Hal/HAL_DOUBLEBUFFER.S
; Description: High-performance Double-Buffer (Ping-Pong) Architecture.
;
; This library implements a "Zero-Copy" data path between high-speed
; peripherals (like USART) and the main application loop.
;
; Descriptor Structure (9 bytes):
; [0-1] Current Write Pointer (16-bit)
; [2-3] Base Address A (16-bit)
; [4-5] Base Address B (16-bit)
; [6]   Bytes Written (8-bit)
; [7]   Buffer Limit (8-bit)
; [8]   Status Byte:
;           Bit 0: Active Buffer (0=A, 1=B)
;           Bit 1: Buffer A Ready to Process
;           Bit 2: Buffer B Ready to Process
;           :( Ex: 0b11? = Buffer A and B full

; Macro: HAL_DOUBLEBUFFER_DEFINE
; Description: Allocates SRAM space for two buffers and one descriptor.
.macro HAL_DOUBLEBUFFER_DEFINE name, size
    .section .bss
    \name\()_A:     .space \size
    \name\()_B:     .space \size
    \name:          .space 9
    .set \name\()_SIZE, \size
.endm

; Macro: HAL_DOUBLEBUFFER_INIT
; Description: Links buffers to the descriptor and sets initial state.
.macro HAL_DOUBLEBUFFER_INIT name
    ldi     ZL, lo8( \name )
    ldi     ZH, hi8( \name )
    ldi     r18, lo8(\name\()_A)        ; Load Buffer A start address
    ldi     r19, hi8(\name\()_A)
    std     Z+0, r18                    ; Current Write Ptr L
    std     Z+1, r19                    ; Current Write Ptr H
    std     Z+2, r18                    ; Base A L
    std     Z+3, r19                    ; Base A H
    ldi     r18, lo8(\name\()_B)        ; Load Buffer B start address
    ldi     r19, hi8(\name\()_B)
    std     Z+4, r18                    ; Base B L
    std     Z+5, r19                    ; Base B H

    ldi     r18, \name\()_SIZE          ; Setup Limit and Reset Counters
    std     Z+7, r18                    ; Limit
    std     Z+6, r2                     ; Bytes Written = 0
    std     Z+8, r2                     ; Status = 0 (Active A)
.endm

; Macro: HAL_DOUBLEBUFFER_ISR_RX_PUSH
; Description: Lean logic for USART RX Interrupt (ISR_START / ISR_END block)
.macro HAL_DOUBLEBUFFER_ISR_RX_PUSH name, usart_addr
  PUSH_MANY r30, r31, YL, YH, r18, r19

    ldi     ZL, lo8( \name )
    ldi     ZH, hi8( \name )
    ldd     YL, Z+0               ; Load Active Buffer Ptr
    ldd     YH, Z+1

    lds     r18, \usart_addr      ; Get Byte (RXDATAL)
    st      Y+, r18               ; Store and Inc
    std     Z+0, YL               ; Update Ptr (Offset 0)
    std     Z+1, YH               ; Update Ptr (Offset 1)
    ldd     r18, Z+6              ; Update Counter, get Bytes Written (Offset 6)
    inc     r18
    std     Z+6, r18              ; Store back
    ldd     r19, Z+7              ; Get Limit (Offset 7)
    cp      r18, r19
    brne    0f                    ; Not full yet
    rcall   HAL_DOUBLEBUFFER_FLIP ; Buffer Full: Perform the Flip
  0:
  POP_MANY r19, r18, YH, YL, r31, r30
.endm

; Function: HAL_DOUBLEBUFFER_FLIP
; Description: Swaps active pointers and sets "Ready" flags.
; Input: Z points to Descriptor start.
DEFUN HAL_DOUBLEBUFFER_FLIP
  PUSH_MANY r18, r19, r20
    ldd     r18, Z+8                  ; Current Status
    sbrc    r18, 0                    ; If Bit 0 is 1, B was active
    rjmp    .L_was_b
                                      ; --- Was A Active ---
    sbr     r18, 0x03                 ; Set A_Ready, Set Active=B
    ldd     r19, Z+4                  ; Load Base B L
    ldd     r20, Z+5                  ; Load Base B H
    rjmp    .L_apply
  .L_was_b:                           ; --- Was B Active ---
    sbr     r18, 0x04                 ; Set B_Ready
    cbr     r18, 0x01                 ; Set Active=A
    ldd     r19, Z+2                  ; Load Base A L
    ldd     r20, Z+3                  ; Load Base A H
  .L_apply:
    std     Z+0, r19                  ; New Write Ptr L
    std     Z+1, r20                  ; New Write Ptr H
    std     Z+6, r2                   ; Reset Counter
    std     Z+8, r18                  ; Save New Status
  POP_MANY r20, r19, r18
  ret
ENDF HAL_DOUBLEBUFFER_FLIP
