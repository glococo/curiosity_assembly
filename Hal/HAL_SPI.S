; File: Hal/HAL_SPI.S
; Description: SPI Master-only helper library for AVR-Dx/Ex families.
;              Provides routines for initialization and basic SPI communication.
;

#define _SPI_READ(  address, bytes)     _SPI_READ_ADDRESS16  address, bytes
#define _SPI_WRITE( address, bytes)     _SPI_WRITE_ADDRESS16 address, bytes
#define _SPI_CONFIG()                   HAL_SPI_CONFIG

.macro HAL_SPI_CONFIG
  #ifdef SPI_CONFIGURED
    ldi     r22, ( 1<<SPI_MOSI | 1<<SPI_SCK | 1<<SPI_SS ) ; MOSI, SCK, SS
    out     _(_(V,SPI_PORT),_DIR), r22
    _PIN_OUT_SET( SPI_PORT, SPI_SS )                      ; SS High
   #ifdef SPI_ALT
      _PORTMUX( SPI, SPI_ALT, PORTMUX_SPIROUTEA )
   #endif
   #ifdef SPI_IRQ_PORT
    ldi     r22, (PORT_PULLUPEN_bm | PORT_ISC_FALLING_gc)
    sts     _PIN_CTRL(SPI_IRQ_PORT,SPI_IRQ_PIN), r22      ; SPI_IRQ_PORT PIN as SPI slave IRQ
   #endif
  #endif
.endm

; Function: HAL_SPI_MASTER
; Description: Initializes SPI0 as Master (Mode 0, MSB first).
FUNC HAL_SPI_MASTER
  PUSH r18
    ; SPI Master Mode, Enable SPI
    ; SPI_MASTER_bm | SPI_ENABLE_bm
    ldi     r18, ( SPI_PRESC_DIV4_gc | SPI_CLK2X_bm | SPI_MASTER_bm | SPI_ENABLE_bm )
    sts     SPI0_CTRLA, r18
;    ldi     r18, SPI_BUFEN_bm
;    sts     SPI0_CTRLB, r18
  POP r18
ENDF HAL_SPI_MASTER

; Function: HAL_SPI_TX_RX
; Description: Transfers a byte via SPI.
; Inputs:  r16 - Data to send
; Outputs: r16 - Received data
FUNC HAL_SPI_TX_RX
    sts     SPI0_DATA, r16
  1:
    lds     r16, SPI0_INTFLAGS
    sbrs    r16, SPI_IF_bp
    rjmp    1b
    lds     r16, SPI0_DATA
ENDF HAL_SPI_TX_RX

.macro _SPI_WRITE_ADDRESS16 address, bytes
  PUSH r16
    ldi     r17, \bytes
    ldi2    r18, \address
    rcall   HAL_SPI_WRITE_16ADDR_32DATA
  POP r16
.endm
; Function: HAL_SPI_WRITE_16ADDR_32DATA
; Description: Write bytes to 16bit SPI address
; Inputs:       r17 - bytes
;           r19:r18 - Address
; Outputs:  r25:r22 - Data
FUNC HAL_SPI_WRITE_16ADDR_32DATA
    _PIN_OUT_CLR(SPI_PORT, SPI_SS)          ; SS Low
    ldi     r16, 0x02                       ; CMD Write
    rcall   HAL_SPI_TX_RX
    mov     r16, r19                        ; Address MSB
    rcall   HAL_SPI_TX_RX
    mov     r16, r18                        ; Address LSB
    rcall   HAL_SPI_TX_RX
    mov     r16, r22                        ; Byte 0 LSB
    rcall   HAL_SPI_TX_RX
    dec     r17
    breq    0f
    mov     r16, r23                        ; Byte 1
    rcall   HAL_SPI_TX_RX
    dec     r17
    breq    0f
    mov     r16, r24                        ; Byte 2
    rcall   HAL_SPI_TX_RX
    mov     r16, r25                        ; Byte 3 MSB
    rcall   HAL_SPI_TX_RX
  0:
    _PIN_OUT_SET(SPI_PORT, SPI_SS)          ; SS High
ENDF HAL_SPI_WRITE_16ADDR_32DATA

.macro _SPI_READ_ADDRESS16 address, bytes=1
  PUSH r17
    ldi     r17, \bytes
    ldi2    r22, \address
    rcall   HAL_SPI_READ_16ADDR_32DATA
  POP r17
.endm
; Function: HAL_SPI_READ_16ADDR_32DATA
; Description: Read bytes from 16bit SPI address
; Inputs:       r17 - bytes
;           r23:r22 - Address
; Outputs:  r25:r22 - Received data
FUNC HAL_SPI_READ_16ADDR_32DATA
    _PIN_OUT_CLR(SPI_PORT, SPI_SS)     ; SS Low
    ldi     r16, 0x03
    rcall   HAL_SPI_TX_RX
    mov     r16, r23                        ; SPI address are usually MSB sent
    rcall   HAL_SPI_TX_RX
    mov     r16, r22
    rcall   HAL_SPI_TX_RX
    rcall   HAL_SPI_TX_RX
    mov     r22, r16
    dec     r17
    breq    0f
    rcall   HAL_SPI_TX_RX
    mov     r23, r16
    dec     r17
    breq    0f
    rcall   HAL_SPI_TX_RX
    mov     r24, r16
    rcall   HAL_SPI_TX_RX
    mov     r25, r16
  0:
    _PIN_OUT_SET(SPI_PORT, SPI_SS)     ; SS High
ENDF HAL_SPI_READ_16ADDR_32DATA

.macro _SPI_READ_ADDRESS8 address, bytes=1
  PUSH r17
    ldi     r17, \bytes
    ldi2    r22, \address
    rcall   HAL_SPI_READ_8ADDR_32DATA
  POP r17
.endm
; Function: HAL_SPI_READ_8ADDR_32DATA
; Description: Read bytes from 8-bit SPI address
; Inputs:       r17 - bytes
;               r22 - Address
; Outputs:  r25:r22 - Received data
FUNC HAL_SPI_READ_8ADDR_32DATA
    _PIN_OUT_CLR(SPI_PORT, SPI_SS)     ; SS Low
    ldi     r16, 0x03
    rcall   HAL_SPI_TX_RX
    mov     r16, r22
    rcall   HAL_SPI_TX_RX
    rcall   HAL_SPI_TX_RX
    mov     r22, r16
    dec     r17
    breq    0f
    rcall   HAL_SPI_TX_RX
    mov     r23, r16
    dec     r17
    breq    0f
    rcall   HAL_SPI_TX_RX
    mov     r24, r16
    rcall   HAL_SPI_TX_RX
    mov     r25, r16
  0:
    _PIN_OUT_SET(SPI_PORT, SPI_SS)     ; SS High
ENDF HAL_SPI_READ_8ADDR_32DATA
