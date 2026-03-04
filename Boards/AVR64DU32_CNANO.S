; Target: AVR64DU32 CURIOSITY NANO eval board
; /usr/lib/avr/include/avr/io.h
; https://github.com/avrdudes/avr-libc/ stuff
#include <avr/io.h>
#include "_HAL_Macro.S"
#include "_MATH_MUL.S"
#include "_MATH_DIV.S"
#include "_MATH_SHIFTS.S"
#include "_HAL_Delay.S"
; #include "_HAL_Print.S"

; Board Config
#define LED_PIN             PIN2_bm
#define LED_PORT            PORTF
#define BUTTON_PIN          PIN6_bm
#define BUTTON_PORT         PORTF
#define USART               USART1
#define USART_TX            PIN6_bm
#define USART_RX            PIN7_bm
#define USART_PORT          PORTD
#define USART_BAUD_RATE     38400
#define USART_DOUBLE_SPEED  1
#define CLOCK_INT_KHZ       24000
#define CLOCK_RTC_HZ        0x8000 | 32768

#include "_HAL_AVR_2020.S"

DEFUN HAL_BOARD_SETUP
  HAL_BOARD_SETUP:
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r18, 0x09<<2
    ldi     r19, 0xD8                   ; Unlock CPU_CCP register
    sts     CPU_CCP, r19
    sts     CLKCTRL_OSCHFCTRLA, r18

    ; OS SPEED AWARENESS
    ldi     r18, 0
    rcall   HAL_CORE_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    ldi     r18, USART_TX                           ; PIN USART_TX output
    sts     _(USART_PORT, _DIRSET), r18             ;
    ldi     r18, PORTMUX_USART1_1_bm                ; 0x02 USART ALT2 func
    sts     PORTMUX_USARTROUTEA, r18                ;
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)      ; USART Enable
    sts     USART1_CTRLB, r18                       ;

    ; PIN LED CONFIG
    ldi     r18, LED_PIN                            ; Enable LED_PIN output
    sts     _(LED_PORT, _DIRSET), r18

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                               ; Config BUTTON/SW0 Pin
    sts     _(BUTTON_PORT, _PIN6CTRL), r18
  ret
ENDF HAL_BOARD_SETUP
