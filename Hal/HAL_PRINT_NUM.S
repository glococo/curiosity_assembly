; File: Hal/HAL_PRINT_NUM.S
; Description: Numeric printing functions for HAL_DEVICEBUFFER.
;

#define _STR_U8(  reg, ...)   PRINT_REG_U8  reg, ##__VA_ARGS__
#define _STR_U16( reg, ...)   PRINT_REG_U16 reg, ##__VA_ARGS__
#define _STR_U32( reg, ...)   PRINT_REG_U32 reg, ##__VA_ARGS__
#define _STR_S8(  reg, ...)   PRINT_REG_S8  reg, ##__VA_ARGS__
#define _STR_S16( reg, ...)   PRINT_REG_S16 reg, ##__VA_ARGS__
#define _STR_S32( reg, ...)   PRINT_REG_S32 reg, ##__VA_ARGS__
#define _STR_U64( reg, ...)   PRINT_REG_U64 reg, ##__VA_ARGS__
#define _STR_S64( reg, ...)   PRINT_REG_S64 reg, ##__VA_ARGS__

.macro PRINT_REG_U8 reg=r22, pad=0
  PUSH_MANY r16, r23, r24, r25
  .ifnc \reg, r22
     PUSH     \reg
     mov      r22, \reg
  .endif
    CLR_MANY  r23, r24, r25
    ldi       r16, \pad
    rcall     HAL_PRINT_STR_REG_PAD_UINT32
  .ifnc \reg, r22
     POP      \reg
  .endif
  POP_MANY r25, r24, r23, r16
.endm
.macro PRINT_REG_U16 reg=r22, pad=0
  PUSH_MANY r16, r24, r25
  .ifnc \reg, r22
    PUSH_MANY  \reg, \reg+1
    movw     r22, \reg
  .endif
      CLR_MANY  r24, r25
      ldi       r16, \pad
      rcall     HAL_PRINT_STR_REG_PAD_UINT32
  .ifnc \reg, r22
    POP_MANY  \reg+1, \reg
  .endif
  POP_MANY r25, r24, r16
.endm
.macro PRINT_REG_U32 reg=r22, pad=0
  PUSH r16
  .ifnc \reg, r22
     PUSH  \reg
     mov4     r22, \reg
  .endif
    ldi       r16, \pad
    rcall     HAL_PRINT_STR_REG_PAD_UINT32
  .ifnc \reg, r22
     POP  \reg
  .endif
  POP r16
.endm
.macro PRINT_REG_U64 reg=r18, pad=0
  PUSH r16
  .ifnc \reg, r18
    .error "PRINT_REG_U64: wrong reg, must be r18"
        .exitm
  .endif
    ldi       r16, \pad
    rcall     HAL_PRINT_STR_REG_PAD_UINT64
  POP r16
.endm
.macro PRINT_REG_S8 reg=r22, pad=0
  PUSH_MANY r16, r23, r24, r25
  .ifnc \reg, r22
     PUSH  \reg
     mov      r22, \reg
  .endif
    mov       r25, r22
    lsl       r25
    sbc       r25, r25
    mov       r24, r25
    mov       r23, r25
    ldi       r16, \pad
    rcall     HAL_PRINT_STR_REG_PAD_INT32
  .ifnc \reg, r22
     POP  \reg
  .endif
  POP_MANY r25, r24, r23, r16
.endm
.macro PRINT_REG_S16 reg=r22, pad=0
  PUSH_MANY r16, r24, r25
  .ifnc \reg, r22
     PUSH  \reg
     movw     r22, \reg
  .endif
    mov       r25, r23
    lsl       r25
    sbc       r25, r25
    mov       r24, r25
    ldi       r16, \pad
    rcall     HAL_PRINT_STR_REG_PAD_INT32
  .ifnc \reg, r22
     POP  \reg
  .endif
  POP_MANY r25, r24, r16
.endm
.macro PRINT_REG_S32 reg=r22, pad=0
  PUSH r16
  .ifnc \reg, r22
     PUSH  \reg
     mov4     r22, \reg
  .endif
    ldi       r16, \pad
    rcall     HAL_PRINT_STR_REG_PAD_INT32
  .ifnc \reg, r22
     POP  \reg
  .endif
  POP r16
.endm
.macro PRINT_REG_S64 reg=r18, pad=0
  PUSH r16
  .ifnc \reg, r18
    .error "PRINT_REG_U64: wrong reg, must be r18"
        .exitm
  .endif
    ldi       r16, \pad
    rcall     HAL_PRINT_STR_REG_PAD_INT64
  POP r16
.endm

; Function: HAL_PRINT_STR_REG_PAD_UINT32
; Description: Prints a 32-bit unsigned integer in decimal format.
; Inputs:       Z - Points to Buffer Structure
;             r16 - minimum width (number of digits). If 0 → no padding (classic behavior)
;         r25:r22 - 32-bit unsigned value
; Outputs: None
FUNC HAL_PRINT_STR_REG_PAD_UINT32
    PUSH_MANY r17, r18, r19, r20, r21, r22, r23, r24, r25
    clr       r17                           ; Initialize digit counter
  1:
    ldi       r18, 10                       ; Divisor = 10
    CLR_MANY  r19, r20, r21                 ; clear r21:r19
    rcall     MATH_UDIV_32                  ; r25:r22 /= 10, remainder in r18
    subi      r18, -'0'                     ; ASCII convert
    push      r18
    inc       r17
    mov       r18, r22                      ; Zero check
    or        r18, r23
    or        r18, r24
    or        r18, r25
    brne      1b
                                            ; Add leading zero padding if needed
    cp        r17, r16                      ; compare actual digits vs desired width
    brsh      3f                            ; if actual >= desired → no padding
    sub       r16, r17                      ; r20 = number of zeros to add
  2:
    ldi       r22, '0'
    rcall     HAL_DEVICEBUFFER_PUSH
    dec       r16
    brne      2b
  3:
    pop       r22                           ; Print digits
    rcall     HAL_DEVICEBUFFER_PUSH         ;
    dec       r17                           ;
    brne      3b                            ;
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18, r17
ENDF HAL_PRINT_STR_REG_PAD_UINT32

; Function: HAL_PRINT_STR_REG_PAD_INT32
; Description: Prints a 32-bit signed integer.
; Inputs:       Z - Points to Buffer Structure
;             r16 - minimum width (number of digits). If 0 → no padding (classic behavior)
;         r25:r22 - 32-bit signed value
; Outputs: None
FUNC HAL_PRINT_STR_REG_PAD_INT32
    sbrs  r25, 7
    rjmp  HAL_PRINT_STR_REG_PAD_UINT32
    PUSH  r22
    ldi   r22, '-'
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    com   r25
    com   r24
    com   r23
    neg   r22
    sbci  r23, -1
    sbci  r24, -1
    sbci  r25, -1
    rjmp  HAL_PRINT_STR_REG_PAD_UINT32
ENDF HAL_PRINT_STR_REG_PAD_INT32

; Function: HAL_PRINT_STR_REG_PAD_UINT64
; Description: Prints a 64-bit unsigned integer in decimal format.
; Inputs:       Z - Points to Buffer Structure
;             r16 - minimum width (number of digits). If 0 → no padding (classic behavior)
;         r25:r18 - 64-bit unsigned value (r25:H ... r18:L)
; Outputs: None
FUNC HAL_PRINT_STR_REG_PAD_UINT64
    PUSH_MANY r14, r15, r17, r18, r19, r20, r21, r22, r23, r24, r25
    clr   r14
    mov   r15, r16                      ; Pad digits
  1:
    clr   r16                           ; Remainder accumulator
    ldi   r17, 64                       ; 64 bits to process
  2:
    lsl   r18
    rol   r19
    rol   r20
    rol   r21
    rol   r22
    rol   r23
    rol   r24
    rol   r25
    rol   r16                           ; Shift bit into remainder
    cpi   r16, 10                       ; Compare remainder with 10
    brcs  3f                            ; If rem < 10, skip sub
    subi  r16, 10                       ; rem -= 10
    ori   r18, 1                        ; Set quotient bit
  3:
    dec   r17
    brne  2b                            ; Loop 64 times

    subi  r16, -'0'                     ; Convert digit to ASCII
    push  r16                           ; Store on stack
    inc   r14                           ;
    ; Check if quotient is zero
    mov   r16, r18
    or    r16, r19
    or    r16, r20
    or    r16, r21
    or    r16, r22
    or    r16, r23
    or    r16, r24
    or    r16, r25
    brne  1b
                                            ; Add leading zero padding if needed
    cp        r14, r15                      ; compare actual digits vs desired width
    brsh      5f                            ; if actual >= desired → no padding
    sub       r15, r14                      ; r15 = number of zeros to add
  4:
    ldi       r22, '0'
    rcall     HAL_DEVICEBUFFER_PUSH
    dec       r15
    brne      4b
  5:
    pop   r22
    rcall HAL_DEVICEBUFFER_PUSH
    dec   r14
    brne  5b
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18, r17, r15, r14
ENDF HAL_PRINT_STR_REG_PAD_UINT64
; Function: HAL_PRINT_STR_REG_PAD_INT64
; Description: Prints a 64-bit signed integer.
; Inputs:       Z - Points to Buffer Structure
;             r16 - minimum width (number of digits). If 0 → no padding (classic behavior)
;         r25:r18 - 64-bit signed value
; Outputs: None
FUNC HAL_PRINT_STR_REG_PAD_INT64
    sbrs  r25, 7
    rjmp  HAL_PRINT_STR_REG_PAD_UINT64
    PUSH  r22
    ldi   r22, '-'
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    com   r25
    com   r24
    com   r23
    com   r22
    com   r21
    com   r20
    com   r19
    neg   r18
    sbci  r19, -1
    sbci  r20, -1
    sbci  r21, -1
    sbci  r22, -1
    sbci  r23, -1
    sbci  r24, -1
    sbci  r25, -1
    rjmp  HAL_PRINT_STR_REG_PAD_UINT64
ENDF HAL_PRINT_STR_REG_PAD_INT64
