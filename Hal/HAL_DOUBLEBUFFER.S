; File: Hal/HAL_DOUBLEBUFFER.S
; Description: High-performance Double-Buffer (Ping-Pong) Architecture.
;
; This library implements a "Zero-Copy" data path between high-speed
; peripherals (like USART, I2C, SPI) and the main application loop.
; This library allow sizes of 2 to 256 (real size= size-1)
;
; Descriptor Structure (9 bytes):
; [0-1] Active address wrinting pointer (16-bit)
; [2-3] Base address Active (16-bit)
; [4-5] Base address Spare (16-bit)
; [6]   Buffer Limit/size (8-bit)
; [7]   Bytes written in Active (8-bit)
; [8]   Bytes written in Spare (8-bit)

; Macro: HAL_DOUBLEBUFFER_DEFINE
; Description: Allocates SRAM space for two buffers and one descriptor.
.macro HAL_DOUBLEBUFFER_DEFINE name, size
    .section .bss
    \name\()_A:     .space \size
    \name\()_B:     .space \size
    \name:          .space 9
    .set \name\()_SIZE, \size           ; Make sure 256 size can be implemented
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
    ldi     r18, (\name\()_SIZE)-1      ; Setup Limit and Reset Counters
    std     Z+6, r18                    ; Size
    std     Z+7, r2                     ; Bytes Written = 0
    std     Z+8, r2                     ; Bytes ready to be sent (not ready)
.endm

; Macro: HAL_DOUBLEBUFFER_PUSH
; Description: PUSH byte to Active Buffer
; Input: r22: data, Z: Buffer
; Return r18: 0: not full, 1: Ready
FUNC HAL_DOUBLEBUFFER_PUSH
  PUSH_MANY r23, XL, XH
    ldi     r18, 0
    ldd     XL, Z+0               ; Load Active Ptr
    ldd     XH, Z+1               ;
    st      X+, r22               ; Store and Inc
    std     Z+0, XL               ; Update Active Ptr
    std     Z+1, XH               ;

    ldd     r22, Z+7              ; Update Counter, get Bytes Written (Offset 7)
    inc     r22                   ; Increment
    std     Z+7, r22              ; Store back
    ldd     r23, Z+6              ; Get Limit (Offset 6)
    cp      r22, r23              ; Compare Counter with Limit
    brne    0f                    ; Not full yet
    rcall   HAL_DOUBLEBUFFER_FLIP ; Buffer Full: Perform the Flip
    std     Z+7, r2               ; Bytes written reset
    std     Z+8, r22              ; Bytes ready to be drained
    ldi     r18, 1
  0:
  POP_MANY XH, XL, r23
ENDF HAL_DOUBLEBUFFER_PUSH

; Function: HAL_DOUBLEBUFFER_FLIP
; Description: Swaps Active pointers and set Bytes to be ready.
; Input: Z points to Descriptor start.
FUNC HAL_DOUBLEBUFFER_FLIP
    ldd     XL, Z+4               ; Copy next Active address to base
    ldd     XH, Z+5
    std     Z+0, XL
    std     Z+1, XH

    ldd     XL, Z+2               ; Move Active filled pointer to Spare (filled)
    ldd     XH, Z+3
    std     Z+4, XL
    std     Z+5, XH

    ldd     XL, Z+0               ; Update current Active base pointer
    ldd     XH, Z+1
    std     Z+2, XL
    std     Z+3, XH
ENDF HAL_DOUBLEBUFFER_FLIP

; Function: HAL_DOUBLEBUFFER_WRITE_BYTE
; Description: Write a byte from active buffer to Y-Pointer
; Input: Z: DoubleBuffer, Y: Target SRAM location
; Returns: r18: 0=done, 1=empty
FUNC HAL_DOUBLEBUFFER_WRITE_BYTE
  PUSH_MANY r19, r20, r22, XL, XH
    ldi     r18, 1                              ; Return empty
    ldd     r19, Z+8                            ; Load buffer bytes remaining
    tst     r19                                 ; Check buffer READY status
    breq    0f

    ldd     XL, Z+4
    ldd     XH, Z+5
    ldd     r22, Z+6    ; limit/size
    ldd     r23, Z+8    ; remaining
    sub     r22, r23    ; get spare off-set address byte to send
    add     XL, r22
    adc     XH, r2
    ld      r22, X
    st      Y, r22                              ; Save byte in USART_TXDATAL
    dec     r23
    std     Z+8, r23
    breq    0f
    ldi     r18, 0
  0:
  POP_MANY XH, XL, r22, r20, r19
ENDF HAL_DOUBLEBUFFER_WRITE_BYTE
