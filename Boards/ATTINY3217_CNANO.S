; Core: attiny3217
; Datasheet: DS40002205A
; Target: attiny3217 CURIOSITY NANO
; Target datasheet: DS40002193A
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      20000
#define CORE_CLOCK_OSC32K     32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN3_bp
#define BOARD_LED_PORT        PORTA
#define BOARD_BUTTON_PIN      PIN7_bp
#define BOARD_BUTTON_PORT     PORTB

; USART Config
#define USART_CONFIGURED
#define USART                 USART0
#define USART_TX              PIN2_bp
#define USART_RX              PIN3_bp
#define USART_PORT            PORTB
#define USART_ADDR            USART0_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1
; TWI Config (default)
#define TWI_CONFIGURED
; SPI Config
#define SPI_CONFIGURED
#define SPI_PORT              PORTC
#define SPI_MOSI              PIN2_bp
#define SPI_MISO              PIN1_bp
#define SPI_SCK               PIN0_bp
#define SPI_SS                PIN3_bp
#define SPI_IRQ_PIN           PIN6_bp
#define SPI_IRQ_PORT          PORTB

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
    _ZERO_FULL_INIT()
    _CLOCK_AWARENESS_INIT()                               ; HAL SPEED AWARENESS

    _USART_CONFIG()
    _SPI_CONFIG()
    _TWI_CONFIG()

    ; PIN LED CONFIG
    _PIN_DIR_SET( BOARD_LED_PORT, BOARD_LED_PIN )         ; Set PIN as OUTPUT

    ; PIN BUTTON CONFIG
    ldi     r22, (PORT_PULLUPEN_bm | PORT_ISC_FALLING_gc)
    sts     _PIN_CTRL( BOARD_BUTTON_PORT, BOARD_BUTTON_PIN ), r22  ; Config BOARD_BUTTON/SW0 Pin
ENDF HAL_BOARD_SETUP
