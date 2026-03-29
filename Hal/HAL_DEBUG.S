; File: Hal/HAL_DEBUG.S
; Description: Debug macro/helper library for modern AVR (Dx/Ex).
;              Provides routines for debuging over USART.

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
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    mov     r22, \reg                   ; Load byte from address
    rcall   HAL_PRINT_UINT8_REG         ; Print 8-bit result
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    rcall   HAL_PRINT_HEX_REG           ; Print 8-bit HEX result
    rcall   HAL_PRINT_NEW_LINE
  POP_MANY XH, XL, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_REGW reg, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, XL, XH
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    movw    r22, \reg                   ; Load byte from address
    rcall   HAL_PRINT_UINT16_REG        ; Print 16-bit result
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    rcall   HAL_PRINT_HEXW_REG          ; Print16-bit HEX result
    rcall   HAL_PRINT_NEW_LINE
  POP_MANY XH, XL, r23, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_REGL reg, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, r24, r25, XL, XH
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    movw    r22, \reg                   ; Load byte from address
    rcall   HAL_PRINT_UINT32_REG        ; Print 32-bit result
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    rcall   HAL_PRINT_HEXL_REG          ; Print 32-bit HEX result
    rcall   HAL_PRINT_NEW_LINE
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
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    lds     r22, \addr                  ; Load byte from address
    rcall   HAL_PRINT_UINT8_REG         ; Print 8-bit result
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    rcall   HAL_PRINT_HEX_REG           ; Print 8-bit result
    rcall   HAL_PRINT_NEW_LINE
  POP_MANY XH, XL, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_LDSW addr, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, XL, XH
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    ldsw    r22, \addr                  ; Load byte from address
    rcall   HAL_PRINT_UINT16_REG        ; Print 16-bit result
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    rcall   HAL_PRINT_HEXW_REG          ; Print 16-bit HEX result
    rcall   HAL_PRINT_NEW_LINE
  POP_MANY XH, XL, r23, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
.macro DEBUG_STR_LDSL addr, str:vararg
  .pushsection .progmem.rodata
    str_hex_\@: .asciz " 0x"
    str_\@: .asciz \str                 ; Store string in flash
  .popsection
  PUSH_MANY r22, r23, r24, r25, XL, XH
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    ldsw    r22, \addr                  ; Load byte from address
    rcall   HAL_PRINT_UINT32_REG        ; Print 32-bit result
    ldiw    XL, ( MAPPED_PROGMEM_START + (str_hex_\@) )
    rcall   HAL_PRINT_STR               ; Call string print function
    rcall   HAL_PRINT_HEXL_REG          ; Print 32-bit HEX result
    rcall   HAL_PRINT_NEW_LINE
  POP_MANY XH, XL, r25, r24, r23, r22
  rcall   HAL_USART_FLUSH_DEVICEBUFFER
.endm
