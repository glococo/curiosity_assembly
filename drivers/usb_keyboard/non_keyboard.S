/*
FUNC Task_Keyboard
    lds     r24, HELLO_STATE
    tst     r24
    breq    _task_done

    ; Check if EP1 IN is busy
    ldi2    YL, USB_EP_TABLE + (USB_EP_EP_OFFSET*1)
    ldd     r16, Y+USB_EP_IN_STATUS ; Check if EP1 IN is busy
    sbrs    r16, USB_EP_BUSY_bp 
    jmp     _task_done

    ; Clear report buffer
    ldi2    XL, USB_EP1_BUF_IN
    .rept 8
      st    X+, r2
    .endr

    lds     r24, HELLO_STATE
    cpi     r24, 2 ; Releasing
    breq    _do_release

    ; Pressing
    lds     r24, HELLO_INDEX
    ldi2    ZL, MSG_HELLO
    add     ZL, r24
    adc     ZH, __zero_reg__
    lpm     r18, Z
    sts     USB_EP1_BUF_IN + 2, r18 ; Key 1

    ldi     r24, 2
    sts     HELLO_STATE, r24 ; Next is release
    jmp     _send_report

  _do_release:
    lds     r24, HELLO_INDEX
    inc     r24
    sts     HELLO_INDEX, r24
    cpi     r24, 5
    brne    0f
    sts     HELLO_STATE, __zero_reg__ ; Done
    jmp    _send_report
  0:
    ldi     r24, 1
    sts     HELLO_STATE, r24 ; Next is press
    
  _send_report:
    ldi     r25, 1 ; EP1
    ldi2    r22, USB_EP1_BUF_IN
    ldi2    r20, 8
    //call   HAL_USB_EP_SEND
    
  _task_done:
ENDF Task_Keyboard
*/