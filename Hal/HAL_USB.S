; File: Hal/HAL_USB.S
; Description: USB Device Controller helper for AVR-DU family.
;              Provides routines for EP table setup, initialization and data transfer.
#ifdef USB0_CTRLA
#include "HAL_USB_DEF.S"
#include "HAL_USB_STRUCT.S"
#include "HAL_USB_HID_DEF.S"


#define _USB_SETUP(table, ep0_out, ep0_in)        HAL_USB_SETUP table, ep0_out, ep0_in
#define _USB_SETUP_EP(epnum, buf_out, buf_in)     HAL_USB_SETUP_EP epnum, buf_out, buf_in
#define _USB_ENABLE(max_endpoints)                HAL_USB_ENABLE max_endpoints
#define _USB_RESET()                              HAL_USB_RESET
#define _USB_DISABLE()                            HAL_USB_DISABLE
#define _USB_EP_STALL(epnum)                      HAL_USB_EP_STALL epnum
#define _USB_ADDRESS_SET(addr)                    HAL_USB_ADDRESS_SET addr
#define _USB_CONFIGURATION_SET(config)            HAL_USB_CONFIGURATION_SET config
#define _USB_SEND(epnum, dataptr, count)          HAL_USB_SEND epnum, dataptr, count
#define _USB_SEND_PROGMEM(epnum, dataptr, count)  HAL_USB_SEND_PROGMEM epnum, dataptr, count

; Macro: HAL_USB_SEND
; Description: Send Data to the USB Host
; Parameters:  epnum   - EP Number
;              dataptr - Data Pointer
;              count   - Byte Count
.macro HAL_USB_SEND epnum, dataptr, count
    ldi2    r22, \dataptr
    ldi2    r24, \count
    ldi     r16, \epnum
    call    HAL_USB_EP_SEND
.endm

; Macro: HAL_USB_SEND_PROGMEM
; Description: Copy Data from Flash (PROGMEM) to SRAM and send
; Parameters:  epnum   - EP Number
;              dataptr - Flash Data Pointer
;              count   - Byte Count
.macro HAL_USB_SEND_PROGMEM epnum, dataptr, count
    ldi2    r22, \dataptr
    ldi2    r24, \count
    ldi     r16, \epnum
    call    HAL_USB_SEND_PROGMEM
.endm

; Function: HAL_USB_EP_SEND
; Inputs:     r16 - EP Number
;         r23:r22 - Data Pointer
;         r25:r24 - Byte Count
FUNC HAL_USB_EP_SEND
  PUSH_MANY YL, YH
    ldi2    YL, USB_EP_TABLE + 32              ; TABLE -> EP0 -> IN-Offset
    mov     r0, r16
    lsl     r0
    lsl     r0
    lsl     r0
    lsl     r0                                 ; EP Offset -> EPnumber * 16
    add     YL, r0
    adc     YH, __zero_reg__
    
    std     Y+USB_EP_IN_DATAPTR, r22
    std     Y+USB_EP_IN_DATAPTR+1, r23
    std     Y+USB_EP_IN_CNT, r24
    std     Y+USB_EP_IN_CNT+1, r25

    ldi2    YL, USB0_STATUS0_INCLR
    mov     r0, r16
    lsl     r0
    lsl     r0
    add     YL, r0
    adc     YH, __zero_reg__
    ldi     r16, USB_BUSNAK_bm | USB_UNFOVF_bm
    st      Y, r16
  POP_MANY YH, YL
ENDF HAL_USB_EP_SEND

.macro HAL_USB_ADDRESS_SET addr
    sts     USB_DEVICE_ADDR, \addr
    _STR("USB_REQUEST_SET_ADDRESS:")$ _STR_X(\addr)$ _STRNR()$ _STR_FLUSH()
    ldi     r16, 0
    ldi2    r22, 0
    ldi2    r24, 0
    call    HAL_USB_EP_SEND                   ; Status stage: send ZLP
    lds     r24, USB_DEVICE_ADDR              ; SetAddress, we must apply it AFTER the ZLP.
    sts     USB0_ADDR, r24
.endm

.macro HAL_USB_CONFIGURATION_SET config
    _STR("USB_REQUEST_SET_CONFIGURATION:")$ _STR_X(\config)$ _STRNR()$ _STR_FLUSH()
    ldi     r16, 0
    ldi2    r22, 0
    ldi2    r24, 0
    call    HAL_USB_EP_SEND                   ; Status stage: send ZLP
.endm

.macro HAL_USB_EP_STALL epnum
  PUSH_MANY r22, YL, YH
    ldi2    YL, USB_EP_TABLE + 32 + (\epnum*8)
    ldd     r22, Y+USB_EP_OUT_CTRL
    andi    r22, USB_DOSTALL_bm
    std     Y+USB_EP_OUT_CTRL, r22
    ldd     r22, Y+USB_EP_IN_CTRL
    andi    r22, USB_DOSTALL_bm
    std     Y+USB_EP_IN_CTRL, r22
  POP_MANY YH, YL, r22
.endm

.macro HAL_USB_SETUP table, ep0_out, ep0_in
  PUSH_MANY r18, r19, r20, r21, r22, ZL, ZH
    ldi2    ZL, \table+32
    sts2    USB0_EPPTR, ZL
    ldi     r22, USB_ATTACH_bm
    sts     USB0_CTRLB, r22
    ldi     r22, USB_RESET_bm 
    sts     USB0_INTCTRLA, r22
    ldi     r22, USB_TRNCOMPL_bm | USB_SETUP_bm
    sts     USB0_INTCTRLB, r22
    ldi     r22, USB_TYPE_CONTROL_gc | USB_BUFSIZE_DEFAULT_BUF8_gc
    ldi2    r20, \ep0_out
    ldi2    r18, \ep0_in
    call    HAL_USB_EP_CONFIG
  POP_MANY ZH, ZL, r22, r21, r20, r19, r18
.endm

.macro HAL_USB_SETUP_EP epnum, buf_out, buf_in
  PUSH_MANY r18, r19, r20, r21, r22, ZL, ZH
    lds2    ZL, USB0_EPPTR
    adiw    ZL, 16 * \epnum
    ldi     r22, USB_TYPE_BULKINT_gc | USB_BUFSIZE_DEFAULT_BUF64_gc
    ldi2    r20, \buf_out
    ldi2    r18, \buf_in
    call    HAL_USB_EP_CONFIG
  POP_MANY ZH, ZL, r22, r21, r20, r19, r18
.endm

.macro HAL_USB_ENABLE max_endpoints
    ldi     r22, (USB_ENABLE_bm | USB_FIFOEN_bm | \max_endpoints)
    sts     USB0_CTRLA, r22
.endm
.macro HAL_USB_DISABLE
    sts     USB0_CTRLA, __zero_reg__
.endm

.macro HAL_USB_RESET
    ldi     r22, USB_RESET_bm
    sts     USB0_INTFLAGSA, r22
    sts     USB_DEVICE_ADDR, __zero_reg__
.endm

FUNC HAL_USB_EP_CONFIG
    std2    Z, USB_EP_OUT_DATAPTR, r20
    std2    Z, USB_EP_IN_DATAPTR, r18
    std     Z+USB_EP_OUT_CTRL, r22
    std     Z+USB_EP_IN_CTRL, r22
ENDF HAL_USB_EP_CONFIG

FUNC HAL_USB_SEND_PROGMEM
  PUSH_MANY r18, r19, XL, XH, ZL, ZH
    movw    ZL, r22                            ; Z = Flash Pointer
    movw    r18, r24                           ; r19:r18 = Byte Count
    
    tst     r16
    brne    _ep1_buf
    ldi2    XL, USB_EP0_BUF_IN
    jmp     _copy_loop
  _ep1_buf:
    ldi2    XL, USB_EP1_BUF_IN
    
  _copy_loop:
    tst     r18
    breq    _copy_done
    lpm     r0, Z+
    st      X+, r0
    dec     r18
    jmp     _copy_loop
    
  _copy_done:
    tst     r16
    brne    _send_ep1
    ldi2    r22, USB_EP0_BUF_IN
    jmp     _do_send
  _send_ep1:
    ldi2    r22, USB_EP1_BUF_IN
  _do_send:
    call    HAL_USB_EP_SEND
  POP_MANY ZH, ZL, XH, XL, r19, r18
ENDF HAL_USB_SEND_PROGMEM

#endif
