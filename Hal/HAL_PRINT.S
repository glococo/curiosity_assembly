; File: Hal/HAL_PRINT.S
; Description: String printing functions for HAL_DEVICEBUFFER.
;

#define _ASCIZ(name,text)         ASCIZ name text
#define _STR( text )              PRINT_STR text
#define _STRNR()                  PRINT_STR_NEWLINE
#define _STRC( reg )              PRINT_STR_CHAR reg
#define _STR_FLUSH(ms)            HAL_FLUSH ms

.macro HAL_FLUSH ms=0
  rcall HAL_USART_FLUSH_DEVICEBUFFER
  .if \ms > 0
    _DELAY_MS(\ms)
  .endif
.endm
.macro ASCIZ name, text
  .pushsection .progmem.rodata
    \name: .asciz "\text"
    .set \name\()_len, . - \name - 1
  .popsection
.endm

.macro PRINT_STR_NEWLINE
  PUSH r22
    ldi    r22, '\r'
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push byte to buffer
    ldi    r22, '\n'
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push byte to buffer
  POP r22
.endm
.macro PRINT_STR_CHAR reg=r22
  .ifnc \reg, r22
     PUSH  \reg
     mov      r22, \reg
  .endif
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push byte to buffer
  .ifnc \reg, r22
     POP  \reg
  .endif
.endm
.macro PRINT_STR str:vararg
  .ifndef str_\@
    .pushsection .progmem.rodata
      str_\@: .asciz \str               ; Store string in flash
    .popsection
  .endif
    PRINT_STR_X str_\@                  ; Print the stored string
.endm

; Macro: PRINT_STR_X
; Description: Internal macro to load string address from flash and print.
; Inputs:  ascii_str - Label of the string in flash
; Outputs: None
.macro PRINT_STR_X ascii_str
  PUSH_MANY XL, XH
    ldi2    XL, MAPPED_PROGMEM_START + \ascii_str
    call    HAL_PRINT_STR               ; Call string print function
  POP_MANY XH, XL
.endm

; Function: HAL_PRINT_STR
; Description: Pushes a null-terminated string from memory into the buffer.
; Inputs:   Z - Points to Buffer Structure
;           X - Points to null-terminated string
FUNC HAL_PRINT_STR
  PUSH r22
  0:
    ld      r22, X+                     ; Load byte and increment X
    tst     r22                         ; Check for null terminator
    breq    1f                          ; Exit if end of string
    rcall   HAL_DEVICEBUFFER_PUSH       ; Push byte to buffer
    brcs    0b                          ; Continue if success
  1:
  POP r22
ENDF HAL_PRINT_STR
