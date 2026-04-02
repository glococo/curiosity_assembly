; -----------------------------------------------------------------------------
; File: Examples/08_Device_ID/main.S
; Description: Print Device ID signature rows.
;              - Reads values from SIGROW.
;              - Print over USART.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: main
; Description: Main application entry point.
; -----------------------------------------------------------------------------
; Define a 256-byte Dev-Ring-Buffer for USART (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 256, USART_ADDR

FUNC main
    rcall   HAL_BOARD_SETUP             ; Basic board initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER  ; Initialize USART TX buffer

    ldi2    ZL, TX_DEVBUFFER            ; Set Z to point to the device buffer for all PRINT functions
    PRINT_STR "__ CURIOSITY ASSEMBLY __ \r\n"
    PRINT_STR "__ SIGROW reading example\r\n"
    rcall   HAL_PRINT_NEW_LINE

    PRINT_STR "Device ID:"
    lds2    r22, SIGROW_DEVICEID0
    lds     r24, SIGROW_DEVICEID2
    ldi     r25, 0
    rcall   HAL_PRINT_UINT32_REG                  ; Print 32-bit result
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

    DEBUG_STR_LDSW SIGROW_TEMPSENSE0, "Temperature Calibration 0: "
    DEBUG_STR_LDSW SIGROW_TEMPSENSE1, "Temperature Calibration 1: "

    PRINT_STR "Sigrow DEVICE ID:"
    ldi2    XL, SIGROW_SERNUM0
    ldi     r21, 0
  0:
    mov     r22, r21
    ld      r22, X+
    rcall   HAL_PRINT_HEX_REG                     ; Print 8-bit Hex result
    PRINT_STR " "
    cpi     r21, 15
    brcc    1f
    inc     r21
    rjmp    0b
  1:
    rcall   HAL_PRINT_NEW_LINE
    rcall   HAL_USART_FLUSH_DEVICEBUFFER

  loop:
    rjmp    loop

ENDF main
