; -----------------------------------------------------------------------------
; File: Examples/08_Device_ID/main.S
; Description: Print Device ID signature rows.
;              - Reads values from SIGROW.
;              - Print over USART.
; -----------------------------------------------------------------------------

FUNC main
    rcall   HAL_BOARD_SETUP                     ; Basic board initialization
    _DEVBUFFER(RX_DEVBUFFER, 128, USART_ADDR)   ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")
    _STR("__ SIGROW reading example\r\n")$ _STR_FLUSH()

    lds2    r22, SIGROW_DEVICEID0
    lds     r24, SIGROW_DEVICEID2
    clr     r25
    _STR("Device ID: ")$ _STR_REG_U32(r22)$ _STR("\r\n")$ _STR_FLUSH()

    lds     r22, SIGROW_TEMPSENSE0              ; Load byte from address
    _STR("Temperature Calibration 0: ")$ _STR_REG_U8()$ _STR(" 0x")$ _STR_REG_HEX()$ _STR("\r\n")
    lds     r22, SIGROW_TEMPSENSE1              ; Load byte from address
    _STR("Temperature Calibration 1: ")$ _STR_REG_U8()$ _STR(" 0x")$ _STR_REG_HEX()$ _STR("\r\n")

    _STR("Sigrow Serial Nº:")$ _STR_FLUSH()
    ldi2    XL, SIGROW_SERNUM0
    ldi     r21, 0
  0:
    mov     r22, r21
    ld      r22, X+
    _STR_REG_HEX(r22)$ _STR(" ")                     ; Print 8-bit Hex result
    cpi     r21, 15
    brcc    1f
    inc     r21
    rjmp    0b
  1:
    _STR("\r\n")$ _STR_FLUSH()

  loop:
    rjmp    loop

ENDF main
