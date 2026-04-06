; File: Hal/HAL_I2C.S
; Description: I2C (TWI) Master-only helper library for AVR-Dx/Ex families.
;              Provides routines for initialization, baudrate calculation,
;              and basic I2C communication (Start, Stop, Write, Read).
;
; Example Usage:
;   rcall   HAL_I2C_INIT                ; Initialize I2C with default baudrate
;
;   ldi     r22, 0x50                   ; Target address (7-bit)
;   rcall   HAL_I2C_START_WRITE         ; Send START and Address + W
;   tst     r18
;   brne    error                       ; Check for NACK or Bus Error
;
;   ldi     r22, 0x00                   ; Register address
;   rcall   HAL_I2C_WRITE               ; Send byte
;
;   rcall   HAL_I2C_STOP                ; Send STOP

#ifndef I2C_BAUD_RATE_KHZ
  #define I2C_BAUD_RATE_KHZ   50
#endif

; Function: HAL_I2C_BAUDRATE_UPD
; Description: Recomputes the TWI MBAUD register based on BOARD_CLOCK_MAIN,
;              current CPU prescaler, and I2C_BAUD_RATE.
;              Formula: MBAUD = fCLK_PER / (2 * fSCL) - 5
; Inputs:  None
; Outputs: None (Updates TWI0_MBAUD)
FUNC HAL_I2C_BAUDRATE_UPD
  PUSH_MANY r18, r19, r22, r23, r24, r25
    ; Load dividend: fCLK_PER (in KHz)
    ; HAL_CLK_MAIN_KHZ is in kHz
    lds     r18, HAL_CLK_MAIN_DIV       ; Load divisor index
    lds4    r22, HAL_CLK_MAIN_KHZ
    rcall   MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18

    ldi2    r18, (2 * I2C_BAUD_RATE_KHZ)
    rcall   MATH_UDIV_16                ; r23:r22 = fCLK_PER / (2 * I2C_BAUD_RATE)

    subi    r22, 5                      ; Subtract 5
    sbci    r23, 0
    brcc    1f                          ; Clamp to 0 if result was < 5
    clr     r22
  1:
    sts     TWI0_MBAUD, r22             ; Store Baud Rate (8-bit register)
  POP_MANY r25, r24, r23, r22, r19, r18
ENDF HAL_I2C_BAUDRATE_UPD

; Function: HAL_I2C_INIT
; Description: Initializes the TWI0 as Master.
; Inputs:  None
; Outputs: None
FUNC HAL_I2C_INIT
  PUSH r18
    rcall   HAL_I2C_BAUDRATE_UPD        ; Initialize baudrate

    ldi     r18, TWI_ENABLE_bm          ; Enable TWI Master
    sts     TWI0_MCTRLA, r18

    ldi     r18, TWI_BUSSTATE_IDLE_gc   ; Force Idle state
    sts     TWI0_MSTATUS, r18
  POP r18
ENDF HAL_I2C_INIT

; Function: HAL_I2C_START
; Description: Sends a START condition followed by Address + R/W bit.
; Inputs:  r22 - (Address << 1) | R/W
; Outputs: r18 - 0: Success, 1: Error (NACK or Bus Error)
FUNC HAL_I2C_START
    sts     TWI0_MADDR, r22             ; Writing to MADDR sends START + Address
  1:
    lds     r18, TWI0_MSTATUS
    sbrc    r18, TWI_WIF_bp             ; Wait for Write Interrupt Flag (Address sent)
    rjmp    2f
    sbrc    r18, TWI_RIF_bp             ; Or Read Interrupt Flag
    rjmp    2f
    rjmp    1b
  2:
    ; Check for errors: RXACK (bit 4), BUSERR (bit 2), ARBLOST (bit 3)
    andi    r18, (1<<TWI_RXACK_bp) | (1<<TWI_BUSERR_bp) | (1<<TWI_ARBLOST_bp)
    breq    3f                          ; If no error bits set, success
    ldi     r18, 1                      ; Return Error
    rjmp    4f
  3:
    ldi     r18, 0                      ; Return Success
  4:
ENDF HAL_I2C_START

; Function: HAL_I2C_START_WRITE
; Description: Helper to start I2C Write transaction.
; Inputs:  r22 - 7-bit Address
; Outputs: r18 - 0: Success, 1: Error
FUNC HAL_I2C_START_WRITE
  PUSH r22
    lsl     r22
    andi    r22, 0xFE
    rcall   HAL_I2C_START
  POP r22
ENDF HAL_I2C_START_WRITE

; Function: HAL_I2C_START_READ
; Description: Helper to start I2C Read transaction.
; Inputs:  r22 - 7-bit Address
; Outputs: r18 - 0: Success, 1: Error
FUNC HAL_I2C_START_READ
  PUSH r22
    lsl     r22
    ori     r22, 0x01
    rcall   HAL_I2C_START
  POP r22
ENDF HAL_I2C_START_READ

; Function: HAL_I2C_STOP
; Description: Sends a STOP condition.
; Inputs:  None
; Outputs: None
FUNC HAL_I2C_STOP
  PUSH r18
    ldi     r18, TWI_MCMD_STOP_gc
    sts     TWI0_MCTRLB, r18
  POP r18
ENDF HAL_I2C_STOP

; Function: HAL_I2C_WRITE
; Description: Writes a byte to the I2C bus.
; Inputs:  r22 - Data byte
; Outputs: r18 - 0: Success (ACK), 1: Error (NACK or other)
FUNC HAL_I2C_WRITE
    sts     TWI0_MDATA, r22
  1:
    lds     r18, TWI0_MSTATUS
    sbrs    r18, TWI_WIF_bp             ; Wait for WIF
    rjmp    1b

    ; Check for NACK (RXACK bit) or Errors
    andi    r18, (1<<TWI_RXACK_bp) | (1<<TWI_BUSERR_bp) | (1<<TWI_ARBLOST_bp)
    breq    2f
    ldi     r18, 1
    rjmp    3f
  2:
    ldi     r18, 0
  3:
ENDF HAL_I2C_WRITE

; Function: HAL_I2C_READ_ACK
; Description: Reads a byte and prepares to send ACK.
; Inputs:  None
; Outputs: r22 - Data byte
;          r18 - 0: Success
FUNC HAL_I2C_READ_ACK
  1:
    lds     r18, TWI0_MSTATUS
    sbrs    r18, TWI_RIF_bp             ; Wait for RIF
    rjmp    1b

    lds     r22, TWI0_MDATA             ; Read data (clears RIF)
    ldi     r18, TWI_MCMD_RECVTRANS_gc  ; Ack and prepare for next byte
    sts     TWI0_MCTRLB, r18

    ldi     r18, 0
ENDF HAL_I2C_READ_ACK

; Function: HAL_I2C_READ_NACK
; Description: Reads a byte and sends NACK + STOP.
; Inputs:  None
; Outputs: r22 - Data byte
;          r18 - 0: Success
FUNC HAL_I2C_READ_NACK
  0:
    lds     r18, TWI0_MSTATUS
    sbrs    r18, TWI_RIF_bp             ; Wait for RIF
    rjmp   0b

    lds     r22, TWI0_MDATA             ; Read data (clears RIF)
    ldi     r18, TWI_ACKACT_NACK_gc | TWI_MCMD_STOP_gc ; NACK and STOP
    sts     TWI0_MCTRLB, r18

    ldi     r18, 0
ENDF HAL_I2C_READ_NACK

; -----------------------------------------------------------------------------
; Function: HAL_I2C_READ_REG
; Description: Reads a 8-bit value from a r22 register address.
; Inputs:  r22 - Device address
;          r23 - Register address
; Outputs: r22 - 8-bit data
;          r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_I2C_READ_REG
  PUSH  r20
    mov     r20, r22                    ; Store register address
    rcall   HAL_I2C_START_WRITE         ; Phase 0: Write DEV Address
    tst     r18
    brne    0f

    mov     r22, r23                    ; Phase 1: Write register address
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    0f

    mov     r22, r20                    ; Phase 2: Switch to Read
    rcall   HAL_I2C_START_READ
    tst     r18
    brne    0f

    rcall   HAL_I2C_READ_NACK           ; Read byte
    ldi     r18, 0                      ; Success
    rjmp    1f

  0:
    rcall   HAL_I2C_STOP
    ldi     r18, 1                      ; Error
  1:
  POP r20
ENDF HAL_I2C_READ_REG
; -----------------------------------------------------------------------------
; Function: HAL_I2C_READ_REGW
; Description: Reads a 16-bit value from a r22 register address.
; Inputs:  r22 - Device address
;          r23 - Register address
; Outputs: r23:r22 - 16-bit data (MSB:LSB)
;          r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_I2C_READ_REGW
  PUSH  r20
    mov     r20, r22                    ; Store register address

    rcall   HAL_I2C_START_WRITE         ; Phase 0: Write DEV Address
    tst     r18
    brne    0f

    mov     r22, r23                    ; Phase 1: Write register address
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    0f

    mov     r22, r20                    ; Phase 2: Switch to Read
    rcall   HAL_I2C_START_READ
    tst     r18
    brne    0f

    rcall   HAL_I2C_READ_ACK            ; Read LSB
    mov     r20, r22
    rcall   HAL_I2C_READ_NACK           ; Read MSB (last byte)
    mov     r23, r22
    mov     r22, r20
    ldi     r18, 0                      ; Success
    rjmp    1f

  0:
    rcall   HAL_I2C_STOP
    ldi     r18, 1                      ; Error
  1:
  POP r20
ENDF HAL_I2C_READ_REGW
; -----------------------------------------------------------------------------
; Function: HAL_I2C_READ_REGW_BE (big endian MSB first)
; Description: Reads a 16-bit value from a r22 register address.
; Inputs:  r22 - Device address
;          r23 - Register address
; Outputs: r23:r22 - 16-bit data (MSB:LSB)
;          r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_I2C_READ_REGW_BE
  PUSH  r20
    mov     r20, r22                    ; Store register address

    rcall   HAL_I2C_START_WRITE         ; Phase 0: Write DEV Address
    tst     r18
    brne    0f

    mov     r22, r23                    ; Phase 1: Write register address
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    0f

    mov     r22, r20                    ; Phase 2: Switch to Read
    rcall   HAL_I2C_START_READ
    tst     r18
    brne    0f

    rcall   HAL_I2C_READ_ACK            ; Read MSB
    mov     r23, r22
    rcall   HAL_I2C_READ_NACK           ; Read LSB (last byte)
    ldi     r18, 0                      ; Success
    rjmp    1f

  0:
    rcall   HAL_I2C_STOP
    ldi     r18, 1                      ; Error
  1:
  POP r20
ENDF HAL_I2C_READ_REGW_BE
; -----------------------------------------------------------------------------
; Function: HAL_I2C_READ_MANY
; Description: Read n bytes from address.
; Inputs:  r22 - Device address
;          r23 - Start address
;          r24 - n bytes (not saved)
;            X - Pointer to data array
; Outputs: r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_I2C_READ_MANY
  PUSH_MANY  r20, XL, XH
    tst     r24
    breq    1f
    mov     r20, r22                    ; Store register address
    rcall   HAL_I2C_START_WRITE         ; Phase 0: Write DEV Address
    tst     r18
    brne    0f

    mov     r22, r23                    ; Phase 1: Write register address
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    0f

    mov     r22, r20                    ; Phase 2: Switch to Read
    rcall   HAL_I2C_START_READ
    tst     r18
    brne    0f

  .L_read_byte:
    dec     r24
    breq    .L_last_byte
    rcall   HAL_I2C_READ_ACK            ; Read byte, keep reading
    tst     r18
    brne    0f
    st      X+, r22
    rjmp    .L_read_byte
  .L_last_byte:
    rcall   HAL_I2C_READ_NACK           ; Read last byte
    st      X, r22
    ldi     r18, 0                      ; Success
    rjmp    1f
  0:
    rcall   HAL_I2C_STOP
    ldi     r18, 1                      ; Error
  1:
  POP_MANY XH, XL, r20
ENDF HAL_I2C_READ_MANY

; -----------------------------------------------------------------------------
; Function: HAL_I2C_WRITE_REG
; Description: Writes a 8-bit value to an r22 register address
; Inputs:  r22 - Device address
; Inputs:  r23 - Register address
;          r24 - Byte / Data
; Outputs: r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_I2C_WRITE_REG
  PUSH r22
    rcall   HAL_I2C_START_WRITE
    tst     r18
    brne    0f

    mov     r22, r23
    rcall   HAL_I2C_WRITE               ; Send register address
    tst     r18
    brne    0f

    mov     r22, r24                    ; Data LSB
    rcall   HAL_I2C_WRITE
  0:
    rcall   HAL_I2C_STOP
  POP r22
ENDF HAL_I2C_WRITE_REG

; -----------------------------------------------------------------------------
; Function: HAL_I2C_WRITE_REGW
; Description: Writes a 16-bit value to an r22 register address
; Inputs:  r22 - Device address
; Inputs:  r23 - Register address
;          r25:r24 - 16-bit data (MSB:LSB)
; Outputs: r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_I2C_WRITE_REGW
  PUSH r22
    rcall   HAL_I2C_START_WRITE
    tst     r18
    brne    0f

    mov     r22, r23
    rcall   HAL_I2C_WRITE               ; Send register address
    tst     r18
    brne    0f

    mov     r22, r24                    ; Data LSB
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    0f

    mov     r22, r25                    ; Data MSB
    rcall   HAL_I2C_WRITE

  0:
    rcall   HAL_I2C_STOP
  POP r22
ENDF HAL_I2C_WRITE_REGW
; -----------------------------------------------------------------------------
; Function: HAL_I2C_WRITE_REGW_BE (big endian MSB first)
; Description: Writes a 16-bit value to an r22 register address
; Inputs:  r22 - Device address
; Inputs:  r23 - Register address
;          r25:r24 - 16-bit data (MSB:LSB)
; Outputs: r18 - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_I2C_WRITE_REGW_BE
  PUSH r22
    rcall   HAL_I2C_START_WRITE
    tst     r18
    brne    0f

    mov     r22, r23
    rcall   HAL_I2C_WRITE               ; Send register address
    tst     r18
    brne    0f

    mov     r22, r25                    ; Data MSB
    rcall   HAL_I2C_WRITE
    tst     r18
    brne    0f

    mov     r22, r24                    ; Data LSB
    rcall   HAL_I2C_WRITE

  0:
    rcall   HAL_I2C_STOP
  POP r22
ENDF HAL_I2C_WRITE_REGW_BE
