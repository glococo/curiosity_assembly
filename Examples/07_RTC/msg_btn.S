; -----------------------------------------------------------------------------
; File: Examples/07_RTC/msg_btn.S
; Description: Provides the `send_msg_btn` function for the RTC example.
;              Transmits a button interrupt message via USART.
;
; Example Usage:
;   rcall send_msg_btn                        ; Send button interrupt message
; -----------------------------------------------------------------------------

.section    .progmem.rodata
ASCIZ MSG_BTN "Button interrupt fired!\r\n"

; -----------------------------------------------------------------------------
; Function: send_msg_btn
; Description: Sends a string directly from Flash to the USART (Y).
; Inputs:      Y - Points to the USART Peripheral Base Address
; Outputs:     None
; -----------------------------------------------------------------------------
FUNC send_msg_btn
    PUSH_MANY r22, ZL, ZH

    ldiw    ZL, MAPPED_PROGMEM_START + MSG_BTN ; Load MSG_BTN address
    ldi     r22, LENGTH( MSG_BTN )             ; Load string length
    rcall   HAL_USART_SEND_LENGTH              ; Send string: r22=len, Z=data, Y=uart

    POP_MANY ZH, ZL, r22
ENDF send_msg_btn
