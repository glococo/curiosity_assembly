; -----------------------------------------------------------------------------
; File: Examples/25_OpAmp_Follower/main.S
; Description: Non-Inverting OpAmp Voltage follower: V-in * 2
;              OpAmp AVR DB Family
; -----------------------------------------------------------------------------

FUNC main
    _BOARD_SETUP()                                    ; Basic board initialization
    _DEVBUFFER(DEVBUFFER, 128, USART_ADDR)            ; Initialize the USART ring buffer
    _STR("__ CURIOSITY ASSEMBLY __\r\n")
    _STR("__ OpAmp - Non-inverting voltage follower OP0-INP -> OP0-OUT __ \r\n")
    _STR("__ AVR128DB48: Input: PD1 - Output: PD2 __ \r\n")
    _STR_FLUSH()

  _PIN_DIR_SET( PORTD, 2 )                                ; Set PIN PD2 as OP0OUT

  ldi     r16, OPAMP_ENABLE_bm                            ; OPAMP Module Setup
  sts     OPAMP_CTRLA, r16

  ; Input Mux: Positive = INP (PD1), Negative = Wiper
  ldi     r16, (OPAMP_OP0INMUX_MUXPOS_INP_gc | OPAMP_OP0INMUX_MUXNEG_WIP_gc)
  sts     OPAMP_OP0INMUX, r16

  ; Resistor Mux: Top = OUT, Bottom = GND, Wiper = WIP3 (Gain = 2)
  ldi     r16, (OPAMP_OP0RESMUX_MUXTOP_OUT_gc | OPAMP_OP0RESMUX_MUXBOT_GND_gc | OPAMP_OP0RESMUX_MUXWIP_WIP3_gc)
  sts     OPAMP_OP0RESMUX, r16

  ; OP0 Config: Output mode Normal + Always-on
  ldi     r16, OPAMP_OP0CTRLA_OUTMODE_NORMAL_gc | OPAMP_ALWAYSON_bm
  sts     OPAMP_OP0CTRLA, r16

  loop:
    jmp    loop

ENDF main
