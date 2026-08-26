; -----------------------------------------------------------------------------
; Description: SD ERROR CTRL and SLEEP CTRL handling
;              - ISR Function wrapper
;              - Handling high priority ERR and SLP interruptions
;              - Test ESF injections with push button
; -----------------------------------------------------------------------------

FUNC main
    call   HAL_BOARD_SETUP                         ; Basic board and USART initialization
    _DEVBUFFER( DEVBUFFER, 128, USART_ADDR)         ; Initialize device USART ring buffer

    _DELAY_MS(1000)
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")
    _STR("__ SD FAMILY __ \r\n")
    _STR("__ Sleep while no INT: Push the button to awake\r\r\n")$ _STR_FLUSH()
    _STR(" Key registers:")
    lds   r22, RSTCTRL_RSTFR
    _STR(" RSTFR: ")$ _STR_U8()
    lds   r22, RSTCTRL_MCFLAGSA
    _STR(", MCFLAGSA: ")$ _STR_U8()
    lds   r22, RSTCTRL_MCFLAGSB
    _STR(", MCFLAGSB: ")$ _STR_U8()
    lds   r22, ERRCTRL_TIMEOUT
    _STR(", TIMEOUT: ")$ _STR_U8()
    lds   r22, ERRCTRL_CAUSE
    _STR(", ERR_CAUSE: ")$ _STR_U8()
    lds   r22, ERRCTRL_ESCVREGWARN
    _STR(", ERR_ESCVREGWARN: ")$ _STR_U8()
    _STRNR()$ _STR_FLUSH(1)

    _ERRCTRL_NORMAL()                               ; Reset ERR CTRL + Heartbeat

    ; Understanding VREG Monitor in deep Sleep states
    ; (Note 1) Try SLEEP_STANDBY() with/without VMONSEN
    ; Seems no way of handling ERR_isr when VMON trigger an INT in Sleep-Standby, reset always
    _WRITE_PROTECTED(SLPCTRL_VREGCTRL,__zero_reg__) ; Disable vreg mon in deep sleep
    _SLEEP_INT_ALL()                                ; Enable all Sleep interruptions

    _ISR( BOARD_BUTTON_PORT, Toggle_led )           ; These _ISR wrappers pay an overhead
    _ISR( ERRCTRL_INT_vect, ERR_isr )               ; of pushing SREG and calling a function.
    _ISR( SLPCTRL_INT_vect, SLP_isr )               ; Inneficient but visually attractive. Use
                                                    ; ISR_START / ISR_END in production.
    sei                                             ; Enable global interrupts

  loop:
    ; Sleep _SLEEP_STANDBY() without proper handling will trigger ERROR CAUSE 8 and therfore
    ; will rise a reset to the RSTCTRL (Note 1)
    _SLEEP_STANDBY()
    jmp    loop                                    ; Repeat indefinitely

ENDF main

FUNC ERR_isr                                        ; Priority 3
  PUSH_MANY r22, r23, r24, r25
    lds4    r22, ERRCTRL_ESF
    sts4    HAL_ERR_ESF, r16                        ; Reading and storing ESF
    ; 1) Handling recoverable device err here (higher priority)
    ;
    ;
    ; 2) Reset ESF reg (not otherwise)
    _ERRCTRL_RESET_ESF()
    _STR(" ERRCTRL_ESF: ")$ _STR_X32()              ; Error cause ID
    _STRNR()$ _STR_FLUSH(1)
  POP_MANY r25, r24, r23, r22
ENDF ERR_isr

FUNC SLP_isr                                        ; Priority 5
  PUSH r22
    lds   r22, SLPCTRL_INTFLAGS
    sts   SLPCTRL_INTFLAGS, __full_reg__            ; Clear ANY interrupt flag if it set
    _STR("__ SLPCTRL_INTFLAGS: ")$ _STR_U8()        ; Trigged INT in r22, print as uint8_t
    _STR_FLUSH(1)                                   ; Flush USART + wait 1ms
  POP r22
ENDF SLP_isr

FUNC Toggle_led                                     ; Priority 46
  PUSH r16
    _PIN_FLG(BOARD_BUTTON_PORT, BOARD_BUTTON_PIN)   ; Clear the interrupt flag if it set
    _PIN_TGL(BOARD_LED_PORT, BOARD_LED_PIN)         ; Toggle Pin output
    ldi   r16, 1
    _WRITE_PROTECTED(ERRCTRL_ESFTEST+2, r16)        ; Test ESF Injection to ESCEVSYS1
  POP r16
ENDF Toggle_led
