#define VEML6075_ADDR 0x10

; VEML6075 Registers
#define VEML6075_REG_CONF      0x00
#define VEML6075_REG_UVA       0x07
#define VEML6075_REG_UVB       0x09
#define VEML6075_REG_UVCOMP1   0x0A
#define VEML6075_REG_UVCOMP2   0x0B
#define VEML6075_REG_ID        0x0C

; Configuration bits
#define VEML6075_CONF_IT_50MS      0x00
#define VEML6075_CONF_IT_100MS     0x10
#define VEML6075_CONF_IT_200MS     0x20
#define VEML6075_CONF_IT_400MS     0x30
#define VEML6075_CONF_IT_800MS     0x40
#define VEML6075_CONF_UV_TRIG      0x40
#define VEML6075_CONF_HD_NORMAL    0x00
#define VEML6075_CONF_HD_HDR       0x08
#define VEML6075_CONF_POWER_ON     0x00
#define VEML6075_CONF_POWER_OFF    0x01

; Scale every coefficient by 256 (2^8)
; All divisions by 256 become simple 8-bit right shifts on 32-bit results,
; no slow div instructions, just lsr/ror.
#define VEML6075_UVA_A_FP        568   // 2.22 × 256
#define VEML6075_UVA_B_FP        340   // 1.33 × 256
#define VEML6075_UVB_C_FP        755   // 2.95 × 256
#define VEML6075_UVB_D_FP        445   // 1.74 × 256
#define VEML6075_UVA_RESP_FP     238   // 0.93 × 256
#define VEML6075_UVB_RESP_FP     538   // 2.10 × 256

; VEML6075 sram structure
.section .data
VEML6075_struct:
  VEML6075_UVA:       .word 0
  VEML6075_UVB:       .word 0
  VEML6075_UVAc:      .word 0
  VEML6075_UVBc:      .word 0
  VEML6075_UVI:       .word 0
  VEML6075_UVCOMP1:   .word 0
  VEML6075_UVCOMP2:   .word 0

; -----------------------------------------------------------------------------
; Macro: VEML6075_READ_REG reg
; Description: Read an internal VEML6075 register
; Outputs:  r23:r22 - Data
;                Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
.macro VEML6075_READ_REG reg
    ldi     r22, VEML6075_ADDR
    ldi     r23, \reg
    rcall   HAL_I2C_READ_REGW
.endm

; -----------------------------------------------------------------------------
; Function: VEML6075_READ_ID
; Description: Read Device ID (must read 2byte)
; Outputs: r22 - Device ID
;           Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC VEML6075_READ_ID
  PUSH r23
    ldi     r22, VEML6075_ADDR
    ldi     r23, VEML6075_REG_ID
    rcall   HAL_I2C_READ_REGW
  POP r23
ENDF VEML6075_READ_ID
; -----------------------------------------------------------------------------
; Function: VEML6075_ENABLE
; Description: Enable sensor measuring every 100ms
; Outputs:  Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC VEML6075_ENABLE
  PUSH_MANY r22, r23, r24, r25
    ldi     r22, VEML6075_ADDR
    ldi     r23, VEML6075_REG_CONF
    ldi     r24, (VEML6075_CONF_IT_100MS | VEML6075_CONF_HD_NORMAL | VEML6075_CONF_POWER_ON)
    ldi     r25, 0
    rcall   HAL_I2C_WRITE_REGW
  POP_MANY r25, r24, r23, r22
ENDF VEML6075_ENABLE
; -----------------------------------------------------------------------------
; Function: VEML6075_DISABLE
; Description: Disable sensor
; Outputs:  Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC VEML6075_DISABLE
  PUSH_MANY r22, r23, r24
    ldi     r22, VEML6075_ADDR
    ldi     r23, VEML6075_REG_CONF
    ldi     r24, VEML6075_CONF_POWER_OFF
    rcall   HAL_I2C_WRITE_REG
  POP_MANY r24, r23, r22
ENDF VEML6075_DISABLE
; -----------------------------------------------------------------------------
; Function: VEML6075_READ
; Description: Read a block of memory to VEML6075 X structure
; Outputs:   X - VEML6075_struct
;           Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC VEML6075_READ
  PUSH_MANY r22, r23
    ldi     r22, VEML6075_ADDR
    ldi     r23, VEML6075_REG_UVA
    rcall   HAL_I2C_READ_REGW           ; Read UVA data
    brcs    0f
    sts2    VEML6075_UVA, r22

    ldi     r22, VEML6075_ADDR
    ldi     r23, VEML6075_REG_UVB
    rcall   HAL_I2C_READ_REGW           ; Read UVB data
    brcs    0f
    sts2    VEML6075_UVB, r22

    ldi     r22, VEML6075_ADDR
    ldi     r23, VEML6075_REG_UVCOMP1
    rcall   HAL_I2C_READ_REGW           ; Read UVCOMP1 data
    brcs    0f
    sts2    VEML6075_UVCOMP1, r22

    ldi     r22, VEML6075_ADDR
    ldi     r23, VEML6075_REG_UVCOMP2
    rcall   HAL_I2C_READ_REGW           ; Read UVCOMP2 data
    brcs    0f
    sts2    VEML6075_UVCOMP2, r22

    rcall   VEML6075_CORRECT            ; do the math
  0:
  POP_MANY r23, r22
ENDF VEML6075_READ

; -----------------------------------------------------------------------------
; Function: VEML6075_CORRECT
; Description: Calculate UVAcomp, UVBcomp and UVIndex
; Output:  Cf - 0: Done
; -----------------------------------------------------------------------------
FUNC VEML6075_CORRECT
  PUSH_MANY r16, r17, r18, r19, r20, r21, r22, r23, r24, r25
  ; --- uvaComp = rawA - ((UVA_A_FP * comp1) >> 8) - ((UVA_B_FP * comp2) >> 8) ---
    lds2    r18, VEML6075_UVCOMP1
    ldi2    r22, VEML6075_UVA_A_FP
    rcall   MATH_MUL_16_32        ; result in r25:r22 (32-bit)
    ldi     r18, 8
    rcall   MATH_LSR_32           ; >> 8 (/256)
    movw    r16, r22              ; mov result to temp (r17:r16)

    lds2    r18, VEML6075_UVCOMP2
    ldi2    r22, VEML6075_UVA_B_FP
    rcall   MATH_MUL_16_32        ; result in r25:r22 (32-bit)
    ldi     r18, 8
    rcall   MATH_LSR_32           ; >> 8 (/256)

    add2s   r22, r16              ; math1 + math2
    lds2    r18, VEML6075_UVA
    sub     r18, r22              ; rawA - (math1 + math2)
    sbc     r19, r23              ;
    brsh    0f                    ; if negative = low light conditions
    ldi     r18, 0x01             ;   load UVAc with 1
    ldi     r19, 0x00
  0:
    sts2    VEML6075_UVAc, r18    ; save to sram

  ; --- uvbComp = rawB - ((UVB_C_FP * comp1) >> 8) - ((UVB_D_FP * comp2) >> 8) ---
    lds2    r18, VEML6075_UVCOMP1
    ldi2    r22, VEML6075_UVB_C_FP
    rcall   MATH_MUL_16_32        ; result in r25:r22 (32-bit)
    ldi     r18, 8
    rcall   MATH_LSR_32           ; >> 8 (/256)
    movw    r16, r22              ; mov result to temp (r17:r16)

    lds2    r18, VEML6075_UVCOMP2
    ldi2    r22, VEML6075_UVB_D_FP
    rcall   MATH_MUL_16_32        ; result in r25:r22 (32-bit)
    ldi     r18, 8
    rcall   MATH_LSR_32           ; >> 8 (/256)

    add2s   r22, r16              ; math1 + math2 (saturated add)
    lds2    r18, VEML6075_UVB
    sub     r18, r22              ; rawB - (math1 + math2)
    sbc     r19, r23              ;
    brsh    1f                    ; if negative = low light conditions
    ldi     r18, 0x01             ;   load UVBc with 1
    ldi     r19, 0x00
  1:
    sts2    VEML6075_UVBc, r18    ; save to sram
    movw    r22, r18

  ; --- UVI = (UVAc*RespFP + UVBc+RespFP) >> 1 ---
    ; --- UVB = UVBc * UVB_RESP_FP >> 8 ---
    ldi2    r18, VEML6075_UVB_RESP_FP
    rcall   MATH_MUL_16_32
    ldi     r18, 8
    rcall   MATH_LSR_32
    movw    r16, r22              ; uvb = r17:r16

    ; --- UVA = UVAc * UVA_RESP_FP >> 8 ---
    lds2    r18, VEML6075_UVAc
    ldi2    r22, VEML6075_UVA_RESP_FP
    rcall   MATH_MUL_16_32
    ldi     r18, 8
    rcall   MATH_LSR_32           ; uva = r23:r22

    add2s   r22, r16              ; UVAc + UVBc
    lsr     r23                   ; >> 1 (divide by 2)
    ror     r22                   ; result in r23:r22
    sts2    VEML6075_UVI, r22
    clc                           ; Clear carry: done
  POP_MANY r25, r24, r23, r22, r21, r20, r19, r18, r17, r16
ENDF VEML6075_CORRECT
