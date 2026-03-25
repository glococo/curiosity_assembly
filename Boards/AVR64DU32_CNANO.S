; Core: avr64du32
; Datasheet: DS40002548
; Target: AVR64DU32 CURIOSITY NANO eval board
; Target datasheet: DS50003671
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      24000
#define CORE_CLOCK_OSC32K     0x8000 | 32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN2_bm
#define BOARD_LED_PORT        PORTF
#define BOARD_BUTTON_PIN      PIN6_bm
#define BOARD_BUTTON_PORT     PORTF

; USART Config
#define USART                 USART1
#define USART_TX              PIN6_bm
#define USART_RX              PIN7_bm
#define USART_PORT            PORTD
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
  HAL_BOARD_SETUP:
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r22, HAL_CLKCTRL_FREQ_24MHZ
    rcall   HAL_CLKCTRL_OSCHF_SET

    ; HAL SPEED AWARENESS
    ldi4    r22, BOARD_CLOCK_MAIN
    sts4    HAL_CLK_MAIN_KHZ, r22

    ldi     r22, 0
    rcall   HAL_CLKCTRL_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    ldi     r18, USART_TX                           ; PIN USART_TX output
    sts     _(USART_PORT, _DIRSET), r18             ;
    ldi     r18, PORTMUX_USART1_1_bm                ; 0x02 USART ALT2 func
    sts     PORTMUX_USARTROUTEA, r18                ;
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)      ; USART Enable
    sts     USART1_CTRLB, r18                       ;

    ; BOARD PIN LED CONFIG
    ldi     r18, BOARD_LED_PIN                      ; Enable BOARD_LED_PIN output
    sts     _(BOARD_LED_PORT, _DIRSET), r18

    ; BOARD PIN BUTTON CONFIG
    ldi     r18, 0x0B                               ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN6CTRL), r18
ENDF HAL_BOARD_SETUP
