; Target: AVR16EB32 CURIOSITY NANO eval board
#include <avr/io.h>

; Board Config
#define LED_PIN             PIN5_bm
#define LED_PORT            PORTF
#define BUTTON_PIN          PIN6_bm
#define BUTTON_PORT         PORTF
#define USART               USART0
#define USART_TX            PIN1_bm
#define USART_RX            PIN2_bm
#define USART_PORT          PORTC
#define USART_BAUD_RATE     38400
#define USART_DOUBLE_SPEED  1
#define CLOCK_INT_KHZ       20000
#define CLOCK_RTC_HZ        0x8000 | 32768

#include "../Hal/ALL.S"

DEFUN HAL_BOARD_SETUP
  HAL_BOARD_SETUP:
    ; OS SPEED AWARENESS
    ldi     r18, 0
    rcall   HAL_CORE_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    ldi     r18, USART_TX                           ; PIN USART_TX output
    sts     _(USART_PORT, _DIRSET), r18             ;
    ldi     r18, PORTMUX_USART0_2_bm                ; 0x04 USART ALT4 func
    sts     PORTMUX_USARTROUTEA, r18                ;
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)      ; USART Enable
    sts     USART0_CTRLB, r18                       ;

    ; PIN LED CONFIG
    ldi     r18, LED_PIN                            ; Enable LED_PIN output
    sts     _(LED_PORT, _DIRSET), r18

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                               ; Config BUTTON/SW0 Pin
    sts     _(BUTTON_PORT, _PIN6CTRL), r18
  ret
ENDF HAL_BOARD_SETUP
