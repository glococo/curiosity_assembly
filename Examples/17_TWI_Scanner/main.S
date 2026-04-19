; -----------------------------------------------------------------------------
; File: Examples/17_TWI_Scanner/main.S
; Description: Scans the TWI bus for devices and prints their addresses.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
; -----------------------------------------------------------------------------

FUNC main
    rcall   HAL_BOARD_SETUP                             ; Basic board initialization
    _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)           ; Initialize the USART ring buffer
    _DELAY_MS(1000)                                     ; Wait for termux to reconnect everytime the board is plugged

    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ TWI: Scans the TWI bus for devices\r\n")$ _STR_FLUSH()

    rcall   HAL_TWI_INIT
    ldi     r20, 1                                      ; Start address

  scan_loop:
    mov     r22, r20
    rcall   HAL_TWI_START_WRITE                         ; Try to address device
    brcs    not_found
    _DEBUG_REG(r20, "Found device at: ")$ _STR_FLUSH()  ; Device found!

  not_found:
    rcall   HAL_TWI_STOP                ; Even on NACK, send STOP to go back to IDLE

  next_addr:
    inc     r20
    cpi     r20, 127
    brcs    scan_loop

    _STR("Done.\r\n")$ _STR_FLUSH()

  loop:
    rjmp    loop

ENDF main
