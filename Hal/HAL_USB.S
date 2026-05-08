#ifdef USB0
; File: Hal/HAL_USB.S
; Description: USB Device Controller helper for AVR-DU family.
;              Provides routines for EP table setup, initialization and data transfer.

#define _USB_SETUP(ep_table, ep0_out, ep0_in)   HAL_USB_INIT ep_table, ep0_out, ep0_in
#define _USB_ENDPOINT(num, buf_out, buf_in)     HAL_USB_ENDPOINT_INIT num, buf_out, buf_in
#define _USB_ENABLE()                           HAL_USB_START
#define _USB_SET_ADDR(addr)                     HAL_USB_SET_ADDR addr

; USB Endpoint Types
#define USB_EP_TYPE_DISABLE           0x00
#define USB_EP_TYPE_CONTROL           0x40
#define USB_EP_TYPE_ISOCHRONOUS       0x80
#define USB_EP_TYPE_BULK              0xC0
#define USB_EP_TYPE_INTERRUPT         0xC0

; USB EP Table Offsets
#define USB_EP_TABLE_EP_OFFSET        32
#define USB_EP_OUT_OFFSET             0
#define USB_EP_IN_OFFSET              8
#define USB_EP_CTRL_OFFSET            1
#define USB_EP_CNT_OFFSET             2
#define USB_EP_DATAPTR_OFFSET         4
#define USB_EP_MCNT_OFFSET            6

; USB EP Status Bits
#define USB_EP_READY_bm               0x80
#define USB_EP_BUSY_bm                0x01

.macro HAL_USB_INIT ep_table, ep0_out, ep0_in
    ldi2    r22, \ep_table
    call   HAL_USB_SETUP_BASE
    ; Configure EP0
    ldi     r24, 0
    ldi     r22, USB_EP_TYPE_CONTROL | USB_BUFSIZE_DEFAULT_BUF64_gc
    ldi2    r20, \ep0_out
    ldi2    r18, \ep0_in
    call   HAL_USB_EP_CONFIG_FULL
.endm

.macro HAL_USB_ENDPOINT_INIT num, buf_out, buf_in
    ldi     r24, \num
    ldi     r22, USB_EP_TYPE_INTERRUPT | USB_BUFSIZE_DEFAULT_BUF8_gc
    ldi2    r20, \buf_out
    ldi2    r18, \buf_in
    call   HAL_USB_EP_CONFIG_FULL
.endm

.macro HAL_USB_START
    ldi     r24, (USB_ENABLE_bm | USB_FIFOEN_bm)
    sts     USB0_CTRLA, r24
.endm

.macro HAL_USB_SET_ADDR addr
    sts     USB0_ADDR, \addr
.endm

; --- Low Level Functions ---

FUNC HAL_USB_SETUP_BASE
    sts     USB0_EPPTRL, r22
    sts     USB0_EPPTRH, r23
    ldi     r24, (USB_RESET_bm | USB_SUSPEND_bm | USB_RESUME_bm)
    sts     USB0_INTCTRLA, r24
    ldi     r24, (USB_TRNCOMPL_bm | USB_SETUP_bm)
    sts     USB0_INTCTRLB, r24
    
ENDF HAL_USB_SETUP_BASE

FUNC HAL_USB_EP_CONFIG_FULL
  PUSH_MANY r16, r17, r18, r19, r20, r21, ZL, ZH
    movw    r16, r18                    ; r17:r16 = IN pointer
    movw    r18, r20                    ; r19:r18 = OUT pointer
    mov     r20, r22                    ; r20 = CTRL value
    mov     r21, r24                    ; r21 = EP number
    
    lds2    ZL, USB0_EPPTR
    subi    ZL, lo8(-USB_EP_TABLE_EP_OFFSET)
    sbci    ZH, hi8(-USB_EP_TABLE_EP_OFFSET)
    
    mov     r24, r21
    lsl     r24
    lsl     r24
    lsl     r24
    lsl     r24
    add     ZL, r24
    adc     ZH, __zero_reg__
    
    ; OUT EP
    std     Z+USB_EP_CTRL_OFFSET, r20
    std     Z+USB_EP_DATAPTR_OFFSET, r18
    std     Z+USB_EP_DATAPTR_OFFSET+1, r19
    std     Z+0, __zero_reg__ ; Status
    
    ; IN EP
    std     Z+USB_EP_IN_OFFSET+USB_EP_CTRL_OFFSET, r20
    std     Z+USB_EP_IN_OFFSET+USB_EP_DATAPTR_OFFSET, r16
    std     Z+USB_EP_IN_OFFSET+USB_EP_DATAPTR_OFFSET+1, r17
    std     Z+USB_EP_IN_OFFSET, __zero_reg__ ; Status
  POP_MANY ZH, ZL, r21, r20, r19, r18, r17, r16
    
ENDF HAL_USB_EP_CONFIG_FULL

; Function: HAL_USB_EP_SEND
; Inputs: r25 - EP Number
;         r23:r22 - Data Pointer
;         r21:r20 - Byte Count
FUNC HAL_USB_EP_SEND
  PUSH_MANY r18, ZL, ZH
    lds2    ZL, USB0_EPPTR
    subi    ZL, lo8(-USB_EP_TABLE_EP_OFFSET)
    sbci    ZH, hi8(-USB_EP_TABLE_EP_OFFSET)
    
    mov     r18, r25
    lsl     r18
    lsl     r18
    lsl     r18
    lsl     r18
    add     ZL, r18
    adc     ZH, __zero_reg__
    
    ; IN EP
    subi    ZL, lo8(-USB_EP_IN_OFFSET)
    sbci    ZH, hi8(-USB_EP_IN_OFFSET)
    
    std     Z+USB_EP_DATAPTR_OFFSET, r22
    std     Z+USB_EP_DATAPTR_OFFSET+1, r23
    std     Z+USB_EP_CNT_OFFSET, r20
    std     Z+USB_EP_CNT_OFFSET+1, r21
    
    ldi     r18, USB_EP_READY_bm
    std     Z+0, r18
  POP_MANY ZH, ZL, r18
    
ENDF HAL_USB_EP_SEND

#endif
