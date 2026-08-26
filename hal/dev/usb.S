; File: Hal/HAL_USB.S
; Description: USB Device Controller helper for AVR-DU family.
;              Provides routines for EP table setup, initialization and data transfer.
#ifdef USB0_CTRLA
#include "usb_def.S"
#include "usb_struct.S"
#include "usb_hid_def.S"


#define _USB_SETUP(table, ep0_out, ep0_in, max)   HAL_USB_SETUP table, ep0_out, ep0_in, max
#define _USB_SETUP_EP(epnum, buf_out, buf_in)     HAL_USB_SETUP_EP epnum, buf_out, buf_in
#define _USB_ATTACH()                             HAL_USB_ATTACH
#define _USB_DETACH()                             HAL_USB_DETACH
#define _USB_RESET()                              HAL_USB_RESET
#define _USB_CLEAR_SETUP()                        HAL_USB_CLEAR_SETUP
#define _USB_STATUS_CLEAR(bm, ...)                HAL_USB_STATUS_CLEAR bm, __VA_ARGS__
#define _USB_EP_CLEAR(ctrl_reg, bm)               HAL_USB_EP_CLEAR ctrl_reg, bm
#define _USB_EP_STALL(epnum)                      HAL_USB_EP_STALL epnum
#define _USB_EP_RESET(reg_offset)                 HAL_USB_EP_RESET reg_offset
#define _USB_ADDRESS_SET(addr)                    HAL_USB_ADDRESS_SET addr
#define _USB_CONFIGURATION_SET(config)            HAL_USB_CONFIGURATION_SET config
#define _USB_SEND(epnum, dataptr, count)          HAL_USB_SEND epnum, dataptr, count
#define _USB_SEND_PROGMEM(epnum, dataptr, count)  HAL_USB_SEND_PROGMEM epnum, dataptr, count
#define _USB_BUSEVENT_ISR(reg)                    HAL_USB_BUSEVENT_ISR reg

; Macro: HAL_USB_BUSEVENT_ISR
; Description: Handle Bus Event Interrupt
; Parameters:  reg - Register to use for interrupt flag
.macro HAL_USB_BUSEVENT_ISR reg
    lds     \reg, USB0_INTFLAGSA
    sbrs    \reg, USB_RESET_bp
    jmp     0f
    _STR("_____ USB_BusEvent_Reset!\n\r")
    _USB_RESET()
    jmp     1f
  0:
    _STR("_____ Not a reset!\n\r")
    _DEBUG_REG(\reg, "USB0_INTFLAGSA: 0x")
  1:
.endm

; Macro: _USB_WAIT_RMW
; Description: Wait until Read-Modify-Write operation on USB status registers is complete
.macro _USB_WAIT_RMW
0:
  lds     r0, USB0_INTFLAGSB
  sbrc    r0, USB_RMWBUSY_bp
  rjmp    0b
.endm

; Macro: HAL_USB_CLEAR_SETUP
; Description: Clear Setup and Transaction Complete flags
; Parameters:  None
.macro HAL_USB_CLEAR_SETUP
    ldi     r16, USB_SETUP_bm | USB_TRNCOMPL_bm
    sts     USB0_INTFLAGSB, r16
.endm

; Macro: HAL_USB_EP_RESET
; Description: Reset USB Endpoint
; Parameters:  reg_offset   - Register to reset
.macro HAL_USB_EP_RESET reg_offset
    std     Y+\reg_offset, __zero_reg__
.endm

; Macro: HAL_USB_SEND
; Description: Send Data to the USB Host
; Parameters:  epnum   - EP Number
;              dataptr - Data Pointer
;              count   - Byte Count
.macro HAL_USB_SEND epnum, dataptr, count
    ldi     r16, \epnum
    ldi2    r22, \dataptr
    ldi2    r24, \count
    call    HAL_USB_SEND
.endm

; Macro: HAL_USB_SEND_PROGMEM
; Description: Copy Data from Flash (PROGMEM) to SRAM and send
; Parameters:  epnum   - EP Number
;              dataptr - Flash Data Pointer
;              count   - Byte Count
.macro HAL_USB_SEND_PROGMEM epnum, dataptr, count
    ldi     r16, \epnum
    ldi2    r22, \dataptr
    ldi2    r24, \count
    call    HAL_USB_SEND_PROGMEM
.endm

; Function: HAL_USB_SEND
; Inputs:     r16 - EP Number
;         r25:r24 - Byte Count
FUNC HAL_USB_SEND
  PUSH_MANY YL, YH
    ldi2    YL, USB0_EP_TABLE + 32              ; TABLE -> EP0
    mov     r0, r16
    lsl     r0
    lsl     r0
    lsl     r0
    lsl     r0                                 ; EP Offset -> EPnumber * 16
    add     YL, r0
    adc     YH, __zero_reg__
    
    std     Y+USB_EP_IN_MCNT, __zero_reg__
    std     Y+USB_EP_IN_MCNT+1, __zero_reg__
    std2    Y, USB_EP_IN_CNT, r24

    ldi2    YL, USB0_STATUS0_INCLR
    mov     r0, r16
    lsl     r0
    lsl     r0
    add     YL, r0
    adc     YH, __zero_reg__

    _USB_WAIT_RMW
    ldi     r18, USB_TOGGLE_bm
    std     Y+1, r18                           ; Y+1 points to USB0_STATUS0_INSET. Set EP0 IN toggle to DATA1.
  1:
    _USB_WAIT_RMW
    ldi     r16, USB_BUSNAK_bm | USB_UNFOVF_bm | USB_TRNCOMPL_bm
    st      Y, r16
  POP_MANY YH, YL
ENDF HAL_USB_SEND

; Function: HAL_USB_SEND_PROGMEM
; Inputs:     r16 - EP Number
;             r23:r22 - Progmem Data Pointer
;             r25:r24 - Byte Count  
FUNC HAL_USB_SEND_PROGMEM
  PUSH_MANY r18, r19, XL, XH, ZL, ZH
    movw    ZL, r22                             ; Z = Flash Pointer
    movw    r18, r24                            ; Backup Byte count r19:r18
    
    tst     r16
    brne    _ep1_buf
    ldi2    XL, USB0_EP0_BUF_IN
    jmp     _copy_loop
  _ep1_buf:
    ldi2    XL, USB0_EP1_BUF_IN
    
  _copy_loop:
    sbiw    r24, 0
    breq    _copy_done
    lpm     r0, Z+
    st      X+, r0
    sbiw    r24, 1
    jmp     _copy_loop
    
  _copy_done:
    movw    r24, r18                            ; Restore Byte Count
    call    HAL_USB_SEND
  POP_MANY ZH, ZL, XH, XL, r19, r18
ENDF HAL_USB_SEND_PROGMEM

; Macro: HAL_USB_ADDRESS_SET
; Description: Set USB Device Address
; Parameters:  addr - Device Address
.macro HAL_USB_ADDRESS_SET addr
    sts     USB0_ADDRESS, \addr
    ;ldi     r24, 1
    ;sts     USB_ADDR_PENDING, r24
    ldi     r16, 0
    ldi2    r22, 0
    ldi2    r24, 0
    call    HAL_USB_SEND                   ; Status stage: send ZLP
    ;_STR("USB_REQUEST_SET_ADDRESS:")$ _STR_X(\addr)$ _STRNR()
.endm

; Macro: HAL_USB_CONFIGURATION_SET
; Description: Set USB Device Configuration
; Parameters:  config - Configuration Number
.macro HAL_USB_CONFIGURATION_SET config
    _STR("USB_REQUEST_SET_CONFIGURATION:")$ _STR_X(\config)$ _STRNR()
    ldi     r16, 0
    ldi2    r22, 0
    ldi2    r24, 0
    call    HAL_USB_SEND                   ; Status stage: send ZLP
    ldi     r24, USB_STATUS_CONFIGURED
    sts     USB0_STATUS, r24
.endm

; Macro: HAL_USB_EP_STALL
; Description: Stall USB Endpoint
; Parameters:  epnum - Endpoint Number
.macro HAL_USB_EP_STALL epnum
  PUSH_MANY YL, YH
    ldi2    YL, USB0_EP_TABLE + USB_FIFO_OFFSET + (16*\epnum)
    ldd     r16, Y+USB_EP_OUT_CTRL
    ori     r16, USB_DOSTALL_bm
    std     Y+USB_EP_OUT_CTRL, r16
    ;ldd     r16, Y+USB_EP_IN_CTRL
    ;ori     r16, USB_DOSTALL_bm
    ;std     Y+USB_EP_IN_CTRL, r16
  POP_MANY YH, YL
.endm

; Macro: HAL_USB_SETUP
; Description: Setup USB Endpoints for Control Transfer
; Parameters:  table - Endpoint Table Pointer
;              ep0_out - EP0 Out Buffer Pointer
;              ep0_in - EP0 In Buffer Pointer
;              maxep - Max Endpoint Number
.macro HAL_USB_SETUP table, ep0_out, ep0_in, maxep
  PUSH_MANY r22, r23, r24, r25, YL, YH
    ldi2    YL, \table+32                                      ; Point to EP table
    sts2    USB0_EPPTR, YL
    ldi     r16, 0x1F                                           ; Reset FIFO pointers during setup
    sts     USB0_FIFORP, r16
    sts     USB0_FIFOWP, r16
    
    sts     USB0_STATUS, __zero_reg__                      ; Detached
    sts     USB0_INTFLAGSA, __full_reg__                        ; Clear pending interrupts
    sts     USB0_INTFLAGSB, __full_reg__
    ldi     r16, USB_RESET_bm                                   ; Enable Reset interrupt
    sts     USB0_INTCTRLA, r16
    ldi     r16, USB_TRNCOMPL_bm | USB_SETUP_bm                 ; Enable Setup and Trans Complete interrupts
    sts     USB0_INTCTRLB, r16
    ldi     r16, (USB_ENABLE_bm | USB_STFRNUM_bm | \maxep)
    sts     USB0_CTRLA, r16
    
    ldi     r16, USB_TYPE_CONTROL_gc | USB_BUFSIZE_DEFAULT_BUF64_gc
    ldi2    r22, \ep0_out
    ldi2    r24, \ep0_in
    call    HAL_USB_EP_CONFIG
  POP_MANY YH, YL, r25, r24, r23, r22
.endm

; Macro: HAL_USB_SETUP_EP
; Description: Setup USB Endpoints for Bulk/Interrupt Transfer
; Parameters:  epnum - Endpoint Number
;              buf_out - EP Out Buffer Pointer
;              buf_in - EP In Buffer Pointer
.macro HAL_USB_SETUP_EP epnum, buf_out, buf_in
  PUSH_MANY r22, r23, r24, r25, YL, YH
    lds2    YL, USB0_EPPTR
    adiw    YL, 16 * \epnum
    ldi     r16, USB_TYPE_BULKINT_gc | USB_BUFSIZE_DEFAULT_BUF64_gc
    ldi2    r22, \buf_out
    ldi2    r24, \buf_in
    call    HAL_USB_EP_CONFIG
  POP_MANY YH, YL, r25, r24, r23, r22
.endm

; Function: HAL_USB_EP_CONFIG
; Inputs:     r16     - Control Byte
;             r23:r22 - EP Out Buffer Pointer
;             r25:r24 - EP In Buffer Pointer 
FUNC HAL_USB_EP_CONFIG
    std2    Y, USB_EP_OUT_DATAPTR, r22
    std2    Y, USB_EP_IN_DATAPTR, r24
    std     Y+USB_EP_OUT_CTRL, r16
    std     Y+USB_EP_IN_CTRL, r16
ENDF HAL_USB_EP_CONFIG

; Macro: HAL_USB_RESET
.macro HAL_USB_RESET
    sts     USB0_ADDR, __zero_reg__                     ; Reset Hardware Device Address
    sts     USB0_ADDRESS, __zero_reg__                  ; Reset Device Address
    sts     USB0_INTFLAGSA, __full_reg__                ; Clear Reset interrupt
    ;sts     USB0_FIFORP, __zero_reg__                   ; Reset FIFO pointers
    ;sts     USB0_FIFOWP, __zero_reg__                   ; Reset FIFO pointers
    
    _USB_WAIT_RMW                                       
    sts     USB0_STATUS0_OUTCLR, __full_reg__           ; Reset EP0 OUT status: clear all flags and set toggle to DATA0
    _USB_WAIT_RMW
    sts     USB0_STATUS0_INCLR, __full_reg__            ; Reset EP0 IN status: clear all flags and set toggle to DATA1
    ; _USB_WAIT_RMW
    ; ldi     r16, USB_TOGGLE_bm
    ; sts     USB0_STATUS0_INSET, r16
    
    _USB_WAIT_RMW
    sts     USB0_STATUS1_OUTCLR, __full_reg__           ; Clear all flags
    _USB_WAIT_RMW
    sts     USB0_STATUS1_INCLR, __full_reg__            ; Clear all flags

    lds     r16, USB0_STATUS
    cpi     r16, USB_STATUS_ATTACHED
    brlo    0f
    ldi     r16, USB_STATUS_POWERED
    sts     USB0_STATUS, r16
  0:
.endm

;Macro: HAL_USB_STATUS_CLEAR
;Description: Clear Status EP number
;Parameters:  bm     - Bit Mask
;             regs   - registers list
.macro HAL_USB_STATUS_CLEAR bm, regs:vararg
    ldi     r16, \bm

    .irp    reg, \regs
      .if     \reg == 0
        .error "DEBUG: bm=\bm, reg=\reg, regs=\regs"
      .endif
      _USB_WAIT_RMW
      sts     \reg, r16
    .endr

.endm

;Macro: HAL_USB_EP_CLEAR
;Description: Clear EP Clear
;Parameters:  ctrl_reg - Control Register
;             bm       - Bit Mask
.macro HAL_USB_EP_CLEAR ctrl_reg, bm
    _USB_WAIT_RMW
    ldi     r16, \bm
    sts     \ctrl_reg, r16
.endm

; Macro: HAL_USB_ATTACH
; Description: Attach the USB Device to the Bus
; Parameters:  none
.macro HAL_USB_ATTACH
    ldi     r16, USB_STATUS_ATTACHED                    ; Attached
    sts     USB0_STATUS, r16                       
    ;sts     USB0_EP0_STATE, __zero_reg__                 ; Reset EP0 state
    ldi     r16, USB_ATTACH_bm                          ; Enable USB module
    sts     USB0_CTRLB, r16
    _STR("_____ ATTACH\n\r")
.endm

; Macro: HAL_USB_DETACH
; Description: Detach the USB Device from the Bus
; Parameters:  none
.macro HAL_USB_DETACH
    sts     USB0_STATUS, __zero_reg__                   ; USB_STATUS_DETACHED
    sts     USB0_CTRLB, __zero_reg__                    ; Disable USB module
    ;sts     USB0_EP0_STATE, __zero_reg__                 ; Reset EP0 state
    _STR("_____ DETACH\n\r")
.endm

#include "usb_ep0.S"

#endif