; -----------------------------------------------------------------------------
; File: Examples/17_TWI_Scanner/main.S
; Description: Scans the TWI bus for devices and prints their addresses.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
; -----------------------------------------------------------------------------

FUNC main
    _BOARD_SETUP()                                      ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)              ; Initialize the USART ring buffer
    _DELAY_MS(1000)                                     ; Wait for terminal to reconnect everytime the board is plugged in

    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ TWI: Scans the TWI bus for devices\r\n")$ _STR_FLUSH()

    _TWI_MASTER()                                       ; Initialize TWI with default baudrate
    ldi     r18, 1                                      ; Start address

  scan_loop:
    mov     r20, r18
    clc
    lsl     r20
    call    HAL_TWI_MSTART                              ; Try to address device
    brcs    not_found
    _DEBUG_REG(r18, "Found device at: ")$ _STR_FLUSH()  ; Device found!

  not_found:
    _TWI_STOP()                                         ; Even on NACK, send STOP to go back to IDLE

  next_addr:
    inc     r18
    cpi     r18, 127
    brcs    scan_loop

    _STR("Done.\r\n")$ _STR_FLUSH()

  loop:
    jmp    loop

ENDF main
