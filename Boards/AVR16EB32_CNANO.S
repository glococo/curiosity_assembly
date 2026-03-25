; Core: avr16eb32
; Datasheet: DS40002522A
; Target: AVR16EB32 CURIOSITY NANO
; Target datasheet: DS50003605B
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      20000
#define CORE_CLOCK_OSC32K     0x8000 | 32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN5_bm
#define BOARD_LED_PORT        PORTF
#define BOARD_BUTTON_PIN      PIN6_bm
#define BOARD_BUTTON_PORT     PORTF

; USART Config
#define USART                 USART0
#define USART_TX              PIN1_bm
#define USART_RX              PIN2_bm
#define USART_PORT            PORTC
#define USART_ADDR            USART0_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
    ; HAL SPEED AWARENESS
    ldi4    r22, BOARD_CLOCK_MAIN
    sts4    HAL_CLK_MAIN_KHZ, r22

    ldi     r22, 0
    rcall   HAL_CLKCTRL_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    ldi     r18, USART_TX                                 ; PIN USART_TX output
    sts     _(USART_PORT, _DIRSET), r18                   ;
    ldi     r18, PORTMUX_USART0_2_bm                      ; 0x04 USART ALT4 func
    sts     PORTMUX_USARTROUTEA, r18                      ;
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)  ; USART Enable
    sts     _(USART,_CTRLB), r18                          ;

    ; PIN LED CONFIG
    ldi     r18, BOARD_LED_PIN                            ; Enable BOARD_LED_PIN output
    sts     _(BOARD_LED_PORT, _DIRSET), r18

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                                     ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN6CTRL), r18
ENDF HAL_BOARD_SETUP
