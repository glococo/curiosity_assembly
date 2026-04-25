; -----------------------------------------------------------------------------
; File: Examples/09_Debug/main.S
; Description: Demonstrates debugin format
; -----------------------------------------------------------------------------

FUNC main
    call   HAL_BOARD_SETUP                       ; Basic board initialization
    _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)     ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ DEBUG: Basic debuging outputs\r\n")
    sei                                           ; Enable global interrupts

    ldi r22, 113
    _DEBUG_REG( r22, "DEBUG REG: ")
    ldi2 r22, 5113
    _DEBUG_REG2( r22, "DEBUG REG2: ")
    ldi4 r22, 2345113
    _DEBUG_REG4( r22, "DEBUG REG4: ")

    _DEBUG_LDS( SIGROW_SERNUM0, "DEBUG LDS: ")
    _DEBUG_LDS2( SIGROW_SERNUM0, "DEBUG LDS2: ")
    _DEBUG_LDS4( SIGROW_SERNUM0, "DEBUG LDS4: ")

  loop:
    jmp    loop

ENDF main
