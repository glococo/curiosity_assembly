; -----------------------------------------------------------------------------
; File: Examples/28_RS485_heartbeat/main.S
; Description: Send a message over RS485.
;              - RS485 over USART.
;              - Board config -> #define USART_RS485_MODE  1
;              - Nothing change in main.S
; -----------------------------------------------------------------------------

FUNC main
    _BOARD_SETUP()                                    ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)            ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ USART - RS485 - A Message from a friend __ \r\n")
    _STR_FLUSH()

  loop:
    _STR("We are the champions my friend (Freddy)\n\r")
    _STR_FLUSH(4000)                                  ; UART Flush + 4" delay
    jmp     loop                                      ; Repeat indefinitely

ENDF main
