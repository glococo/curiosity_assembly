; File: Hal/HAL_USB_EP0.S
; Description: AVR_DU USB Device Controller EP0 Handlers
; Created: 2026-05-31

; Function: HAL_USB_EP0_SETUP
; Description: EP0 Control Endpoint setup packet dispatcher
FUNC HAL_USB_EP0_SETUP
  PUSH_MANY r18, r19, r20, r21, r22, r23, r24, r25, XL, XH
    
    ldi2    XL, USB0_EP0_BUF_OUT                         ; Parse 8-byte setup packet from USB0_EP0_BUF_OUT
    ld      r18, X+     ; bmRequestType
    ld      r19, X+     ; bRequest
    ld      r20, X+     ; wValueL
    ld      r21, X+     ; wValueH
    ld      r22, X+     ; wIndexL
    ld      r23, X+     ; wIndexH
    ld      r24, X+     ; wLengthL
    ld      r25, X+     ; wLengthH
    
    mov     r16, r18
    andi    r16, USB_REQUEST_TYPE_MASK
    cpi     r16, USB_REQUEST_TYPE_STANDARD              ; bmRequestType standard/class/vendor
    breq    _ep0_request_standard
    jmp     _ep0_stall                                  ; Class/Vendor requests stall by default

  _ep0_request_standard:
    mov     r16, r18
    andi    r16, USB_REQUEST_RECIPIENT_MASK
    cpi     r16, USB_REQUEST_RECIPIENT_DEVICE
    breq    _ep0_request_recipient_device
    jmp     _ep0_stall                                  ; Endpoint/Interface/Other requests stall by default

  _ep0_request_recipient_device:
    cpi     r19, USB_REQUEST_GET_DESCRIPTOR
    brne    1f
    jmp     _ep0_get_descriptor
  1:
    cpi     r19, USB_REQUEST_SET_ADDRESS
    brne    2f
    _STR("SET_ADDRESS\r\n")
    jmp     _ep0_set_address
  2:
    cpi     r19, USB_REQUEST_SET_CONFIGURATION
    brne    3f
    _STR("SET_CONFIGURATION\r\n")
    jmp     _ep0_set_config
  3:
    cpi     r19, USB_REQUEST_GET_STATUS
    brne    4f
    _STR("GET_STATUS\r\n")
    jmp     _ep0_get_status
  4:
    cpi     r19, USB_REQUEST_CLEAR_FEATURE
    brne    5f
    _STR("CLEAR_FEATURE\r\n")
    jmp     _ep0_clear_feature
  5:
    cpi     r19, USB_REQUEST_SET_FEATURE
    brne    6f
    _STR("SET_FEATURE\r\n")
    jmp     _ep0_set_feature
  6:
    jmp     _ep0_stall

  _ep0_get_descriptor:
    cpi     r21, USB_DESCRIPTOR_TYPE_DEVICE
    brne    1f
    _STR("GET_DESC DEVICE _OUT ")
    jmp     _ep0_get_desc_type_device
  1:
    cpi     r21, USB_DESCRIPTOR_TYPE_CONFIGURATION
    brne    2f
    jmp     _ep0_get_desc_type_config
  2:
    cpi     r21, USB_DESCRIPTOR_TYPE_STRING
    brne    3f
    _STR("GET_DESC STRING\r\n")
    jmp     _ep0_get_desc_type_string
  3:
    cpi     r21, USB_DESCRIPTOR_TYPE_DEVICE_QUALIFIER
    brne    4f
    _STR("GET_DESC QUALIFIER ")
    jmp     _ep0_get_desc_type_qualifier
  4:
    cpi     r21, 0x21                                             ; HID descriptor type
    brne    5f
    _STR("GET_DESC HID\r\n")
    jmp     _ep0_get_desc_type_hid
  5:
    cpi     r21, 0x22                                             ; HID Report descriptor type
    brne    6f
    _STR("GET_DESC REPORT\r\n")
    jmp     _ep0_get_desc_type_report
  6:
    jmp     _ep0_stall

  _ep0_get_desc_type_device:
    _STR_HEX_MEM8(USB0_EP0_BUF_OUT,8)
    cpi     r25, 0                                                ; wLength >= 18? otherwise clamp r25:r24 to 18
    brne    1f
    cpi     r24, 18
    brlo    2f
  1:
    ldi     r24, 18
    ldi     r25, 0
  2:
    ldi     r16, 0
    ldi2    r22, USB_DEVICE_DESC
    call    HAL_USB_SEND_PROGMEM
    _STR(", IN ")$ _STR_HEX_MEM8(USB0_EP0_BUF_IN,8)$ _STR("\r\n")
    jmp     _ep0_done

  _ep0_get_desc_type_config:
    _STR("GET_DESC CONFIG\n\r")
    cpi     r25, 0                                                ; wLength >= 34? otherwise clamp r25:r24 to 34
    brne    1f
    cpi     r24, 34
    brlo    2f
  1:
    ldi     r24, 34
    ldi     r25, 0
  2:
    ldi     r16, 0
    ldi2    r22, USB_DEVICE_CONF
    call    HAL_USB_SEND_PROGMEM
    _STR("__ GET_CONF BUF_IN 0x ")$ _STR_HEX_MEM8(USB0_EP0_BUF_IN,34)
    jmp     _ep0_done

  _ep0_get_desc_type_string:
    _DEBUG_REG(r20,"GET_DESC STRING 0x")
    tst     r20
    brne    _ep0_get_desc_type_string_1
    ; String 0: max 4
    cpi     r25, 0
    brne    1f
    cpi     r24, 4
    brlo    2f
  1:
    ldi     r24, 4
    ldi     r25, 0
  2:
    ldi     r16, 0
    ldi2    r22, USB_STR_0
    call    HAL_USB_SEND_PROGMEM
    jmp     _ep0_done

_ep0_get_desc_type_qualifier:
    jmp     _ep0_stall
    ;ldi     r16, 0
    ;ldi2    r24, 0
    ;call    HAL_USB_SEND
    ;jmp     _ep0_done

  _ep0_get_desc_type_string_1:
    cpi     r20, 1
    brne    _ep0_get_desc_type_string_2
    ; String 1: max 20
    cpi     r25, 0
    brne    1f
    cpi     r24, 20
    brlo    2f
  1:
    ldi     r24, 20
    ldi     r25, 0
  2:
    ldi     r16, 0
    ldi2    r22, USB_STR_1
    call    HAL_USB_SEND_PROGMEM
    jmp     _ep0_done

  _ep0_get_desc_type_string_2:
    cpi     r20, 2
    brne    _ep0_get_desc_type_string_3
    ; String 2: max 22
    cpi     r25, 0
    brne    1f
    cpi     r24, 22
    brlo    2f
  1:
    ldi     r24, 22
    ldi     r25, 0
  2:
    ldi     r16, 0
    ldi2    r22, USB_STR_2
    call    HAL_USB_SEND_PROGMEM
    jmp     _ep0_done

  _ep0_get_desc_type_string_3:
    cpi     r20, 3
    brne    _ep0_get_desc_type_string_stall
    ; String 3: max 4
    cpi     r25, 0
    brne    1f
    cpi     r24, 4
    brlo    2f
  1:
    ldi     r24, 4
    ldi     r25, 0
  2:
    ldi     r16, 0
    ldi2    r22, USB_STR_3
    call    HAL_USB_SEND_PROGMEM
    jmp     _ep0_done

  _ep0_get_desc_type_string_stall:
    jmp     _ep0_stall

  _ep0_get_desc_type_hid:
    _STR("GET_DESC HID\n\r")
    ; Clamp r25:r24 to 9
    cpi     r25, 0
    brne    1f
    cpi     r24, 9
    brlo    2f
  1:
    ldi     r24, 9
    ldi     r25, 0
  2:
    ldi     r16, 0
    ldi2    r22, USB_DEVICE_CONF + 18
    call    HAL_USB_SEND_PROGMEM
    jmp     _ep0_done

  _ep0_get_desc_type_report:
    _STR("GET_DESC REPORT\n\r")
    ; Clamp r25:r24 to USB_HID_REPORT_DESCRIPTOR_SIZE
    cpi     r25, hi8(USB_HID_REPORT_DESCRIPTOR_SIZE)
    brne    1f
    cpi     r24, lo8(USB_HID_REPORT_DESCRIPTOR_SIZE)
    brlo    2f
  1:
    ldi     r24, lo8(USB_HID_REPORT_DESCRIPTOR_SIZE)
    ldi     r25, hi8(USB_HID_REPORT_DESCRIPTOR_SIZE)
  2:
    ldi     r16, 0
    ldi2    r22, USB_HID_REPORT_DESC
    call    HAL_USB_SEND_PROGMEM
    jmp     _ep0_done

  _ep0_set_address:
    _USB_ADDRESS_SET(r20)
    jmp     _ep0_done

  _ep0_set_config:
    _USB_CONFIGURATION_SET(r20)
    jmp     _ep0_done

  _ep0_get_status:
    _STR("GET_STATUS\n\r")
    ldi     r16, 0
    sts     USB0_EP0_BUF_IN, r16
    sts     USB0_EP0_BUF_IN+1, r16
    _USB_SEND(0, USB0_EP0_BUF_IN, 2)
    jmp     _ep0_done

  _ep0_clear_feature:
  _ep0_set_feature:
    _STR("CLEAR/SET FEATURE\n\r")
    ldi     r16, 0
    ldi2    r22, 0
    ldi2    r24, 0
    call    HAL_USB_SEND
    jmp     _ep0_done

  _ep0_stall:
    _USB_STATUS_CLEAR(USB_EPSETUP_bm, USB0_STATUS0_OUTCLR)
    _USB_WAIT_RMW
    _USB_EP_STALL(0)
;    ldd     r16, Y+USB_EP_IN_STATUS
;    _DEBUG_REG(r16,"USB_EP_IN_STATUS")
;    ldd     r16, Y+USB_EP_OUT_STATUS
;    _DEBUG_REG(r16,"USB_EP_OUT_STATUS")
;    ldd     r16, Y+USB_EP_IN_CTRL
;    _DEBUG_REG(r16,"USB_EP_IN_CTRL")
;    ldd     r16, Y+USB_EP_OUT_CTRL
;    _DEBUG_REG(r16,"USB_EP_OUT_CTRL")
    _STR("_____ EP0_STALL\n\r")

  _ep0_done:
    _USB_STATUS_CLEAR(USB_EPSETUP_bm | USB_TRNCOMPL_bm, USB0_STATUS0_OUTCLR, USB0_STATUS0_INCLR)
    _USB_CLEAR_SETUP()                                  ; Clear setup and transaction complete flags at peripheral level

  POP_MANY XH, XL, r25, r24, r23, r22, r21, r20, r19, r18
ENDF HAL_USB_EP0_SETUP


/*
    sbrc    r16, USB_SETUP_bp
    jmp     _ep0_call
    _DEBUG_REG(r22, "USB0_INTFLAGSB")
    ldi2    YL, USB_EP_TABLE + USB_FIFO_OFFSET
    ldd     r22, Y+USB_EP_IN_STATUS
    _DEBUG_REG(r22, "USB0_EP_IN_STATUS ")
    sbrc    r22, USB_TRNCOMPL_bp
    jmp     _ep0__call
    sbrc    r22, USB_EPSETUP_bp
    jmp     _ep0___call
    ldd     r22, Y+USB_EP_OUT_STATUS
    _DEBUG_REG(r22, "USB0_EP_OUT_STATUS ")
    sbrc    r22, USB_TRNCOMPL_bp
    jmp     _ep0____call
    sbrc    r22, USB_EPSETUP_bp
    jmp     _ep0_____call
    jmp     _not_setup

  _ep0_call:
    _STR("_____ EP0 setup\r\n")
    call    HAL_USB_EP0_HANDLER
    jmp     _exit_handler
  _ep0__call:
    _STR("_____ EP0 trncompl\r\n")
    call    HAL_USB_EP0_HANDLER
    jmp     _exit_handler
  _ep0___call:
    _STR("_____ EP0 epsetup\r\n")
    call    HAL_USB_EP0_HANDLER
    jmp     _exit_handler
  _ep0____call:
    _STR("_____ EP0 out trncompl\r\n")
    call    HAL_USB_EP0_HANDLER
    jmp     _exit_handler
  _ep0_____call:
    _STR("_____ EP0 out epsetup\r\n")
    call    HAL_USB_EP0_HANDLER
    jmp     _exit_handler
*/   
