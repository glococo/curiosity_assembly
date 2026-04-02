; -----------------------------------------------------------------------------
; File: Examples/07_RTC/msg_rtc.S
; Description: Provides the `send_msg_rtc` function for the RTC example.
;              Transmits an RTC overflow message via USART.
;
; Example Usage:
;   rcall send_msg_rtc                        ; Send RTC overflow message
; -----------------------------------------------------------------------------

.section    .progmem.rodata
ASCIZ MSG_RTC "RTC OVF fired!\r\n"

; -----------------------------------------------------------------------------
; Function: send_msg_rtc
; Description: Sends a string directly from Flash to the USART (Y).
; Inputs:      Y - Points to the USART Peripheral Base Address
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC send_msg_rtc
    PUSH_MANY XL, XH

    ldi2    XL, MAPPED_PROGMEM_START + MSG_RTC          ; Load MSG_RTC address
    rcall   HAL_PRINT_STR                     ; Push selected string to buffer Z

    POP_MANY XH, XL
ENDF send_msg_rtc
