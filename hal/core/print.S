; File: hal/core/print.S
; Description: Formatted string and character printing engine for HAL_DEVICEBUFFER.
;              Provides convenience macros and streaming routines for Flash strings.
;
; Shorthand Macros:
;   _STR("text")      - Stream Flash string literal to active buffer
;   _STRC(reg)        - Stream single character register to active buffer
;   _STRNR()          - Stream CRLF newline to active buffer
;   _STR_FLUSH([ms])  - Flush buffer via USART with optional delay
;   _ASCIZ(name, txt) - Define null-terminated string in .progmem.rodata

#define _ASCIZ(name, text)              ASCIZ name text
#define _STR(text)                      PRINT_STR text
#define _STRNR()                        PRINT_STR_NEWLINE
#define _STRC(reg)                      PRINT_STR_CHAR reg
#define _STR_FLUSH(ms)                  HAL_FLUSH ms

; Macro: HAL_FLUSH
; Description: Triggers a USART flush of the active device buffer with optional delay.
; Inputs:      ms - Milliseconds to delay after flush (default 0)
; Outputs:     None
.macro HAL_FLUSH ms=0
    call    HAL_USART_FLUSH_DEVICEBUFFER
    .if \ms > 0
      _DELAY_MS(\ms)
    .endif
.endm

; Macro: ASCIZ
; Description: Stores a null-terminated string in Flash (.progmem.rodata)
;              and calculates the length constant (name_len).
; Inputs:      name - Label for the string
;              text - String content
; Outputs:     name_len - Constant holding length excluding null terminator
.macro ASCIZ name, text
  .pushsection .progmem.rodata
    \name: .asciz "\text"
    .set \name\()_len, . - \name - 1
  .popsection
.endm

; Macro: PRINT_STR_NEWLINE
; Description: Pushes a carriage return and newline (\r\n) into active buffer.
; Inputs:      Z - Points to active DeviceBuffer descriptor
; Outputs:     None
.macro PRINT_STR_NEWLINE
  PUSH_MANY r22
    ldi     r22, '\r'
    call    HAL_DEVICEBUFFER_PUSH       ; Push CR to buffer
    ldi     r22, '\n'
    call    HAL_DEVICEBUFFER_PUSH       ; Push LF to buffer
  POP_MANY r22
.endm

; Macro: PRINT_STR_CHAR
; Description: Pushes a single character to the active buffer.
; Inputs:      reg - Register holding character (default r22)
;              Z   - Points to active DeviceBuffer descriptor
; Outputs:     None
.macro PRINT_STR_CHAR reg=r22
  .ifnc \reg, r22
    PUSH_MANY \reg
    mov     r22, \reg
  .endif
    call    HAL_DEVICEBUFFER_PUSH       ; Push character to buffer
  .ifnc \reg, r22
    POP_MANY \reg
  .endif
.endm

; Macro: PRINT_STR
; Description: Allocates an anonymous Flash string literal in .progmem.rodata
;              and streams it to the active device buffer.
; Inputs:      str - String literal to print (e.g. "Hello\r\n")
;              Z   - Points to active DeviceBuffer descriptor
; Outputs:     None
.macro PRINT_STR str:vararg
  .ifndef str_\@
    .pushsection .progmem.rodata
      str_\@: .asciz \str               ; Store string literal in Flash
    .popsection
  .endif
    PRINT_STR_X str_\@                  ; Print string via memory mapping
.endm

; Macro: PRINT_STR_X
; Description: Internal helper to load Mapped Progmem address into X and call print.
; Inputs:      ascii_str - Label of the string in Flash
;              Z         - Points to active DeviceBuffer descriptor
; Outputs:     None
.macro PRINT_STR_X ascii_str
  PUSH_MANY XL, XH
    ldi2    XL, MAPPED_PROGMEM_START + \ascii_str
    call    HAL_PRINT_STR               ; Stream null-terminated string
  POP_MANY XH, XL
.endm

; Function: HAL_PRINT_STR
; Description: Streams a null-terminated string from memory into the active buffer.
; Inputs:    Z - Points to active DeviceBuffer descriptor
;            X - Points to null-terminated string (RAM or Mapped Flash)
; Outputs:  None
FUNC HAL_PRINT_STR
  PUSH_MANY r22
  0:
    ld      r22, X+                     ; Load byte and post-increment pointer
    tst     r22                         ; Check for null terminator (0x00)
    breq    1f                          ; Exit if end of string
    call    HAL_DEVICEBUFFER_PUSH       ; Push byte to active ring buffer
    brcs    0b                          ; Continue while buffer accepts bytes
  1:
  POP_MANY r22
ENDF HAL_PRINT_STR
