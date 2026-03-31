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

; -----------------------------------------------------------------------------
; Function: VEML6075_WRITE_REG
; Description: Writes a 16-bit value to a VEML6075 register.
; Inputs:  r22 - Register address
;          r25:r24 - 16-bit data (MSB:LSB)
; Outputs: r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC VEML6075_WRITE_REG
  PUSH r20
    mov     r20, r22
    ldi     r22, VEML6075_ADDR
    rcall   HAL_I2C_START_WRITE
    tst     r18
    brne    3f

    mov     r22, r20
    rcall   HAL_I2C_WRITE               ; Send register address
    tst     r18
    brne    3f

    mov     r22, r24                    ; Data LSB
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    3f

    mov     r22, r25                    ; Data MSB
    rcall   HAL_I2C_WRITE

  3:
    rcall   HAL_I2C_STOP
  POP r20
ENDF VEML6075_WRITE_REG

; -----------------------------------------------------------------------------
; Function: VEML6075_READ_REG
; Description: Reads a 16-bit value from a VEML6075 register.
; Inputs:  r22 - Register address
; Outputs: r23:r22 - 16-bit data (MSB:LSB)
;          r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC VEML6075_READ_REG
  PUSH  r20
    mov     r20, r22                    ; Store register address

    ldi     r22, VEML6075_ADDR          ; Phase 0: Write VEML Address
    rcall   HAL_I2C_START_WRITE
    tst     r18
    brne    4f

    mov     r22, r20                    ; Phase 1: Write register address
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    4f

    ldi     r22, VEML6075_ADDR          ; Phase 2: Switch to Read
    rcall   HAL_I2C_START_READ
    tst     r18
    brne    4f

    rcall   HAL_I2C_READ_ACK            ; Read LSB
    mov     r20, r22
    rcall   HAL_I2C_READ_NACK           ; Read MSB (last byte)
    mov     r23, r22
    mov     r22, r20
    ldi     r18, 0                      ; Success
    rjmp    5f

  4:
    rcall   HAL_I2C_STOP
    ldi     r18, 1                      ; Error
  5:
  POP r20
ENDF VEML6075_READ_REG
