; -----------------------------------------------------------------------------
; File: Examples/21_SPI_ADC_EtherCAT/main.S
; Description: Read LAN9252 Device via SPI.
;   - Reset chip
;   - Ready Byte Test, Device ID, HW_CFG, PMT_CTRL
;   - Enable IRQ
;   - Configure GPT and enable IRQ
;   - Transfer Address (2 bytes, big-endian)
;   - Transfer Data (Bytes)
;   - CS high
; Device ID Register Address: 0x0050
; -----------------------------------------------------------------------------
#include "../../Drivers/LAN9252/driver.S"

FUNC main
    rcall   HAL_BOARD_SETUP                           ; Basic board initialization
    rcall   HAL_SPI_MASTER
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)            ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ LAN9252: Initialize\r\n")$ _STR_FLUSH()

    ; ___Reset Device
    _STR("Reseting ")$ _STR_FLUSH()
    ldi4    r22, (RESET_CTL_ECAT_RST | RESET_CTL_DIGITAL_RST)
    _SPI_WRITE(LAN9252_RESET_CTL, 4)
  wait_for_reset:
    _STR(".")$ _STR_FLUSH()
    _SPI_READ(LAN9252_RESET_CTL, 4)                   ; Reset before config
    cpse    r22, __zero_reg__
    rjmp    wait_for_reset
    _STR(" done.")$ _STRNR()$ _STR_FLUSH()

    _STR("Byte Test : 0x")$ _SPI_READ(LAN9252_BYTE_TEST, 4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("Device ID : 0x")$ _SPI_READ(LAN9252_ID_REV,    4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("Dev HW_CFG: 0x")$ _SPI_READ(LAN9252_HW_CFG,    4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("PMT_CTRL  : 0x")$ _SPI_READ(LAN9252_PMT_CTRL,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()

    ; ___Enable LAN9252 IRQ pin
    ldi4     r22, IRQ_CFG_IRQ_TYPE | IRQ_CFG_IRQ_EN
    _SPI_WRITE(LAN9252_IRQ_CFG,  4)
    _DELAY_MS(10)
    _STR("IRQ_CNF   : 0x")$ _SPI_READ(LAN9252_IRQ_CFG,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()

    ; ___Enable LAN9252 GPT IRQ
    ldi4     r22, INT_EN_GPT_INT_EN
    _SPI_WRITE(LAN9252_INT_EN,  4)
    _STR("INT_EN    : 0x")$ _SPI_READ(LAN9252_INT_EN,   4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    _STR("INT_STS   : 0x")$ _SPI_READ(LAN9252_INT_STS,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()

    ; ___Enable LAN9252 GPT: En + 40k clks = 4000ms (100us per clock)
    ldi4     r22, (0x20000000 | 40000)
    _SPI_WRITE(LAN9252_GPT_CFG,  4)
    _STR("GPT_CFG   : 0x")$ _SPI_READ(LAN9252_GPT_CFG,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()
    sei

  loop:
    sleep
    rjmp loop

ENDF main

; -----------------------------------------------------------------------------
; ISR: PORTF_vect (PIN0 -> LAN9252 Interrupt)
; -----------------------------------------------------------------------------
ISR_START PORTF_PORT_vect, r22
  PUSH_MANY r23, r24, r25
    in    r18, VPORTF_INTFLAGS
    _STR("INT_FLG: 0x")$ _STR_HEX(r18)$ _STR_FLUSH()
    _STR(",  INT_STS: 0x")$ _SPI_READ(LAN9252_INT_STS,  4)$ _STR_HEX32()$ _STRNR()$ _STR_FLUSH()

    ldi4     r18, INT_STS_GPT_INT                     ; Reset GPT INT FLAG
    _SPI_WRITE(LAN9252_INT_STS,  4)

    ldi4     r22, (0x20000000 | 40000)                ; Need to rewrite the counter every time it wraps
    _SPI_WRITE(LAN9252_GPT_CFG,  4)

    _PIN_TGL(BOARD_LED_PORT, BOARD_LED_PIN)           ; Toggle LED pin
    _PIN_FLG(BOARD_BUTTON_PORT, BOARD_BUTTON_PIN)     ; Clear the button int flag
    _PIN_FLG(BOARD_BUTTON_PORT, PIN0_bp)              ; Clear the LAN9252 pin int flag
  POP_MANY r25, r24, r23
ISR_END PORTF_PORT_vect, r22
