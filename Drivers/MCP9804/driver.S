#define MCP9804_ADDR              0x18

; MCP9804 Registers
#define MCP9804_REG_CONF          0x01
#define MCP9804_REG_T_HIGH        0x02
#define MCP9804_REG_T_LOW         0x03
#define MCP9804_REG_T_CRIT        0x04
#define MCP9804_REG_T_AMB         0x05
#define MCP9804_REG_MANUFACTURER  0x06
#define MCP9804_REG_ID            0x07
#define MCP9804_REG_RESOLUTION    0x08

; Configuration bits
#define MCP9804_CONF_SLEEP_bm     0x0100

; MCP9804 sram structure
.section .data
MCP9804_struct:
  MCP9804_LAST:       .word 0
; -----------------------------------------------------------------------------
; Function: MCP9804_READ_TEMPERATURE
; Description: Read Temperature from MCP9804.
;              Handles 13-bit Two's Complement format.
; Outputs:     r22 - Integer part (Absolute)
;              r23 - Sign (0:+, 1:-)
;          r25:r24 - Decimal part (x10000, e.g. 625 = .0625)
;               Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC MCP9804_READ_TEMPERATURE
  PUSH_MANY r19, r20, r21
    ldi     r22, MCP9804_ADDR
    ldi     r23, MCP9804_REG_T_AMB
    rcall   HAL_I2C_READ_REGW_BE        ; Result in r23:r22 (Big Endian)
    brcs    .L_exit

    sts2    MCP9804_LAST, r22           ; Save raw register (LSB in r22, MSB in r23)
    movw    r24, r22                    ; r25:r24 = raw data
    andi    r25, 0x1F                   ; Mask flags (keep 13 bits)

    clr     r21                         ; r21 will hold our sign
    sbrs    r25, 4                      ; Check sign bit (bit 12 of register)
    rjmp    .L_positive

    ; Handle Negative (Two's Complement Negation)
    ldi     r21, 1                      ; Sign = Negative
    com     r24                         ; Invert bits
    com     r25
    andi    r25, 0x1F                   ; Keep 13 bits
    subi    r24, lo8(-1)                ; Add 1 (Two's Complement)
    sbci    r25, hi8(-1)
    andi    r25, 0x1F

  .L_positive:
    ; Extract Fractional part (bits 3:0)
    mov     r18, r24
    andi    r18, 0x0F
    clr     r19                         ; r19:r18 = fraction

    ; Extract Integer part (Value >> 4)
    lsr     r25
    ror     r24
    lsr     r25
    ror     r24
    lsr     r25
    ror     r24
    lsr     r25
    ror     r24
    mov     r20, r24                    ; r20 = Integer part

    ; Calculate Decimal: Fraction * 625
    ldi2    r22, 625
    rcall   MATH_MUL_16_32              ; r25:r22 = r23:r22 * r19:r18
    movw    r24, r22                    ; Decimal in r25:r24

    mov     r22, r20                    ; Return integer in r22
    mov     r23, r21                    ; Return sign in r23
    clc                                 ; Success

  .L_exit:
  POP_MANY r21, r20, r19
ENDF MCP9804_READ_TEMPERATURE

; -----------------------------------------------------------------------------
; Macro: MCP9804_READ_REG reg
; Description: Read an internal MCP9804 register
; Outputs:  r23:r22 - Data
;                Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
.macro MCP9804_READ_REG reg
    ldi     r22, MCP9804_ADDR
    ldi     r23, \reg
    rcall   HAL_I2C_READ_REGW_BE
.endm

; -----------------------------------------------------------------------------
; Function: MCP9804_ENABLE
; Description: Enable sensor continuous measuring (Clear SHDN bit)
; Outputs :   Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC MCP9804_ENABLE
  PUSH_MANY r22, r23, r24, r25
    ldi     r22, MCP9804_ADDR
    ldi     r23, MCP9804_REG_CONF
    rcall   HAL_I2C_READ_REGW_BE
    brcs    1f

    andi2   r24, ~MCP9804_CONF_SLEEP_bm
    rcall   HAL_I2C_WRITE_REGW_BE
  1:
  POP_MANY r25, r24, r23, r22
ENDF MCP9804_ENABLE

; -----------------------------------------------------------------------------
; Function: MCP9804_DISABLE
; Description: Disable sensor (Set SHDN bit)
; Outputs:  Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC MCP9804_DISABLE
  PUSH_MANY r22, r23, r24, r25
    ldi     r22, MCP9804_ADDR
    ldi     r23, MCP9804_REG_CONF
    rcall   HAL_I2C_READ_REGW_BE
    brcs    1f

    ori2    r24, MCP9804_CONF_SLEEP_bm
    rcall   HAL_I2C_WRITE_REGW_BE
  1:
  POP_MANY r25, r24, r23, r22
ENDF MCP9804_DISABLE
