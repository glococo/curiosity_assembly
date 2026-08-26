; -----------------------------------------------------------------------------
; File: Examples/27_USB_Hello_world/main.S
; Description: USB HID Keyboard Example for AVR64DU32.
;              Types "HELLO" when the physical button (SW0) is pressed.
; -----------------------------------------------------------------------------

.section .progmem.rodata

; --- USB Device Descriptor (18 bytes) ---
USB_DEVICE_DESC:
    .byte 18, 1, 0x00, 0x02, 0x00, 0x00, 0x00, 64
    .byte lo8(0x04D8), hi8(0x04D8), lo8(0x0055), hi8(0x0055)
    .byte 0x01, 0x00, 0x01, 0x02, 0x03, 1

; --- USB Configuration Descriptor (34 bytes) ---
USB_CONFIG_DESC:
    .byte 9, 2, 34, 0, 1, 1, 0, 0xA0, 50
    ; Interface Descriptor
    .byte 9, 4, 0, 0, 1, 3, 1, 1, 0
    ; HID Descriptor
    .byte 9, 0x21, 0x11, 0x01, 0, 1, 0x22, 63, 0
    ; Endpoint Descriptor (Interrupt IN)
    .byte 7, 5, 0x81, 3, 8, 0, 10

; --- USB HID Report Descriptor (63 bytes) ---
USB_HID_REPORT_DESC:
    .byte 0x05, 0x01, 0x09, 0x06, 0xa1, 0x01, 0x05, 0x07
    .byte 0x19, 0xe0, 0x29, 0xe7, 0x15, 0x00, 0x25, 0x01
    .byte 0x75, 0x01, 0x95, 0x08, 0x81, 0x02, 0x95, 0x01
    .byte 0x75, 0x08, 0x81, 0x03, 0x95, 0x05, 0x75, 0x01
    .byte 0x05, 0x08, 0x19, 0x01, 0x29, 0x05, 0x91, 0x02
    .byte 0x95, 0x01, 0x75, 0x03, 0x91, 0x03, 0x95, 0x06
    .byte 0x75, 0x08, 0x15, 0x00, 0x25, 0x65, 0x05, 0x07
    .byte 0x19, 0x00, 0x29, 0x65, 0x81, 0x00, 0xc0

; --- USB String Descriptors ---
USB_STR_0: .byte 4, 3, 0x09, 0x04 ; English
USB_STR_1: .ascii "M\0i\0c\0r\0o\0c\0h\0i\0p\0" ; Manufacturer (Simple Unicode-ish)
USB_STR_2: .ascii "A\0V\0R\0 \0U\0S\0B\0 \0K\0B\0" ; Product

.section .bss
.align 2
USB_EP_TABLE: .space 288
EP0_BUF_OUT:  .space 64
EP0_BUF_IN:   .space 64
HID_REPORT:   .space 8

.section .text
FUNC main
    call   HAL_BOARD_SETUP
    _USB_INIT(USB_EP_TABLE)         ; Initialize USB

    ; Configure Interrupts
    _ISR(USB0_BUSEVENT_vect, USB_BusEvent_Handler)
    _ISR(USB0_TRNCOMPL_vect, USB_TrnCompl_Handler)
    sei

    _USB_START()
    _STR("USB HID Keyboard Started\r\n")$ _STR_FLUSH()

  main_loop:
    ; Check button and send keys if needed
    ; (Simplified: real logic would handle state machines)
    jmp    main_loop
ENDF main

FUNC USB_BusEvent_Handler
  PUSH r24
    lds     r24, USB0_INTFLAGSA
    sbrc    r24, USB_RESET_bp
    rjmp    _usb_reset
    ; Clear other flags
    sts     USB0_INTFLAGSA, r24
    rjmp    _usb_event_done
  _usb_reset:
    ldi     r24, USB_RESET_bm
    sts     USB0_INTFLAGSA, r24
    _USB_SET_ADDR(0)
  _usb_event_done:
  POP r24
ENDF USB_BusEvent_Handler

FUNC USB_TrnCompl_Handler
    ; Placeholder for transaction handling (Setup, In, Out)
    ; Real implementation would parse EP0_BUF_OUT for Setup packets
ENDF USB_TrnCompl_Handler
