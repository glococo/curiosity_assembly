; Core: avr128db48
; Target: AVR128DB48 CURIOSITY NANO eval board
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      24000
#define CORE_CLOCK_OSC32K     0x8000 | 32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN3_bm
#define BOARD_LED_PORT        PORTB
#define BOARD_BUTTON_PIN      PIN2_bm
#define BOARD_BUTTON_PORT     PORTB

; USART Config
#define USART                 USART3
#define USART_TX              PIN0_bm
#define USART_RX              PIN1_bm
#define USART_PORT            PORTB
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
  HAL_BOARD_SETUP:
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r18, 0x09<<2
    ldi     r19, 0xD8                   ; Unlock CPU_CCP register
    sts     CPU_CCP, r19
    sts     CLKCTRL_OSCHFCTRLA, r18

    ; HAL SPEED AWARENESS
    ldi     r18, 0
    rcall   HAL_CORE_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    ldi     r18, USART_TX                           ; PIN USART_TX output
    sts     _(USART_PORT, _DIRSET), r18             ;
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)      ; USART Enable
    sts     _(USART,_CTRLB), r18                    ;

    ; PIN LED CONFIG
    ldi     r18, BOARD_LED_PIN                      ; Enable BOARD_LED_PIN output
    sts     _(BOARD_LED_PORT, _DIRSET), r18

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                               ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN2CTRL), r18
ENDF HAL_BOARD_SETUP
