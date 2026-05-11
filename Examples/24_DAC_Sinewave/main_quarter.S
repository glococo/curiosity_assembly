; -----------------------------------------------------------------------------
; File: Examples/24_DAC_Sinewave/main.S
; Description: Generating Sine Wave Signal Using 10-Bit DAC.
;              - A 50Hz sine wave will be output on the external pin.
; -----------------------------------------------------------------------------

#include "../../Drivers/SINEWAVE/driver.S"

FUNC main
    _BOARD_SETUP()                                    ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)            ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ DAC - 50Hz sine wave - Quarter __ \r\n")
    _STR_FLUSH()

    _PRECOMPUTE_SINWAVE( sine )                      ; Load lookup table + helpers

    ldi     r16, PORT_ISC_INPUT_DISABLE_gc            ; Sinewave output pin
    sts     _PIN_CTRL( PORTD, 6 ), r16                ; Disable digital input capacitor
    _PIN_DIR_SET( PORTD, 6 )                          ; Set PIN as OUTPUT

    _VREF_DAC0_CONFIG( VREF_REFSEL_2V048_gc )         ; AVR Dx/EA/SD Vref setup
    _DAC0_ENABLE_OUTPUT()                             ; Enable DAC0 with output

    ; 50hz * (100 * 4) steps = 20000 updates/sec
    ; 20mhz/div4 5mhz/20000 updates = 250ticks
    ; CORE_CLOCK_OSCHF /4 /20 = 250ticks for 20mhz
    _TCA_BASIC(TCA0, TCA_SINGLE_CLKSEL_DIV4_gc, CORE_CLOCK_OSCHF/4/20 )  ; TCA basic operation
    _TCA_INT( TCA0, TCA_SINGLE_OVF_bm )               ; Overflow interrupt enabled
    sei
    _SLEEP_MODE()

  loop:

    _DAC0_OUTPUT_REG( r22 )                           ; Update DAC0 with precomputed value
    call    SINEWAVE_Get                              ; Get next sin value
    ldi     r18, 6                                    ; Shift left r23:r22 << 6
    call    _LSL16                                    ; and leave in r22 for next int update

    sleep
    jmp     loop                                      ; Repeat indefinitely

ENDF main

ISR_START TCA0_OVF_vect, r16
    ldi     r16, TCA_SINGLE_OVF_bm
    sts     TCA0_SINGLE_INTFLAGS, r16
ISR_END TCA0_OVF_vect, r16

