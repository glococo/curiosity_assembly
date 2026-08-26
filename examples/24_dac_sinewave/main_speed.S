; -----------------------------------------------------------------------------
; File: Examples/24_DAC_Sinewave/main_speed.S
; Description: Generating Sine Wave Signal Using 10-Bit DAC as 8-bit.
;              - A 50Hz sine wave will be output on the external pin.
; -----------------------------------------------------------------------------

#include "../../drivers/sinewave/driver.S"

FUNC main
    _BOARD_SETUP()                                    ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)            ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ DAC - 50Hz sine wave - 8-bit high speed table __ \r\n")
    _STR_FLUSH()

    ldi     r16, PORT_ISC_INPUT_DISABLE_gc            ; Sinewave output pin
    sts     _PIN_CTRL( PORTD, 6 ), r16                ; Disable digital input capacitor
    _PIN_DIR_SET( PORTD, 6 )                          ; Set PIN as OUTPUT

    _VREF_DAC0_CONFIG( VREF_REFSEL_2V048_gc )         ; AVR Dx/EA/SD Vref setup
    _DAC0_ENABLE_OUTPUT()                             ; Enable DAC0 with output

    ; 50hz * 200 steps = 10000 updates/sec
    ; 20mhz/div4 5mhz/10000 updates = 500ticks
    ; CORE_CLOCK_OSCHF /4 /10 = 500ticks for 20mhz
    _TCA_BASIC(TCA0, TCA_SINGLE_CLKSEL_DIV4_gc, CORE_CLOCK_OSCHF/4/10 )  ; TCA basic operation
    _TCA_INT( TCA0, TCA_SINGLE_OVF_bm )               ; Overflow interrupt enabled

    _SPEED_SINEWAVE_INIT()                            ; Load 360º lookup table + helpers
    _SLEEP_MODE()
    sei                                               ; Try disabling sei+sleep and see almost max DAC speed on osciloscope

  loop:
    sts     DAC0_DATAH, r22                           ; Update DAC0 with precomputed value
    _SPEED_SINEWAVE_Get()                             ; Get next sin value

    sleep                                             ; sleep
    jmp     loop                                      ; Repeat indefinitely

ENDF main

ISR_START TCA0_OVF_vect, r16
    ldi     r16, TCA_SINGLE_OVF_bm
    sts     TCA0_SINGLE_INTFLAGS, r16
ISR_END TCA0_OVF_vect, r16

