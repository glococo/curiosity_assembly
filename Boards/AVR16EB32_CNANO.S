; Core: avr16eb32
; Datasheet: DS40002522A
; Target: AVR16EB32 CURIOSITY NANO
; Target datasheet: DS50003605B
#include <avr/io.h>
#include "../Defines/ioavr16eb32_gc.S"

; Core Config
#define CORE_CLOCK_OSCHF      20000
#define CORE_CLOCK_OSC32K     32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN5_bp
#define BOARD_LED_PORT        PORTF
#define BOARD_LED_VPORT       VPORTF
#define BOARD_BUTTON_PIN      PIN6_bp
#define BOARD_BUTTON_PORT     PORTF
#define BOARD_BUTTON_VPORT    VPORTF

; USART Config
#define USART                 USART0
#define USART_TX              PIN1_bp
#define USART_RX              PIN2_bp
#define USART_PORT            PORTC
#define USART_VPORT           VPORTC
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

    ; TWI CONFIG
    HAL_PORTMUX_ROUTEA( TWI, 0, DEFAULT )                 ; Ensure TWI0 is in PA2/PA3

    ; USART CONFIG
    HAL_PORTMUX_ROUTEA( USART, 0, ALT4 )                  ; Ensure USART0 is in PC1/PC2/PC3)
    sbi     _(USART_VPORT, _DIR), USART_TX

    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)  ; USART Enable
    sts     _(USART,_CTRLB), r18                          ;

    ; PIN LED CONFIG
    sbi     _(BOARD_LED_VPORT, _DIR), BOARD_LED_PIN

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                                     ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN6CTRL), r18
ENDF HAL_BOARD_SETUP
