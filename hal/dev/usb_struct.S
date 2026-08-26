; File: Hal/HAL_USB_STRUCT.S
; Description: USB Device Controller Structs for AVR-DU family.
; Default template

.section .bss
USB0_STATUS:         .byte 0
USB0_ADDRESS:        .byte 0

USB0_EP0_STATE:      .byte 0

.align 2
USB0_EP_TABLE:       .space 290  ; 16*2 FIFO + 32*8 EP + 2 FRAME_NUM
USB0_EP0_BUF_OUT:    .space 64
USB0_EP0_BUF_IN:     .space 64
USB0_EP1_BUF_OUT:    .space 64
USB0_EP1_BUF_IN:     .space 64


