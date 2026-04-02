; -----------------------------------------------------------------------------
; File: Examples/17_I2C_Scanner/main.S
; Description: Scans the I2C bus for devices and prints their addresses.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
; -----------------------------------------------------------------------------

; Define a 256-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 256, USART_ADDR

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point.
; -----------------------------------------------------------------------------
FUNC main
    rcall   HAL_BOARD_SETUP                         ; Basic board initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER              ; Initialize USART TX buffer
    ldi2    ZL, TX_DEVBUFFER                        ; Set Z to point to the device buffer for all PRINT functions
    HAL_DELAY_MS 1000                               ; Wait for termux to reconnect everytime the board is plugged
    PRINT_STR "__ CURIOSITY ASSEMBLY __\r\n"
    PRINT_STR "__ TWI/I2C: Scanning I2C bus...\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER
    rcall   HAL_I2C_INIT

    ldi     r20, 1                      ; Start address
  scan_loop:
    mov     r22, r20
    rcall   HAL_I2C_START_WRITE         ; Try to address device
    tst     r18
    brne    not_found

    ; Device found!
    DEBUG_STR_REG r20, "Found device at: "
    rcall   HAL_I2C_STOP                ; Send STOP if device responded
    rjmp    next_addr

    not_found:
    rcall   HAL_I2C_STOP                ; Even on NACK, send STOP to go back to IDLE
    next_addr:

    inc     r20
    cpi     r20, 127
    brcs    scan_loop

    PRINT_STR "Done.\r\n"
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

  loop:
    rjmp    loop

ENDF main
