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
    PUSH_MANY r22, ZL, ZH

    ldiw    ZL, MAPPED_PROGMEM_START + MSG_RTC ; Load MSG_RTC address
    ldi     r22, LENGTH( MSG_RTC )             ; Load string length
    rcall   HAL_USART_SEND_LENGTH              ; Send string: r22=len, Z=data, Y=uart

    POP_MANY ZH, ZL, r22
ENDF send_msg_rtc
