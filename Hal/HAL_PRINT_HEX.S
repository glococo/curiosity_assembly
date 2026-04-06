; File: Hal/HAL_PRINT_NUM.S
; Description: Hex printing functions for HAL_DEVICEBUFFER.
;

#define _STR_HEX( ... )       PRINT_HEX __VA_ARGS__

.macro PRINT_HEX regs:vararg
  .ifb \regs
    rcall HAL_PRINT_HEX_REG
  .else
    .irp reg, \regs
      .ifnc \reg, r22
        PUSH  r22
        mov      r22, \reg
      .endif
        rcall     HAL_PRINT_HEX_REG
      .ifnc \reg, r22
        POP  r22
      .endif
    .endr
  .endif
.endm

; Function: HAL_PRINT_HEX_REG
; Description: Prints an 8-bit value in hexadecimal format (e.g., "AF").
; Inputs:  Z   - Points to Buffer Structure
;          r22 - 8-bit value
; Outputs: None
FUNC HAL_PRINT_HEX_REG
    PUSH_MANY r21, r22
    mov   r21, r22                      ; Save value in r14 (callee-saved)

    swap  r22                           ; High nibble: Swap nibbles
    rcall 1f                            ; Convert and push nibble

    mov   r22, r21                      ; Low nibble: Restore value
    rcall 1f                            ; Convert and push nibble

    POP_MANY r22, r21
    ret

  1: ; Local helper to print nibble in r22
    andi  r22, 0x0F                     ; Mask lower 4 bits
    subi  r22, -'0'                     ; Add '0'
    cpi   r22, '9' + 1                  ; Check if > '9'
    brcs  2f                            ; If <= '9', skip
    subi  r22, -('A' - '9' - 1)         ; Adjust for 'A'-'F'
  2:
    rcall HAL_DEVICEBUFFER_PUSH         ; Carry set if success
    ret
ENDF HAL_PRINT_HEX_REG
