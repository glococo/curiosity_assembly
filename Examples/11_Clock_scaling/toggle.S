; -----------------------------------------------------------------------------
; File: Examples/11_Clock_scaling/toggle.S
; Description: Logic for status reporting and LED toggling during clock scaling.
;              Provides the `print_and_toggle` used by the Clock_scaling example.
;
; Example Usage:
;   #include "toggle.S"
;   rcall print_and_toggle                ; Call to update status and toggle LED
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
; Function: print_and_toggle
; Description: Reports the current clock divisor index and toggles the board LED.
; Inputs:      Z          - Points to USART TX buffer (for HAL_PRINT functions)
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC print_and_toggle
    PUSH_MANY r18, r19, r22, XL, XH

    rcall   HAL_PRINT_NEW_LINE                ; Send \r\n
    PRINT_STR "Current clock divisor index: "
    ; Push the numeric divisor index (0-6) converted to ASCII ('0'-'6')
    lds     r22, HAL_CLK_MAIN_DIV             ; Get current divisor index from RAM
    subi    r22, -'0'                         ; + ASCII base
    rcall   HAL_DEVICEBUFFER_PUSH             ; Push char to buffer
    rcall   HAL_PRINT_NEW_LINE                ; Send \r\n

    PRINT_STR "Configured Baud rate: "
    PRINT_STR STRINGIFY( USART_BAUD_RATE )
    rcall   HAL_PRINT_NEW_LINE                ; Send \r\n

    DEBUG_STR_LDSW _(USART,_BAUDL), "Auto-configured Baudrate clock: "
    DEBUG_STR_LDSW HAL_ONE_MS, "Clocks/mS (HAL_ONE_MS): "
    DEBUG_STR_LDSW CLKCTRL_MCLKTIMEBASE, "Clocks/μS: "

  blink:
    ldi     r18, 1<<BOARD_LED_PIN             ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r18    ; Toggle LED via hardware TGL reg

    POP_MANY XH, XL, r22, r19, r18
ENDF print_and_toggle
