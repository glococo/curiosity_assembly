; -----------------------------------------------------------------------------
; File: Examples/07_RTC/main.S
; Description: Demonstrates using the Real-Time Counter (RTC) for periodic events.
;              - Initializes the RTC to fire an interrupt every 3 seconds.
;              - Toggles the board LED and sends the selected string every 1 second.
; -----------------------------------------------------------------------------

FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board and USART initialization
    _DEVBUFFER(RX_DEVBUFFER, 128, USART_ADDR) ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")
    _STR("__ Real-Time Counter (RTC) for periodic events\r\n")$ _STR_FLUSH()

    HAL_RTC_INIT_MS  3000, 1024, RTC_PRESCALER_DIV1024_gc ; Setup 3s RTC overflow
    HAL_RTC_PIT_ENABLE RTC_PERIOD_CYC16384_gc ; Setup every 32768/16384= 500ms
    sei                                       ; Enable global interrupts

  loop:
    _STR_FLUSH()                              ; Drain buffer to USART hardware
    sleep                                     ; Wait for interrupts
    rjmp    loop                              ; Repeat indefinitely

ENDF main

; -----------------------------------------------------------------------------
; ISR: PORT_vect (Button Interrupt)
; Description: Send USART message when the board button is pressed.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START _(BOARD_BUTTON_PORT,_PORT_vect), r18
    _STR("Button interrupt fired!\r\n")             ; Push string to devbuffer
    _PORT_FLG(BOARD_BUTTON_PORT, BOARD_BUTTON_PIN)  ; Clear the interrupt flag
ISR_END _(BOARD_BUTTON_PORT,_PORT_vect), r18

; -----------------------------------------------------------------------------
; ISR: RTC_PIT_vect (PIT Interrupt)
; Description: Send an USART message state every time the PIT period expires.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START RTC_PIT_vect r18
    _PORT_TGL(BOARD_LED_PORT, BOARD_LED_PIN ) ; Toggle LED via hardware register
    ldi     r18, RTC_PI_bm                    ; Load RTC overflow flag mask
    sts     RTC_PITINTFLAGS, r18              ; Clear RTC interrupt flag
ISR_END RTC_PIT_vect r18

; -----------------------------------------------------------------------------
; ISR: RTC_CNT_vect (RTC Overflow Interrupt)
; Description: Toggle LED every time the RTC overflows.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START RTC_CNT_vect r18
    _STR("RTC OVF fired!\r\n")                ; Push string to devbuffer
    ldi     r18, RTC_OVF_bm                   ; Load RTC overflow flag mask
    sts     RTC_INTFLAGS, r18                 ; Clear RTC interrupt flag
ISR_END RTC_CNT_vect r18
