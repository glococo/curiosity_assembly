; -----------------------------------------------------------------------------
; File: Examples/22_TCE_Scaling/main.S
; Description: The example below shows how to set a TCE instance to generate
;              4 Pulse-Width Modulation (PWM) signals at 10 kHz with 20%, 40%,
;              60%, and 80% duty cycles. In this example, the scaling feature of
;              the values set in compare registers is highlighted. The Scale
;              mode changes during run time, affecting the duty cycle values.
;
; Example Usage:
;   Standalone example for AVR16EB32 Curiosity Nano.
;   - Outputs PWM signals on PORTD (WO0=PD0, WO1=PD1, WO2=PD2, WO3=PD3).
;   - Connect Osciloscope to PD0, PD1, PD2, PD3 to see the waves.
;
; Original C source code:
; https://github.com/microchip-pic-avr-examples/avr16eb32-tce-and-wex-new-features-examples-mplab-mcc
; -----------------------------------------------------------------------------
#define DUTY_CYCLE_20_PERCENT           (0x1999)
#define DUTY_CYCLE_40_PERCENT           (0x3333)
#define DUTY_CYCLE_60_PERCENT           (0x4CCC)
#define DUTY_CYCLE_80_PERCENT           (0x660C)
#define AMPLITUDE_MAX_DCY_50_PERCENT    (0x4000)
#define AMPLITUDE_MAX_DCY_75_PERCENT    (0x6000)
#define AMPLITUDE_MAX_DCY_100_PERCENT   (0x8000)
#define AMPLITUDE_MAX_DCY_150_PERCENT   (0xC000)
#define _TCE0_CMP_SET()                 _TCE0_CMPBUF( DUTY_CYCLE_20_PERCENT, DUTY_CYCLE_40_PERCENT, DUTY_CYCLE_60_PERCENT, DUTY_CYCLE_80_PERCENT )

FUNC main
    rcall   HAL_BOARD_SETUP                         ; Basic board and clock initialization (20MHz)
    _DEVBUFFER(TX_DEVBUFFER, 128, USART_ADDR)       ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ TCE: Generate 4 PWM signals at 10 kHz with 20%, 40%, 60%, and 80% duty cycles\r\n")$ _STR_FLUSH()

    ; TCE0 Initializacion ______________________________
    ; 1. Configure PORTD pins (PD0, PD1, PD2, PD3) as outputs for TCE0 PWM
    _PORTMUX_ROUTEA( TCE, 0, PORTD )                ; WOn: PD0, PD1, PD2, PD3, PD4, PD5, PD6, PD7

    ; 2. CTRLB: Enable WO0/1/2/3 outputs and select Dual-Slope PWM mode with overflow on BOTTOM
    ldi     r22, (TCE_CMP0EN_bm | TCE_CMP1EN_bm | TCE_CMP2EN_bm | TCE_CMP3EN_bm | TCE_WGMODE_DSBOTH_gc)
    sts     TCE0_CTRLB, r22

    ; 3. CTRLD: Enable Fractional scaling mode with amplitude
    ldi     r22, TCE_SCALE_FRACTIONAL_gc | TCE_AMPEN_bm | TCE_SCALEMODE_BOTTOM_gc
    sts     TCE0_CTRLD, r22

    ; 4. Set Base Period and initial Compare values (Duty Cycles)
    _TCE0_PERBUF( 1000 )
    _TCE0_CMP_SET()                                 ; Values are in UQ1.15 format of PER
    ldi2    r22, 0x8000                             ; Ampl 1.0 in UQ1.15 format
    sts2    TCE0_AMP, r22

    ; 5. Start TCE0 (System Clock / 2) 10mhz
    ldi     r22, TCE_CLKSEL_DIV2_gc | TCE_ENABLE_bm
    sts     TCE0_CTRLA, r22

  loop:
    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)          ; Try trigger on Rise/Fall of LED toggle
    ldi     r22, TCE_SCALE_FRACTIONAL_gc | TCE_AMPEN_bm | TCE_SCALEMODE_BOTTOM_gc
    sts     TCE0_CTRLD, r22
    ldi2    r22, AMPLITUDE_MAX_DCY_50_PERCENT
    sts2    TCE0_AMP, r22
    _TCE0_CMP_SET()
    _DELAY_MS(5)

    ldi     r22, TCE_SCALE_FRACTIONAL_gc | TCE_AMPEN_bm | TCE_SCALEMODE_CENTER_gc
    sts     TCE0_CTRLD, r22
    ldi2    r22, AMPLITUDE_MAX_DCY_75_PERCENT
    sts2    TCE0_AMP, r22
    _TCE0_CMP_SET()
    _DELAY_MS(5)

    _PIN_TGL(BOARD_LED_PORT,BOARD_LED_PIN)
    ldi     r22, TCE_SCALE_FRACTIONAL_gc | TCE_AMPEN_bm | TCE_SCALEMODE_TOP_gc
    sts     TCE0_CTRLD, r22
    ldi2    r22, AMPLITUDE_MAX_DCY_100_PERCENT
    sts2    TCE0_AMP, r22
    _TCE0_CMP_SET()
    _DELAY_MS(5)

    ldi     r22, TCE_SCALE_FRACTIONAL_gc | TCE_AMPEN_bm | TCE_SCALEMODE_TOPBOTTOM_gc
    sts     TCE0_CTRLD, r22
    ldi2    r22, AMPLITUDE_MAX_DCY_150_PERCENT
    sts2    TCE0_AMP, r22
    _TCE0_CMP_SET()
    _DELAY_MS(5)
    rjmp    loop

ENDF main
