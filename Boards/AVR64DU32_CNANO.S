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
#define BOARD_LED_PIN         PIN2_bp
#define BOARD_LED_PORT        PORTF
#define BOARD_LED_VPORT       VPORTF
#define BOARD_BUTTON_PIN      PIN6_bp
#define BOARD_BUTTON_PORT     PORTF
#define BOARD_BUTTON_VPORT    VPORTF

; USART Config
#define USART                 USART1
#define USART_TX              PIN6_bp
#define USART_RX              PIN7_bp
#define USART_PORT            PORTD
#define USART_VPORT           VPORTD
#define USART_ADDR            USART1_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
  HAL_BOARD_SETUP:
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r22, CLKCTRL_FRQSEL_24M_gc
    rcall   HAL_CLKCTRL_OSCHF_SET

    ; HAL SPEED AWARENESS
    ldi4    r22, BOARD_CLOCK_MAIN
    sts4    HAL_CLK_MAIN_KHZ, r22

    ldi     r22, 0
    rcall   HAL_CLKCTRL_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    HAL_PORTMUX_ROUTEA( USART, 1, ALT2 )
    sbi     _(USART_VPORT, _DIR), USART_TX
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)      ; USART Enable
    sts     _(USART,_CTRLB), r18                      ;

    ; BOARD PIN LED CONFIG
    sbi     _(BOARD_LED_VPORT, _DIR), BOARD_LED_PIN

    ; BOARD PIN BUTTON CONFIG
    ldi     r18, 0x0B                               ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN6CTRL), r18
ENDF HAL_BOARD_SETUP
