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
    PUSH_MANY XL, XH

    ldi2    XL, MAPPED_PROGMEM_START + MSG_BTN          ; Load MSG_BTN address
    rcall   HAL_PRINT_STR                     ; Push selected string to buffer Z

    POP_MANY XH, XL
ENDF send_msg_btn
