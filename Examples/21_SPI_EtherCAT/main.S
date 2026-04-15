; -----------------------------------------------------------------------------
; File: Examples/21_SPI_ADC_EtherCAT/main.S
; Description: Read LAN9252 Device via SPI.
;   - Reset chip
;   - Ready Byte Test, Device ID, HW_CFG, PMT_CTRL
;   - Enable IRQ
;   - Configure GPT and enable IRQ
;   - LAN9252 IRQ connected to PIN0 of PORTF on AVR16EB32
;   - Transfer Data (Bytes)
;   - CS high
; Device ID Register Address: 0x0050
; -----------------------------------------------------------------------------
#include "../../Drivers/LAN9252/driver.S"

#define _ESC_WRITE(addr,value,len)    ESC_WRITE addr, value, len
.macro ESC_WRITE addr, value, len
    ldi4    r22, \value
    _SPI_WRITE(LAN9252_ECAT_CSR_DATA, 4)
    ldi4    r22, ( \len << 16 ) | \addr
    _SPI_WRITE(LAN9252_ECAT_CSR_CMD, 4)
.endm

FUNC main
    rcall   HAL_BOARD_SETUP                           ; Basic board initialization
    rcall   HAL_SPI_MASTER
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)            ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ LAN9252: Initialize\r\n")$ _STR_FLUSH()

    _STR("Reseting ")$ _STR_FLUSH()
    ldi4    r22, (RESET_CTL_ECAT_RST | RESET_CTL_DIGITAL_RST)
    _SPI_WRITE(LAN9252_RESET_CTL, 4)                  ; Send Reset command
  wait_for_reset:
    _STR(".")$ _STR_FLUSH()
    _SPI_READ(LAN9252_RESET_CTL, 4)                   ; Wait for Reset before continue
    cpse    r22, __zero_reg__
    rjmp    wait_for_reset
    _STR(" done.")$ _STRNR()$ _STR_FLUSH()

    _STR("Byte Test : 0x")$ _SPI_READ(LAN9252_BYTE_TEST, 4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("Device ID : 0x")$ _SPI_READ(LAN9252_ID_REV,    4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("Dev HW_CFG: 0x")$ _SPI_READ(LAN9252_HW_CFG,    4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("PMT_CTRL  : 0x")$ _SPI_READ(LAN9252_PMT_CTRL,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()

    ldi4     r22, IRQ_CFG_IRQ_TYPE | IRQ_CFG_IRQ_EN
    _SPI_WRITE(LAN9252_IRQ_CFG, 4)                   ; ___Enable LAN9252 IRQ pin
    _DELAY_MS(10)
    _STR("IRQ_CNF   : 0x")$ _SPI_READ(LAN9252_IRQ_CFG,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()

    ldi4     r22, INT_EN_GPT_INT_EN | INT_EN_ECAT_INT_EN
    _SPI_WRITE(LAN9252_INT_EN, 4)                    ; ___Enable LAN9252 GPT IRQ
    _STR("INT_EN    : 0x")$ _SPI_READ(LAN9252_INT_EN,   4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("INT_STS   : 0x")$ _SPI_READ(LAN9252_INT_STS,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()

    ; ___Enable LAN9252 GPT: En + 40k clks = 4000ms (100us per clock)
    ldi4     r22, (0x20000000 | 40000)
    _SPI_WRITE(LAN9252_GPT_CFG, 4)
    _STR("GPT_CFG   : 0x")$ _SPI_READ(LAN9252_GPT_CFG,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    sei

    ; ___Enable LAN9252 ESC SM0 event interrupt
    _ESC_WRITE(ESC_AL_EVENT_MASK, 0x00000100, 4)


  loop:
    _SLEEP()
    rjmp loop

ENDF main

; -----------------------------------------------------------------------------
; ISR: PORTF_vect (PIN0 -> LAN9252 Interrupt)
; -----------------------------------------------------------------------------
ISR_START PORTF_PORT_vect, r22
  PUSH_MANY r18, r19, r20, r21, r23, r24, r25
    in      r22, VPORTF_INTFLAGS
    _STR("INT_FLG: 0x")$ _STR_HEX(r18)$ _STRNR()$ _STR_FLUSH()
    sbrc    r22, 0
    rjmp    ISR_LAN9252
    sbrc    r22, 6
    rjmp    ISR_BUTTON
    _STR("_______ ISR WEIRD")$ _STRNR()$ _STR_FLUSH()
    rjmp    exit

  ISR_BUTTON:
    _STR("_ ISR_BUTTON pressed")$ _STRNR()$ _STR_FLUSH()
    _PIN_FLG(BOARD_BUTTON_PORT, BOARD_BUTTON_PIN)     ; Clear the button int flag
    rjmp    exit

  ISR_LAN9252:
    _STR("_ ISR_LAN9252: INT_STS: 0x")$ _SPI_READ(LAN9252_INT_STS, 4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _PIN_FLG(BOARD_BUTTON_PORT, PIN0_bp)              ; Clear the LAN9252 pin int flag
    mov4    r18, r22
  ISR_LAN9252_SM0:
    sbrs    r18, 0
    rjmp    ISR_LAN9252_GPT
    _STR("___ ISR_LAN9252_SM0, AL_EV: 0x")$ _SPI_READ(ESC_AL_EVENT_REQUEST, 4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    ldi4    r22, INT_STS_ECAT_INT | INT_STS_SW_INT                     ; Reset ECAT INT FLAG
    _SPI_WRITE(LAN9252_INT_STS,  4)
    ldi4    r22, (0x20000000 | 40000)                ; Need to rewrite the counter every time it wraps
    _SPI_WRITE(LAN9252_GPT_CFG,  4)
  ISR_LAN9252_GPT:
    sbrs    r20, 3
    rjmp    exit
    _STR("___ ISR_LAN9252_GPT")$ _STRNR()$ _STR_FLUSH()
    ldi4    r22, INT_STS_GPT_INT                     ; Reset GPT INT FLAG
    _SPI_WRITE(LAN9252_INT_STS,  4)
    ldi4    r22, (0x20000000 | 40000)                ; Need to rewrite the counter every time it wraps
    _SPI_WRITE(LAN9252_GPT_CFG,  4)
  exit:
    _PIN_TGL(BOARD_LED_PORT, BOARD_LED_PIN)           ; Toggle LED pin
  POP_MANY r25, r24, r23, r21, r20, r19, r18
ISR_END PORTF_PORT_vect, r22
