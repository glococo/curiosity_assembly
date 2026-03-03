; Target: AVR128DB48 CURIOSITY NANO eval board
; /usr/lib/avr/include/avr/io.h
; https://github.com/avrdudes/avr-libc/ stuff
#include <avr/io.h>
#include "_OS_macro.S"
#include "_MATH_MUL.S"
#include "_MATH_DIV.S"
#include "_MATH_SHIFTS.S"
#include "_OS_delay.S"
; #include "_OS_print.S"

; Board Config
#define LED_PIN             PIN3_bm
#define LED_PORT            PORTB
#define BUTTON_PIN          PIN2_bm
#define BUTTON_PORT         PORTB
#define USART               USART3
#define USART_TX            PIN0_bm
#define USART_RX            PIN1_bm
#define USART_PORT          PORTB
#define USART_BAUD_RATE     38400
#define USART_DOUBLE_SPEED  1
#define CLOCK_INT_KHZ       24000
#define CLOCK_RTC_HZ        0x8000 | 32768

#include "_HAL_AVR_2020.S"

DEFUN BOARD_SETUP_DEFAULT
  BOARD_SETUP_DEFAULT:
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r18, 0x09<<2
    ldi     r19, 0xD8                   ; Unlock CPU_CCP register
    sts     CPU_CCP, r19
    sts     CLKCTRL_OSCHFCTRLA, r18

    ; OS SPEED AWARENESS
    ldi     r18, 0
    rcall   HAL_CORE_PRESCALER
    rcall   HAL_USART_UPDATE_BAUDRATE

    ; USART CONFIG
    ldi     r18, USART_TX                           ; PIN USART_TX output
    sts     _(USART_PORT, _DIRSET), r18             ;
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)      ; USART Enable
    sts     _(USART,_CTRLB), r18                    ;

    ; PIN LED CONFIG
    ldi     r18, LED_PIN                            ; Enable LED_PIN output
    sts     _(LED_PORT, _DIRSET), r18

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                               ; Config BUTTON/SW0 Pin
    sts     _(BUTTON_PORT, _PIN2CTRL), r18
  ret
ENDF BOARD_SETUP_DEFAULT
