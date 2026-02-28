; Target: AVR16EB32 CURIOSITY NANO eval board
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
#define LED_PIN             PIN5_bm
#define LED_PORT            PORTF
#define BUTTON_PIN          PIN6_bm
#define BUTTON_PORT         PORTF
#define USART               USART0
#define USART_TX            PIN1_bm
#define USART_RX            PIN2_bm
#define USART_PORT          PORTC
#define USART_BAUD_RATE     9600
#define CLOCK_INT_KHZ       20000
#define CLOCK_RTC_HZ        0x8000 | 32768

#include "_HAL_avr16eb.S"

DEFUN BOARD_SETUP_DEFAULT
  BOARD_SETUP_DEFAULT:
    ldi     r16, 0
    rcall   HAL_CPU_SPEED
    rcall   HAL_USART_UPDATE_BAUDRATE

    ldi     r16, USART_TX                   ; PIN USART_TX output
    sts     _(USART_PORT, _DIRSET), r16     ;
    ldi     r16, PORTMUX_USART0_2_bm        ; 0x04 USART ALT4 func
    sts     PORTMUX_USARTROUTEA, r16        ;
    ldi     r16,  USART_TXEN_bm             ; USART Enable
    sts     USART0_CTRLB, r16               ;

    ldi     r16, LED_PIN                    ; Enable LED_PIN output
    sts     _(LED_PORT, _DIRSET), r16
    sts     _(LED_PORT, _OUTTGL), r16

    ldi     r16, 0x0B                       ; Config BUTTON/SW0 Pin
    sts     _(BUTTON_PORT, _PIN6CTRL), r16
  ret
ENDF BOARD_SETUP_DEFAULT
