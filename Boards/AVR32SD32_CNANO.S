; Core: avr32sd32
; Datasheet: DS40002629A
; Target: AVR32SD32 CURIOSITY NANO
; Target datasheet: DS50003842B
#include <avr/io.h>

; Core Config
#define CORE_CLOCK_OSCHF      20000
#define CORE_CLOCK_OSC32K     32768

; Board Config
#define BOARD_CLOCK_MAIN      CORE_CLOCK_OSCHF
#define BOARD_CLOCK_RTC       CORE_CLOCK_OSC32K
#define BOARD_LED_PIN         PIN2_bp
#define BOARD_LED_PORT        PORTD
#define BOARD_BUTTON_PIN      PIN2_bp
#define BOARD_BUTTON_PORT     PORTF

; USART Config
#define USART_CONFIGURED
#define USART                 USART0
#define USART_TX              PIN4_bp
#define USART_RX              PIN5_bp
#define USART_PORT            PORTD
#define USART_ADDR            USART0_RXDATAL
#define USART_BAUD_RATE       38400
#define USART_DOUBLE_SPEED    1
#define USART_ALT             ALT3
; TWI Config (default)
#define TWI_CONFIGURED
; SPI Config
#define SPI_CONFIGURED
#define SPI_PORT              PORTA
#define SPI_MOSI              PIN4_bp
#define SPI_MISO              PIN5_bp
#define SPI_SCK               PIN6_bp
#define SPI_SS                PIN7_bp
#define SPI_IRQ_PIN           PIN0_bp
#define SPI_IRQ_PORT          PORTF

#include "../Hal/ALL.S"

FUNC HAL_BOARD_SETUP
  HAL_BOARD_SETUP:
    _ZERO_FULL_INIT()
    _ERRCTRL_INIT()
    ; _ERRCTRL_NOTIFICATION_ONLY()                        ; ERRCTRL developing state

    ; OSCHF set Internal HighFreq Oscilator from 4mhz to 20MHZ
    ldi     r22, CLKCTRL_FRQSEL_20M_gc
    call   HAL_CLKCTRL_OSCHF_SET

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
