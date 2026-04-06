; Core: avr128db48
; Datasheet: DS40002247B
; Target: AVR128DB48 CURIOSITY NANO eval board
; Target datasheet: DS50003037A
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      24000
#define CORE_CLOCK_OSC32K     0x8000 | 32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN3_bp
#define BOARD_LED_PORT        PORTB
#define BOARD_LED_VPORT       VPORTB
#define BOARD_BUTTON_PIN      PIN2_bp
#define BOARD_BUTTON_PORT     PORTB
#define BOARD_BUTTON_VPORT    VPORTB

; USART Config
#define USART                 USART3
#define USART_TX              PIN0_bp
#define USART_RX              PIN1_bp
#define USART_PORT            PORTB
#define USART_VPORT           VPORTB
#define USART_ADDR            USART3_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
  HAL_BOARD_SETUP:
    clr     __zero_reg__
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r22, CLKCTRL_FRQSEL_24M_gc
    rcall   HAL_CLKCTRL_OSCHF_SET

    ; HAL SPEED AWARENESS
    ldi     r22, 0
    rcall   HAL_CLKCTRL_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    sbi     _(USART_VPORT, _DIR), USART_TX
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)      ; USART Enable
    sts     _(USART,_CTRLB), r18                    ;

    ; PIN LED CONFIG
    sbi     _(BOARD_LED_VPORT, _DIR), BOARD_LED_PIN

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                               ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN2CTRL), r18
ENDF HAL_BOARD_SETUP
