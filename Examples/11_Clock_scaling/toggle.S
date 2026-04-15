; -----------------------------------------------------------------------------
; File: Examples/11_Clock_scaling/toggle.S
; Description: Logic for status reporting and LED toggling during clock scaling.
;              Provides the `print_and_toggle` used by the Clock_scaling example.
; -----------------------------------------------------------------------------

FUNC print_and_toggle
  PUSH_MANY r22

    ; Push the numeric divisor index (0-6) converted to ASCII ('0'-'6')
    lds     r22, HAL_CLK_MAIN_DIV             ; Get current divisor index from RAM
    subi    r22, -'0'                         ; + ASCII base
    _STR("\n\rCurrent clock divisor index: ")$ _STRC(r22)$ _STRNR()$ _STR_FLUSH()
    _STR(_("Configured Baud rate: ",STRINGIFY( USART_BAUD_RATE )))$ _STRNR()$ _STR_FLUSH()

    _DEBUG_LDS2( _(USART,_BAUDL), "Auto-configured Baudrate clock: ")
    _DEBUG_LDS2( HAL_ONE_MS, "Clocks/mS (HAL_ONE_MS): ")

  #ifdef CLKCTRL_MCLKTIMEBASE
    _DEBUG_LDS( CLKCTRL_MCLKTIMEBASE, "Clocks/μS: ")
  #endif

  blink:
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)   ; Toggle LED via hardware TGL reg

  POP_MANY r22
ENDF print_and_toggle
