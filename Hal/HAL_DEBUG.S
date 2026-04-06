; File: Hal/HAL_DEBUG.S
; Description: Debug macro/helper library for modern AVR (Dx/Ex).
;              Provides routines for debuging over USART.

#define _DEBUG_REG(reg, text)       DEBUG_STR_REG  reg, text
#define _DEBUG_REG2(reg, text)      DEBUG_STR_REG2 reg, text
#define _DEBUG_REG4(reg, text)      DEBUG_STR_REG4 reg, text

#define _DEBUG_LDS(reg, text)       DEBUG_STR_LDS  reg, text
#define _DEBUG_LDS2(reg, text)      DEBUG_STR_LDS2 reg, text
#define _DEBUG_LDS4(reg, text)      DEBUG_STR_LDS4 reg, text

; Macro: DEBUG_STR_REG
; Description: Inline macro to print a string literal followed by a byte value from a register.
; Inputs:  reg - register to read from
;          str - The string literal to print
; Outputs: None
.macro DEBUG_STR_REG reg, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, XL, XH
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    mov     r22, \reg                   ; Load byte from address
    _STR_REG_U8()                       ; Print 8-bit result
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    _STR_HEX()                          ; Print 8-bit HEX result
    _STRNR()
  POP_MANY XH, XL, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_REG2 reg, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, XL, XH
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    movw    r22, \reg                   ; Load byte from address
    _STR_REG_U16()                      ; Print 16-bit result
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    _STR_HEX(r23, r22)                  ; Print16-bit HEX result
    _STRNR()
  POP_MANY XH, XL, r23, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_REG4 reg, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, r24, r25, XL, XH
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    movw    r22, \reg                   ; Load byte from address
    _STR_REG_U32()                      ; Print 32-bit result
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    _STR_HEX(r25,r24,r23,r22)           ; Print 32-bit HEX result
    _STRNR()
  POP_MANY XH, XL, r25, r24, r23, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm

; Macro: DEBUG_STR_LDS
; Description: Inline macro to print a string literal followed by a byte value from an address.
; Inputs:  addr - SRAM address to read from
;          str  - The string literal to print
; Outputs: None
.macro DEBUG_STR_LDS addr, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, XL, XH
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    lds     r22, \addr                  ; Load byte from address
    _STR_REG_U8()                       ; Print 8-bit result
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    _STR_HEX()                          ; Print 8-bit result
    _STRNR()
  POP_MANY XH, XL, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_LDS2 addr, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, XL, XH
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    lds2    r22, \addr                  ; Load byte from address
    _STR_REG_U16()                      ; Print 16-bit result
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    _STR_HEX(r23, r22)                 ; Print 16-bit HEX result
    _STRNR()
  POP_MANY XH, XL, r23, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_LDS4 addr, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, r24, r25, XL, XH
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    lds4    r22, \addr                  ; Load byte from address
    _STR_REG_U32()                      ; Print 32-bit result
    ldi2    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    _STR_HEX(r25, r24, r23, r22)        ; Print 32-bit HEX result
    _STRNR()
  POP_MANY XH, XL, r25, r24, r23, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
