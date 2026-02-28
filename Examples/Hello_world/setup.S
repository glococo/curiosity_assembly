DEFUN Set_RGB
  Set_RGB:
    lds   r16, CPU_DIVISOR                      ; CLKCTRL_MCLKCTRLB
    cpi   r16, 0x01
    breq  led_red
    cpi   r16, 0x02
    breq  led_green
    ldi   r16, 0x01             ; led_blue
    rjmp  led_exit
  led_red:
    ldi   r16, 0x40
    rjmp  led_exit
  led_green:
    ldi   r16, 0x80
  led_exit:
    sts   PORTD_OUT, r16
  ret
ENDF Set_RGB
