; File: Hal/HAL_PRINT.S
; Description: String and numeric printing functions for HAL_DEVICEBUFFER.
;
; Example Usage:
;   PRINT_STR "Hello World\r\n"
;
;   ldi     r22, 123
;   rcall   HAL_PRINT_UINT8_REG
;
;   ldi     ZL, lo8(my_buf)
;   ldi     ZH, hi8(my_buf)
;   rcall   HAL_PRINT_NEW_LINE

; Macro: PRINT_STR
; Description: Inline macro to print a string literal.
; Inputs:  str - The string literal to print
; Outputs: None
.macro PRINT_STR str:vararg
    .pushsection .progmem.rodata
    str_\@: .asciz \str                 ; Store string in flash
    .popsection
    PRINT_STR_X str_\@                  ; Print the stored string
.endm

; Macro: PRINT_STR_X
; Description: Internal macro to load string address from flash and print.
; Inputs:  ascii_str - Label of the string in flash
; Outputs: None
.macro PRINT_STR_X ascii_str
    ldi     XL, lo8( MAPPED_PROGMEM_START + (\ascii_str) )
    ldi     XH, hi8( MAPPED_PROGMEM_START + (\ascii_str) )
    rcall   HAL_PRINT_STR               ; Call string print function
.endm

; Function: HAL_PRINT_NEW_LINE
; Description: Pushes a carriage return and line feed (\r\n) to the buffer.
; Inputs:  Z   - Points to Buffer Structure
; Outputs: None
FUNC HAL_PRINT_NEW_LINE
  PUSH r22
    ldi   r22, '\r'                     ; Load CR
    rcall HAL_DEVICEBUFFER_PUSH         ; Push to buffer
    ldi   r22, '\n'                     ; Load LF
    rcall HAL_DEVICEBUFFER_PUSH         ; Push to buffer
  POP r22
ENDF HAL_PRINT_NEW_LINE

; Function: HAL_PRINT_STR
; Description: Pushes a null-terminated string from memory into the buffer.
; Inputs:  Z   - Points to Buffer Structure
;          X   - Points to null-terminated string
; Outputs: r18 - 0: Success, 1: Buffer full
FUNC HAL_PRINT_STR
  PUSH  r22
  0:
    ld      r22, X+                     ; Load byte and increment X
    tst     r22                         ; Check for null terminator
    breq    1f                          ; Exit if end of string
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push byte to buffer
    tst     r18                         ; Check if buffer is full
    breq    0b                          ; Continue if success
  1:
  POP  r22
ENDF HAL_PRINT_STR

; Function: HAL_PRINT_UINT8_REG
; Description: Prints an 8-bit unsigned integer in decimal format.
; Inputs:  Z   - Points to Buffer Structure
;          r22 - 8-bit unsigned value
; Outputs: None
FUNC HAL_PRINT_UINT8_REG
    PUSH_MANY r14, r18, r22
    clr   r14                           ; Initialize digit counter
  1:
    ldi   r18, 10                       ; Divisor = 10
    rcall MATH_UDIV_08_08               ; r22 /= 10, remainder in r18
    subi  r18, -'0'                     ; Convert remainder to ASCII
    push  r18                           ; Store digit on stack
    inc   r14                           ; Increment digit count
    tst     r22                         ; Check if quotient is zero
    brne    1b                          ; Continue if not zero
  2:
    pop     r22                         ; Pop digit (MSD first)
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push to buffer
    dec     r14                         ; Decrement count
    brne    2b                          ; Loop until all digits printed
  POP_MANY r22, r18, r14
ENDF HAL_PRINT_UINT8_REG

; Function: HAL_PRINT_UINT16_REG
; Description: Prints a 16-bit unsigned integer in decimal format.
; Inputs:  Z       - Points to Buffer Structure
;          r23:r22 - 16-bit unsigned value
; Outputs: None
FUNC HAL_PRINT_UINT16_REG
    PUSH_MANY r14, r16, r18, r19, r22, r23
    clr   r14                           ; Initialize digit counter
  1:
    ldi   r18, 10                       ; Divisor = 10
    clr   r19                           ;
    rcall MATH_UDIV_16_16               ; r23:r22 /= 10, remainder in r18
    subi  r18, -'0'                     ; Convert remainder to ASCII
    push  r18                           ; Store digit
    inc   r14                           ;
    mov   r16, r22                      ; Check if r23:r22 is zero
    or    r16, r23                      ;
    brne  1b                            ;
  2:
    pop   r22                           ; Print digits
    rcall HAL_DEVICEBUFFER_PUSH         ;
    dec   r14                           ;
    brne  2b                            ;
  POP_MANY r23, r22, r19, r18, r16, r14
ENDF HAL_PRINT_UINT16_REG

; Function: HAL_PRINT_UINT32_REG
; Description: Prints a 32-bit unsigned integer in decimal format.
; Inputs:  Z           - Points to Buffer Structure
;          r25:r24:r23:r22 - 32-bit unsigned value
; Outputs: None
FUNC HAL_PRINT_UINT32_REG
    PUSH_MANY r14, r16, r18, r19, r20, r21, r22, r23, r24, r25
    clr   r14
  1:
    ldi   r18, 10                       ; Divisor = 10
    clr   r19
    clr   r20
    clr   r21
    rcall MATH_UDIV_32_32               ; r25:r22 /= 10, remainder in r18
    subi  r18, -'0'                     ; ASCII convert
    push  r18
    inc   r14
    mov   r16, r22                      ; Zero check
    or    r16, r23
    or    r16, r24
    or    r16, r25
    brne  1b
  2:
    pop   r22
    rcall HAL_DEVICEBUFFER_PUSH
    dec   r14
    brne  2b
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18, r16, r14
ENDF HAL_PRINT_UINT32_REG

; Function: HAL_PRINT_UINT64_REG
; Description: Prints a 64-bit unsigned integer in decimal format.
; Inputs:  Z           - Points to Buffer Structure
;          r25:r18     - 64-bit unsigned value (r25:H ... r18:L)
; Outputs: None
FUNC HAL_PRINT_UINT64_REG
    PUSH_MANY r14, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25
    clr   r14
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
  2:
    pop   r22
    rcall HAL_DEVICEBUFFER_PUSH
    dec   r14
    brne  2b
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18, r17, r16, r14
ENDF HAL_PRINT_UINT64_REG

; Function: HAL_PRINT_INT8_REG
; Description: Prints an 8-bit signed integer.
; Inputs:  Z   - Points to Buffer Structure
;          r22 - 8-bit signed value
; Outputs: None
FUNC HAL_PRINT_INT8_REG
    sbrs  r22, 7                        ; Check sign bit
    rjmp  HAL_PRINT_UINT8_REG           ; Positive: print as unsigned
    PUSH  r22
    ldi   r22, '-'                      ; Negative: print '-' sign
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    neg   r22                           ; Make value positive
    rjmp  HAL_PRINT_UINT8_REG           ; Print magnitude
ENDF HAL_PRINT_INT8_REG

; Function: HAL_PRINT_INT16_REG
; Description: Prints a 16-bit signed integer.
; Inputs:  Z       - Points to Buffer Structure
;          r23:r22 - 16-bit signed value
; Outputs: None
FUNC HAL_PRINT_INT16_REG
    sbrs  r23, 7                        ; Check sign bit
    rjmp  HAL_PRINT_UINT16_REG
    PUSH  r22
    ldi   r22, '-'
    rcall HAL_DEVICEBUFFER_PUSH
    POP   r22
    com   r23                           ; 2's complement negation
    neg   r22
    sbci  r23, -1
    rjmp  HAL_PRINT_UINT16_REG
ENDF HAL_PRINT_INT16_REG

; Function: HAL_PRINT_INT32_REG
; Description: Prints a 32-bit signed integer.
; Inputs:  Z               - Points to Buffer Structure
;          r25:r24:r23:r22 - 32-bit signed value
; Outputs: None
FUNC HAL_PRINT_INT32_REG
    sbrs  r25, 7
    rjmp  HAL_PRINT_UINT32_REG
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
    rjmp  HAL_PRINT_UINT32_REG
ENDF HAL_PRINT_INT32_REG

; Function: HAL_PRINT_INT64_REG
; Description: Prints a 64-bit signed integer.
; Inputs:  Z       - Points to Buffer Structure
;          r25:r18 - 64-bit signed value
; Outputs: None
FUNC HAL_PRINT_INT64_REG
    sbrs  r25, 7
    rjmp  HAL_PRINT_UINT64_REG
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
    rjmp  HAL_PRINT_UINT64_REG
ENDF HAL_PRINT_INT64_REG
