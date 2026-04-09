; Core: avr128db48
; Datasheet: DS40002247B
; Target: AVR128DB48 CURIOSITY NANO eval board
; Target datasheet: DS50003037A
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      24000
#define CORE_CLOCK_OSC32K     32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN3_bp
#define BOARD_LED_PORT        PORTB
#define BOARD_BUTTON_PIN      PIN2_bp
#define BOARD_BUTTON_PORT     PORTB

; USART Config
#define USART                 USART3
#define USART_TX              PIN0_bp
#define USART_RX              PIN1_bp
#define USART_PORT            PORTB
#define USART_ADDR            USART3_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
    clr     __zero_reg__
    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 24MHZ
    ldi     r22, CLKCTRL_FRQSEL_24M_gc
    rcall   HAL_CLKCTRL_OSCHF_SET
    ; NVMCTRL Unified Memory Map to first page in Devices>32KB flash
    ; (For lds access to .progmem.rodata text)
    sts     NVMCTRL_CTRLB, __zero_reg__

    ; HAL SPEED AWARENESS
    ldi4    r22, BOARD_CLOCK_MAIN
    sts4    HAL_CLK_MAIN_KHZ, r22

    ldi     r22, 0
    rcall   HAL_CLKCTRL_PRESCALER
    rcall   HAL_USART_BAUDRATE_UPD

    ; USART CONFIG
    _PORT_DIR(USART_PORT, USART_TX)                       ; Set USART_TX PIN as OUTPUT
    ldi     r18, USART_TXEN_bm | (USART_DOUBLE_SPEED<<1)  ; USART Enable
    sts     _(USART,_CTRLB), r18                          ;

    ; PIN LED CONFIG
    _PORT_DIR(BOARD_LED_PORT, BOARD_LED_PIN)              ; Set PIN as OUTPUT

    ; PIN BUTTON CONFIG
    ldi     r18, 0x0B                                     ; Config BOARD_BUTTON/SW0 Pin
    sts     _(BOARD_BUTTON_PORT, _PIN2CTRL), r18
ENDF HAL_BOARD_SETUP




