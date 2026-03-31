; -----------------------------------------------------------------------------
; File: Examples/07_RTC/main.S
; Description: Demonstrates using the Real-Time Counter (RTC) for periodic events.
;              - Initializes the RTC to fire an interrupt every 3 seconds.
;              - Toggles the message state (HELLO/HOLA) via RTC interrupt or button.
;              - Toggles the board LED and sends the selected string every 1 second.
;
; Example Usage:
;   This is a standalone example. Compile and flash to a supported AVR board.
;   The message "Hello World!" or "Hola Mundo!" will be sent every second.
;   Every 3 seconds, the RTC interrupt will swap the current message.
;   Pressing the board button will also swap the message.
; -----------------------------------------------------------------------------

#include "msg_btn.S"
#include "msg_rtc.S"

; -----------------------------------------------------------------------------
; Function: main
; Description: Application entry point. Initializes hardware, RTC and PIT
;              then enters in sleep and wait for interruptions.
; -----------------------------------------------------------------------------
; 1. Define a 128-byte Dev-Ring-Buffer for USART0 (regular speed)
HAL_DEVICEBUFFER_DEFINE  TX_DEVBUFFER, 128, USART_ADDR

FUNC main
    rcall   HAL_BOARD_SETUP                   ; Basic board and USART initialization
    HAL_DEVICEBUFFER_INIT TX_DEVBUFFER        ; Initialize the USART ring buffer
    HAL_RTC_INIT_MS  3000, 1024, RTC_PRESCALER_DIV1024_gc ; Setup 3s RTC overflow
    HAL_RTC_PIT_ENABLE RTC_PERIOD_CYC16384_gc ; Setup every 32768/16384= 500ms
    sei                                       ; Enable global interrupts

    PRINT_STR "__ CURIOSITY ASSEMBLY __ \r\n"
  loop:
    rcall   HAL_USART_FLUSH_DEVICEBUFFER      ; Drain buffer to USART hardware
    sleep                                     ; Wait for interrupts
    rjmp    loop                              ; Repeat indefinitely

ENDF main

; -----------------------------------------------------------------------------
; ISR: PORT_vect (Button Interrupt)
; Description: Send USART message when the board button is pressed.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START _(BOARD_BUTTON_PORT,_PORT_vect), r18
    rcall   send_msg_btn                      ; Call message sender
    cbi     _(BOARD_BUTTON_VPORT,_INTFLAGS), BOARD_BUTTON_PIN ; Clear the interrupt flag
ISR_END _(BOARD_BUTTON_PORT,_PORT_vect), r18

; -----------------------------------------------------------------------------
; ISR: RTC_PIT_vect (PIT Interrupt)
; Description: Send an USART message state every time the PIT period expires.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START RTC_PIT_vect r18
    ldi     r18, 1<<BOARD_LED_PIN             ; Load LED pin mask
    sts     _(BOARD_LED_PORT,_OUTTGL), r18    ; Toggle LED via hardware register

    ldi     r18, RTC_PI_bm                    ; Load RTC overflow flag mask
    sts     RTC_PITINTFLAGS, r18              ; Clear RTC interrupt flag
ISR_END RTC_PIT_vect r18

; -----------------------------------------------------------------------------
; ISR: RTC_CNT_vect (RTC Overflow Interrupt)
; Description: Toggle LED every time the RTC overflows.
; Inputs:      None
; Outputs:     None
; -----------------------------------------------------------------------------
ISR_START RTC_CNT_vect r18
    rcall   send_msg_rtc                      ; Call RTC message sender

    ldi     r18, RTC_OVF_bm                   ; Load RTC overflow flag mask
    sts     RTC_INTFLAGS, r18                 ; Clear RTC interrupt flag
ISR_END RTC_CNT_vect r18
