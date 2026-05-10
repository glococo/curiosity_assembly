; File: Hal/HAL_TWI.S
; Description: TWI Master-only helper library for AVR-Dx/Ex families.
;              Provides routines for initialization, baudrate calculation,
;              and basic TWI communication (Start, Stop, Write, Read).
;

#ifndef TWI_BAUD_RATE_KHZ
  #define TWI_BAUD_RATE_KHZ   50
#endif

#define _TWI_CONFIG()                 HAL_TWI_CONFIG
#define _TWI0_SET()                   HAL_TWI_SET TWI0_CTRLA
#define _TWI1_SET()                   HAL_TWI_SET TWI1_CTRLA
#define _TWI_MASTER(khz)              HAL_TWI_MASTER TWI0_CTRLA, khz
#define _TWI0_MASTER(khz)             HAL_TWI_MASTER TWI0_CTRLA, khz
#define _TWI1_MASTER(khz)             HAL_TWI_MASTER TWI1_CTRLA, khz

#define _TWI_START(addr,read)         HAL_TWI_START addr, read
#define _TWI_STOP()                   HAL_TWI_STOP

#define _TWI_READ(addr,reg,size)      HAL_TWI_READ_PROTO addr, reg, size
#define _TWI_READ1(addr,reg)          HAL_TWI_READ_PROTO addr, reg, 1
#define _TWI_READ2(addr,reg)          HAL_TWI_READ_PROTO addr, reg, 2
#define _TWI_READ4(addr,reg)          HAL_TWI_READ_PROTO addr, reg, 4
#define _TWI_READ2BE(addr,reg)        HAL_TWI_READ_BE_PROTO addr, reg, 2
#define _TWI_READ4BE(addr,reg)        HAL_TWI_READ_BE_PROTO addr, reg, 4

#define _TWI_WRITE(addr,reg,val,size) HAL_TWI_WRITE_PROTO addr, reg, val, size
#define _TWI_WRITE1(addr,reg,val)     HAL_TWI_WRITE_PROTO addr, reg, val, 1
#define _TWI_WRITE2(addr,reg,val)     HAL_TWI_WRITE_PROTO addr, reg, val, 2
#define _TWI_WRITE4(addr,reg,val)     HAL_TWI_WRITE_PROTO addr, reg, val, 4
#define _TWI_WRITE2BE(addr,reg,val)   HAL_TWI_WRITE_BE_PROTO addr, reg, val, 2
#define _TWI_WRITE4BE(addr,reg,val)   HAL_TWI_WRITE_BE_PROTO addr, reg, val, 4

.macro HAL_TWI_CONFIG
  #if (defined(TWI_CONFIGURED) || defined(TWI0_CONFIGURED)) && (defined(TWI_ALT) || defined(TWI0_ALT))
      _PORTMUX( TWI0, TWI_ALT, PORTMUX_TWIROUTEA )
  #endif
  #if defined(TWI1_CONFIGURED) && defined(TWI1_ALT)
      _PORTMUX( TWI1, TWI1_ALT, PORTMUX_TWIROUTEA )
  #endif
.endm

; Function: HAL_TWI_BAUDRATE
; Description: Recomputes the TWI MBAUD register based on BOARD_CLOCK_MAIN,
;              current CPU prescaler, and TWI_BAUD_RATE.
;              Formula: MBAUD = fCLK_PER / (2 * fSCL) - 5
; Inputs:  r17:r16 - 2 * TWI_BAUD_RATE
;          YH:YL - TWI Base Address
; Outputs: None (Updates TWIx_MBAUD)
FUNC HAL_TWI_BAUDRATE
  PUSH_MANY r18, r19, r22, r23
    ; Load dividend: fCLK_PER (in KHz)
    ; HAL_CLK_MAIN_KHZ is in kHz
    lds     r18, HAL_CLK_MAIN_DIV       ; Load divisor index
    lds2    r22, HAL_CLK_MAIN_KHZ       ; load lower 2 bytes of HAL_CLK_MAIN_KHZ(max clock 65535 khz)
    call    MATH_LSR_16                 ; r23:r22 = r23:r22 >> r18

    movw    r18, r16                    ; Load 2 * baud_rate
    call    MATH_UDIV_16                ; r23:r22 = fCLK_PER / (2 * TWI_BAUD_RATE)

    subi    r22, 5                      ; Subtract 5
    sbc     r23, __zero_reg__
    brcc    1f                          ; Clamp to 0 if result was < 5
    clr     r22
  1:
    std     Y+6, r22                    ; TWIx_MBAUD is offset 6
  POP_MANY r23, r22, r19, r18
ENDF HAL_TWI_BAUDRATE

.macro HAL_TWI_SET dev
    ldi2    YL, \dev
.endm
.macro HAL_TWI_MASTER dev, khz=TWI_BAUD_RATE_KHZ
  PUSH_MANY r16, r17
    ldi2    YL, \dev
    ldi2    r16, (2 * \khz)
    call    HAL_TWI_BAUDRATE            ; Initialize baudrate
    ldi     r16, TWI_ENABLE_bm          ; Enable TWI Master
    std     Y+3, r16                    ; TWIx_MCTRLA is offset 3
    ldi     r16, TWI_BUSSTATE_IDLE_gc   ; Force Idle state
    std     Y+5, r16                    ; TWIx_MSTATUS is offset 5
  POP_MANY r17, r16
.endm

.macro HAL_TWI_START addr, read=0
    ldi     r20, (\addr << 1) | \read
    call    HAL_TWI_MSTART
.endm

; Function: HAL_TWI_MSTART
; Description: Sends a Master START condition followed by Address + R/W bit.
; Inputs:  r20 - (Address << 1) | R/W
;          YH:YL - TWI Base Address
; Outputs:  Cf - 0: Success, 1: Error (NACK or Bus Error)
FUNC HAL_TWI_MSTART
    clc
    std     Y+7, r20                    ; Writing to TWIx_MADDR (offset 7) sends START + Address
  1:
    ldd     r17, Y+5                    ; Load TWIx_MSTATUS (offset 5)
    sbrc    r17, TWI_WIF_bp             ; Wait for Write Interrupt Flag (Address sent)
    jmp     2f
    sbrc    r17, TWI_RIF_bp             ; Or Read Interrupt Flag
    jmp     2f
    jmp     1b
  2:
    ; Check for errors: RXACK (bit 4), BUSERR (bit 2), ARBLOST (bit 3)
    andi    r17, (1<<TWI_RXACK_bp) | (1<<TWI_BUSERR_bp) | (1<<TWI_ARBLOST_bp)
    breq    3f                          ; If no error bits set, exit success
    sec                                 ; Set Carry: if error flag
  3:
ENDF HAL_TWI_MSTART

.macro HAL_TWI_STOP
    ldi     r17, TWI_MCMD_STOP_gc
    std     Y+4, r17                    ; TWIx_MCTRLB is offset 4
.endm

; Function: HAL_TWI_MWRITE
; Description: Writes a byte to the TWI bus.
; Inputs:  r21 - Data byte
;          YH:YL - TWI Base Address
; Outputs:  Cf - 0: Success, 1: Error
FUNC HAL_TWI_MWRITE
    std     Y+8, r21                    ; TWIx_MDATA is offset 8
  1:
    ldd     r17, Y+5                    ; TWIx_MSTATUS
    sbrs    r17, TWI_WIF_bp             ; Wait for WIF
    jmp     1b

    ; Check for NACK (RXACK bit) or Errors
    andi    r17, (1<<TWI_RXACK_bp) | (1<<TWI_BUSERR_bp) | (1<<TWI_ARBLOST_bp)
    breq    2f
    sec
  2:
ENDF HAL_TWI_MWRITE

; Function: HAL_TWI_READ_ACK
; Description: Reads a byte and prepares to send ACK.
; Inputs:  YH:YL - TWI Base Address
; Outputs: r0 - Data byte
FUNC HAL_TWI_READ_ACK
  1:
    ldd     r17, Y+5                    ; TWIx_MSTATUS
    sbrs    r17, TWI_RIF_bp             ; Wait for RIF
    jmp     1b

    ldd     r0, Y+8                     ; TWIx_MDATA - Read data (clears RIF)
    ldi     r17, TWI_MCMD_RECVTRANS_gc  ; Ack and prepare for next byte
    std     Y+4, r17                    ; TWIx_MCTRLB
ENDF HAL_TWI_READ_ACK

; Function: HAL_TWI_READ_NACK
; Description: Reads a byte and sends NACK + STOP.
; Inputs:  YH:YL - TWI Base Address
; Outputs: r0 - Data byte
FUNC HAL_TWI_READ_NACK
  1:
    ldd     r17, Y+5                    ; TWIx_MSTATUS
    sbrs    r17, TWI_RIF_bp             ; Wait for RIF
    jmp     1b

    ldd     r0,  Y+8                    ; TWIx_MDATA - Read data (clears RIF)
    ldi     r17, TWI_ACKACT_NACK_gc | TWI_MCMD_STOP_gc ; NACK and STOP
    std     Y+4, r17                    ; TWIx_MCTRLB
ENDF HAL_TWI_READ_NACK

.macro HAL_TWI_READ_PROTO addr, reg, size=1
    ldi       r16, \size
    ldi       r20, (\addr << 1)
    ldi       r21, \reg
    call      HAL_TWI_READ
.endm

.macro HAL_TWI_READ_BE_PROTO addr, reg, size=1
    ldi       r16, \size
    ldi       r20, (\addr << 1)
    ldi       r21, \reg
    call      HAL_TWI_READ_BE
.endm

; -----------------------------------------------------------------------------
; Function: HAL_TWI_READ
; Description: Reads a 8/16/32-bit value from client register address.
; Inputs:      r16 - Byte length
;              r20 - Device address
;              r21 - Register address
;              YH:YL - TWI Base Address
; Outputs: r25:r22 - 8/16/32-bit data (LSB:MSB)
;               Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_TWI_READ
    call    HAL_TWI_MSTART              ; Phase 0: Write DEV Address
    brcs    3f
    call    HAL_TWI_MWRITE              ; Phase 1: Write register address
    brcs    3f
    ori     r20, 0x01                   ; Phase 2: Switch to Read
    call    HAL_TWI_MSTART              ; Write DEV Address + 0x01(read)
    brcs    3f
    andi    r20, 0xFE                   ; Restore r20 dev address

    dec     r16
    brne    1f                          ; 1 byte read ?
    call    HAL_TWI_READ_NACK           ; Read last byte
    mov     r22, r0
    jmp     4f                          ; exit
  1:
    call    HAL_TWI_READ_ACK            ; Read next byte
    mov     r22, r0

    dec     r16
    brne    2f                          ; 2 bytes read ?
    call    HAL_TWI_READ_NACK           ; Read last byte
    mov     r23, r0
    jmp     4f                          ; exit
  2:
    call    HAL_TWI_READ_ACK            ; Read next byte
    mov     r23, r0
    call    HAL_TWI_READ_ACK            ; Read next byte
    mov     r24, r0
    call    HAL_TWI_READ_NACK           ; Read last byte
    mov     r25, r0
    jmp     4f
  3:
    _TWI_STOP()
    sec
  4:
ENDF HAL_TWI_READ

.macro HAL_TWI_WRITE_PROTO addr, reg, value, size=1
    ldi       r16, \size
    ldi       r20, (\addr << 1)
    ldi       r21, \reg
    .if \size == 1
      ldi     r22, \value
    .elif \size == 2
      ldi2    r22, \value
    .elif \size == 4
      ldi4    r22, \value
    .endif
    call      HAL_TWI_WRITE
.endm

.macro HAL_TWI_WRITE_BE_PROTO addr, reg, value, size=1
    ldi       r16, \size
    ldi       r20, (\addr << 1)
    ldi       r21, \reg
    .if \size == 1
      ldi     r22, \value
    .elif \size == 2
      ldi2    r22, \value
    .elif \size == 4
      ldi4    r22, \value
    .endif
    call      HAL_TWI_WRITE_BE
.endm

; -----------------------------------------------------------------------------
; Function: HAL_TWI_WRITE
; Description: Master-Writes a 8/16/32-bit value to an Client register address
; Inputs:     r16 - Byte length
;             r20 - Device address
;             r21 - Register address
;         r25:r22 - Byte/s (1/2/4 bytes)
;         YH:YL   - TWI Base Address
; Outputs:  Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_TWI_WRITE
    call    HAL_TWI_MSTART              ; Master locate r20 dev address
    brcs    0f
    call    HAL_TWI_MWRITE              ; Send client r21 target address
    brcs    0f

    mov     r21, r22                    ; Data Byte 1
    call    HAL_TWI_MWRITE
    brcs    0f
    dec     r16
    breq    0f

    mov     r21, r23                    ; Data Byte 2
    call    HAL_TWI_MWRITE
    brcs    0f
    dec     r16
    breq    0f

    mov     r21, r24                    ; Data Byte 3
    call    HAL_TWI_MWRITE
    brcs    0f
    dec     r16
    breq    0f

    mov     r21, r25                    ; Data Byte 4
    call    HAL_TWI_MWRITE
  0:
    _TWI_STOP()
ENDF HAL_TWI_WRITE

; -----------------------------------------------------------------------------
; Function: HAL_TWI_WRITE_BE
; Description: Master-Writes a BigEndian 8/16/32-bit value to an Client register address
; Inputs:     r16 - Byte length
;             r20 - Device address
;             r21 - Register address
;         r25:r22 - Byte/s (MSB first)
;         YH:YL   - TWI Base Address
; Outputs:  Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_TWI_WRITE_BE
    call    HAL_TWI_MSTART
    brcs    0f
    call    HAL_TWI_MWRITE              ; Register address
    brcs    0f

    cpi     r16, 1
    brne    1f
    mov     r21, r22
    call    HAL_TWI_MWRITE
    jmp     0f
  1:
    cpi     r16, 2
    brne    2f
    mov     r21, r23                    ; MSB
    call    HAL_TWI_MWRITE
    brcs    0f
    mov     r21, r22                    ; LSB
    call    HAL_TWI_MWRITE
    jmp     0f
  2:
    ; 4 bytes (BE: r25, r24, r23, r22)
    mov     r21, r25
    call    HAL_TWI_MWRITE
    brcs    0f
    mov     r21, r24
    call    HAL_TWI_MWRITE
    brcs    0f
    mov     r21, r23
    call    HAL_TWI_MWRITE
    brcs    0f
    mov     r21, r22
    call    HAL_TWI_MWRITE
  0:
    _TWI_STOP()
ENDF HAL_TWI_WRITE_BE

; -----------------------------------------------------------------------------
; Function: HAL_TWI_READ_BE
; Description: Reads a BigEndian 8/16/32-bit value from client register address.
; Inputs:      r16 - Byte length
;              r20 - Device address
;              r21 - Register address
;              YH:YL - TWI Base Address
; Outputs: r25:r22 - 8/16/32-bit data (MSB:LSB)
;               Cf - 0: Success, 1: Error
; -----------------------------------------------------------------------------
FUNC HAL_TWI_READ_BE
    call    HAL_TWI_MSTART              ; Phase 0: Write DEV Address
    brcs    3f
    call    HAL_TWI_MWRITE              ; Phase 1: Write register address
    brcs    3f
    ori     r20, 0x01                   ; Phase 2: Switch to Read
    call    HAL_TWI_MSTART              ; Write DEV Address + 0x01(read)
    brcs    3f
    andi    r20, 0xFE                   ; Restore r20 dev address

    dec     r16
    brne    1f                          ; 1 byte read ?
    call    HAL_TWI_READ_NACK           ; Read last byte
    mov     r22, r0
    jmp     4f
  1:
    dec     r16
    brne    2f                          ; 2 bytes read ?
    call    HAL_TWI_READ_ACK            ; Read MSB
    mov     r23, r0
    call    HAL_TWI_READ_NACK           ; Read LSB
    mov     r22, r0
    jmp     4f
  2:
    ; 4 bytes read (BE: r25=B0, r24=B1, r23=B2, r22=B3)
    call    HAL_TWI_READ_ACK
    mov     r25, r0
    call    HAL_TWI_READ_ACK
    mov     r24, r0
    call    HAL_TWI_READ_ACK
    mov     r23, r0
    call    HAL_TWI_READ_NACK
    mov     r22, r0
    jmp     4f

  3:
    _TWI_STOP()
    sec
  4:
ENDF HAL_TWI_READ_BE
