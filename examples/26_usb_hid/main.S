; -----------------------------------------------------------------------------
; Description: AVR_DU USB HID Keyboard typing
; -----------------------------------------------------------------------------
#include "usb_device.S"

FUNC main
    _BOARD_SETUP()                                        ; Basic board and USART initialization
    _DEVBUFFER( A_BUFFER, 256, USART_ADDR)                ; Initialize device USART ring buffer
    _PIN_OUT_SET(BOARD_LED_PORT, BOARD_LED_PIN)           ; Toggle LED off
    _DELAY_MS(1000)
    _STR("__ CURIOSITY ASSEMBLY __ \r\n")
    _STR("__ DU FAMILY __ \r\n")$ _STR_FLUSH(1)
    
    ldi   r16, PORT_ISC_INPUT_DISABLE_gc                  ; USB DETECT PC3 PIN - Disable input buffer
    sts   _PIN_CTRL( PORTC, PIN3 ), r16

    _AC0_MUX( AC_MUXPOS_AINP4_gc | AC_MUXNEG_DACREF_gc )  ; AC0 SETUP
    _AC0_DACREF( 320*255/1024 )                           ; 1.024v==0xFF(255), 0.32v== 320*255/1024
    _AC0_ENABLE( AC_CMP_bm | AC_INTMODE_BOTHEDGE_gc )     ; AC0 Enable with Interruptions

    _USB_SETUP(USB0_EP_TABLE, USB0_EP0_BUF_OUT, USB0_EP0_BUF_IN, 1)
    _USB_SETUP_EP(1, USB0_EP1_BUF_OUT, USB0_EP1_BUF_IN)
    sei

  loop:
    _DELAY_MS(10000)
    jmp     loop

ENDF main

ISR_START _(BOARD_BUTTON_PORT,_PORT_vect), r22
    _PIN_FLG(BOARD_BUTTON_PORT, BOARD_BUTTON_PIN)
    ldi     r22, 0x01
    sts     USB0_STATUS0_OUTSET, r22
    call    TMP_PRINT_STATUS
ISR_END _(BOARD_BUTTON_PORT,_PORT_vect), r22


ISR_START USB0_BUSEVENT_vect, r16
    _USB_BUSEVENT_ISR(r16)
ISR_END USB0_BUSEVENT_vect, r16

ISR_START USB0_TRNCOMPL_vect, r16  
    lds     r16, USB0_STATUS
    cpi     r16, USB_STATUS_CONFIGURED
    brsh    _usb_already_configred   
    call    _USB_SETUP_ISR
    jmp     _trncompl_done

  _usb_already_configred:
    _STR("Already Configured\r\n")
    call    _USB_EPx_TRNCOMPL_ISR
    
  _trncompl_done:
    ldi     r16, USB_TRNCOMPL_bm
    sts     USB0_INTFLAGSB, r16                             ; Clear global transaction complete flag
    _STR_FLUSH()
ISR_END USB0_TRNCOMPL_vect, r16

FUNC _USB_SETUP_ISR
  PUSH_MANY r17, YL, YH
    ldi2    YL, USB0_EP_TABLE + USB_FIFO_OFFSET

  _check_ep0_out_setup:                                     ; __ 1. Check OUT Setup flag
    ldd     r16, Y + USB_EP_OUT_STATUS
    mov     r17, r16
    andi    r17, USB_EPSETUP_bm
    breq    _check_ep0_out_trn
    call    HAL_USB_EP0_SETUP
    jmp     _check_ep0_in

  _check_ep0_out_trn:                                       ; __ 2. Check OUT Transaction Complete flag
    mov     r17, r16
    andi    r17, USB_TRNCOMPL_bm
    breq    _check_ep0_in
    _USB_WAIT_RMW
    ldi     r17, USB_TRNCOMPL_bm
    sts     USB0_STATUS0_OUTCLR, r17                        ; Clear TRNCOMPL on EP0 OUT

  _check_ep0_in:                                            ; __ 3. Check IN Transaction Complete flag
    ldd     r16, Y + USB_EP_IN_STATUS
    mov     r17, r16
    andi    r17, USB_TRNCOMPL_bm
    brne    _trn_ep0_in_compl
    jmp     _done

  _trn_ep0_in_compl:                                        ; __ 4. IN Transaction Complete (e.g. Data Stage IN complete or Status Stage IN ZLP complete)
    _USB_WAIT_RMW
    ldi     r17, USB_TRNCOMPL_bm
    sts     USB0_STATUS0_INCLR, r17                         ; Clear TRNCOMPL on EP0 IN
    
    lds     r16, USB0_ADDRESS                               ; Check if there is a pending address change
    lds     r17, USB0_ADDR
    cp      r16, r17
    breq    _no_pending_addr
    
    sts     USB0_ADDR, r16                                  ; Apply the new address
    ldi     r17, USB_STATUS_ADDRESS
    sts     USB0_STATUS, r17                                ; Set state to ADDRESS      
    _USB_WAIT_RMW
    ldi     r17, USB_TOGGLE_bm
    sts     USB0_STATUS0_OUTCLR, r17                        ; Reset EP0 OUT toggle to DATA0 for next Setup stage
    _USB_WAIT_RMW
    ldi     r17, USB_BUSNAK_bm
    sts     USB0_STATUS0_OUTCLR, r17
    _STR("_____ Address Applied!\r\n")
    jmp     _done
    
  _no_pending_addr:
    _USB_WAIT_RMW
    ldi     r17, USB_TOGGLE_bm
    sts     USB0_STATUS0_OUTSET, r17                        ; Prepare EP0 OUT for Status stage (expecting DATA1 OUT ZLP)
    _USB_WAIT_RMW
    ldi     r17, USB_BUSNAK_bm
    sts     USB0_STATUS0_OUTCLR, r17

  _done:
  POP_MANY YH, YL, r17
ENDF _USB_SETUP_ISR

ISR_START AC0_AC_vect, r16  
    lds     r16, AC0_STATUS
    sbrs    r16, AC_CMPSTATE_bp
    jmp     0f
    _PIN_OUT_CLR(BOARD_LED_PORT, BOARD_LED_PIN)         ; Toggle Pin output
    _USB_ATTACH()
    jmp     1f
  0:
    _PIN_OUT_SET(BOARD_LED_PORT, BOARD_LED_PIN)         ; Toggle Pin output
    _USB_DETACH()
  1:
    ldi     r16, 0x01
    sts     AC0_STATUS, r16
ISR_END AC0_AC_vect, r16


FUNC TMP_PRINT_STATUS
  PUSH_MANY r20, r21, r22, r23, YL, YH
    _DEBUG_LDS(USB0_CTRLA, "USB0_CTRLA ")
    _DEBUG_LDS(USB0_CTRLB, "USB0_CTRLB ")
    _DEBUG_LDS(USB0_INTFLAGSA, "USB0_INTFLAGSA ")
    _DEBUG_LDS(USB0_INTFLAGSB, "USB0_INTFLAGSB ")
    _DEBUG_LDS(USB0_INTCTRLA, "USB0_INTCTRLA ")
    _DEBUG_LDS(USB0_INTCTRLB, "USB0_INTCTRLB ")
    ;_DEBUG_LDS2(USB0_EPPTR, "USB0_EPPTR ")

    ldi2    YL, USB0_EP_TABLE + USB_FIFO_OFFSET
    ldd     r20, Y + USB_EP_OUT_CTRL
    ldd     r21, Y + USB_EP_OUT_STATUS
    ldd     r22, Y + USB_EP_OUT_CNT
    ldd     r23, Y + USB_EP_OUT_MCNT
    _DEBUG_REG(r20, "USB0_EP_OUT_CTRL ")
    _DEBUG_REG(r21, "USB0_EP_OUT_STATUS ")
    _DEBUG_REG(r22, "USB0_EP_OUT_CNT ")
    _DEBUG_REG(r23, "USB0_EP_OUT_MCNT ")

    ldd     r20, Y + USB_EP_IN_CTRL
    ldd     r21, Y + USB_EP_IN_STATUS
    ldd     r22, Y + USB_EP_IN_CNT
    ldd     r23, Y + USB_EP_IN_MCNT
    _DEBUG_REG(r20, "USB0_EP_IN_CTRL ")
    _DEBUG_REG(r21, "USB0_EP_IN_STATUS ")
    _DEBUG_REG(r22, "USB0_EP_IN_CNT ")
    _DEBUG_REG(r23, "USB0_EP_IN_MCNT ")

    _STR("USB0_EP0_BUF_OUT 0x ")$ _STR_HEX_MEM8(USB0_EP0_BUF_OUT,20)$ _STR_FLUSH()
    _STR("USB0_EP0_BUF_IN 0x ")$ _STR_HEX_MEM8(USB0_EP0_BUF_IN,20)$ _STR_FLUSH()
    _STR("TABLE_EP0 0x ")$ _STR_HEX_MEM8(USB0_EP_TABLE+32,20)$ _STR_FLUSH()
    _STR("TABLE_EP1 0x ")$ _STR_HEX_MEM8(USB0_EP_TABLE+32+16,20)$ _STR_FLUSH()
  POP_MANY YH, YL, r23, r22, r21, r20
ENDF TMP_PRINT_STATUS    

FUNC _USB_EPx_TRNCOMPL_ISR
  /*; 3. Check EP1 IN Status (USB0_EP_TABLE + 32 + 16)
    ldd     r16, Y + 16 + USB_EP_IN_STATUS
    mov     r17, r16
    andi    r17, USB_TRNCOMPL_bm
    breq    _clear_global
    
    ; EP1 IN Transaction Complete (e.g. Keyboard report sent)
    ; Clear TRNCOMPL on EP1 IN
    _USB_WAIT_RMW
    ldi     r17, USB_TRNCOMPL_bm
    sts     USB0_STATUS1_INCLR, r17
  */
ENDF _USB_EPx_TRNCOMPL_ISR


  
